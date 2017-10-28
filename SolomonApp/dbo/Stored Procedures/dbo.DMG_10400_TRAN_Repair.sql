 Create Procedure DMG_10400_TRAN_Repair
	@BATNBR		VARCHAR(10),
	@COGSBATNBR	VARCHAR(10)
AS
/*
	This procedure will only be called when a batch gets committed in a partially released status.  This will
	repair the transactions so that after having Inventory Integrity Check processed, the batch can be
	re-released properly.
*/
	SET	NOCOUNT ON

	IF DATALENGTH(RTRIM(@BATNBR)) <> 0
	BEGIN

/*
	If the batch record is still showing at Partially Released, then no General Ledger transactions should have
	been written.
*/
		DELETE	FROM GLTRAN
			WHERE	MODULE = 'IN'
				AND BATNBR = @BATNBR
/*
	Will remove any costing records that may have been created.
*/
		DELETE	FROM INTRAN
			WHERE	BATNBR = @BATNBR
				AND TRANTYPE IN ('CT', 'CG')
/*
	In the case of a one (1) step transfer, a 'TR' transaction record may have been created for the receiving side.
*/
		IF EXISTS(	SELECT	BATNBR
					FROM	TRNSFRDOC
					WHERE	BATNBR = @BATNBR
						AND TRANSFERTYPE = 1)
		BEGIN
			DELETE	FROM INTRAN
				WHERE	BATNBR = @BATNBR
					AND TRANTYPE = 'TR'
					AND DATALENGTH(RTRIM(TOSITEID)) = 0
					AND DATALENGTH(RTRIM(TOWHSELOC)) = 0
		END
/*
	In the case of an kit assembly, a kit record may have been created already.
*/
		IF EXISTS(	SELECT	BATNBR
					FROM	ASSYDOC
					WHERE	BATNBR = @BATNBR)
		BEGIN
			DELETE	FROM INTRAN
				WHERE	BATNBR = @BATNBR
					AND TRANTYPE = 'AS'
					AND DATALENGTH(RTRIM(KITID)) = 0
		END
/*
	Resets the released flag on all remaining INTRAN records.
*/
		UPDATE	INTRAN
			SET	RLSED = 0
			WHERE	BATNBR = @BATNBR
	END
/*
	Was a COGS BATCH begin created?  May not have all of the proper values set.
*/
	IF DATALENGTH(RTRIM(@COGSBATNBR)) <> 0
	BEGIN
		DELETE	FROM	GLTRAN
			WHERE	MODULE = 'IN'
				AND BATNBR = @COGSBATNBR
/*
	For a COGS batch, just set the batch record to a status of VOID.
*/
		UPDATE	BATCH
			SET	STATUS = 'V'
			WHERE	BATNBR = @COGSBATNBR
				AND MODULE = 'IN'
/*
	Need to reset the INTRAN.INSUFFQTY flag and INTRAN.QTYUNCOSTED value on the original costing transactions
	that was being adjusted.
*/
		UPDATE	COST
			SET	INSUFFQTY = 1,
				COST.QTYUNCOSTED = AJ.QTY
			FROM	INTRAN COST JOIN INTRAN AJ
				ON COST.BATNBR = AJ.S4FUTURE01
				AND COST.REFNBR = AJ.S4FUTURE02
				AND COST.LINEREF = AJ.S4FUTURE11
			WHERE	AJ.BATNBR = @COGSBATNBR
				AND AJ.INVTMULT = 1
/*
	Since the Adjustment transactions with be recreated when an attempt is made to re-release the batch,
	the INTRAN records created can be deleted.
*/
		DELETE	FROM INTRAN
			WHERE	BATNBR = @COGSBATNBR
	END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_TRAN_Repair] TO [MSDSL]
    AS [dbo];

