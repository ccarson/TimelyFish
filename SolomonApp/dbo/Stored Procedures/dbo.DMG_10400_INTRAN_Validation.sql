 Create Procedure DMG_10400_INTRAN_Validation
	/*Begin Parameters*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21)
	/*End Parameters*/
As
	Set NoCount On
	/*
	This procedure will audit the INTRAN records for a given batch to determine
	if all the necessary fields have values in each of the transaction records.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

-- Error Trapping
DECLARE	@SQLErrorNbr		SmallInt

Declare	@True		Bit,
	@False		Bit
Select	@True 		= 1,
	@False 		= 0

DECLARE	@MAXFISCYR	INTEGER

/*
The inventory batch release will only allow transactions
*/
SELECT	@MAXFISCYR = CAST(SUBSTRING(PERNBR, 1, 4) AS INTEGER) + 5 FROM INSETUP (NOLOCK)

/*
	Solomon Error # 16145 - %s Record (%s) is missing required data in the following field(s):  %s
	This will generate a listing in the event log of every field by record in the batch that has missing fields.
*/

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'ACCT'
            From INTran
            Where   DataLength(RTrim(Acct)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'CPNYID'
            From INTran
            Where   DataLength(RTrim(CpnyID)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'FISCYR'
            From INTran
            Where   DataLength(RTrim(FiscYr)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'INVTACCT'
            From INTran
            Where   DataLength(RTrim(InvtAcct)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'INVTID'
            From INTran
            Where   DataLength(RTrim(InvtID)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'INVTSUB'
            From INTran
            Where   DataLength(RTrim(InvtSub)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'INVTMULT'
            From INTran
            Where   InvtMult = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'JRNLTYPE'
            From INTran
            Where   DataLength(RTrim(JrnlType)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'LINEREF'
            From INTran
            Where   DataLength(RTrim(LineRef)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'PERENT'
            From INTran
            Where   DataLength(RTrim(PerEnt)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'PERPOST'
            From INTran
            Where   DataLength(RTrim(PerPost)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'SUB'
            From INTran
            Where   DataLength(RTrim(Sub)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'TRANTYPE'
            From INTran
            Where   DataLength(RTrim(TranType)) = 0
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'SITEID'
            From INTran
            Where   (S4Future09 = 0 And DataLength(Rtrim(SiteID)) = 0)
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'WHSELOC'
            From INTran
            Where   (S4Future09 = 0 And DataLength(RTrim(WhseLoc)) = 0)
		AND BATNBR = @BATNBR

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', RECORDID, 'TOWHSELOC'
	FROM	INTRAN JOIN TRNSFRDOC (NOLOCK)
		ON INTran.CpnyID = TrnsfrDoc.CpnyID
		And INTRAN.BATNBR = TRNSFRDOC.BATNBR
	WHERE	TRNSFRDOC.TRANSFERTYPE = 1
		AND INTRAN.BATNBR = @BATNBR
		AND DataLength(RTRIM(INTRAN.TOWHSELOC)) = 0

Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
    Select @BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16145, 3, 'INTran', INTRAN.RECORDID, 'TOSITEID'
	FROM	INTRAN JOIN TRNSFRDOC (NOLOCK)
		ON INTran.CpnyID = TrnsfrDoc.CpnyID
		And INTRAN.BATNBR = TRNSFRDOC.BATNBR
	WHERE	TRNSFRDOC.TRANSFERTYPE = 1
		AND INTRAN.TRANTYPE = 'TR'
		AND INTRAN.BATNBR = @BATNBR
		AND DataLength(RTRIM(INTRAN.TOSITEID)) = 0

IF	EXISTS(SELECT BATNBR FROM IN10400_RETURN WHERE BATNBR = @BATNBR AND COMPUTERNAME = @USERADDRESS)
Begin
/*
	Solomon Error # 16088 - Required field values missing in '%s' record for Batch '%s'.  The batch will not be released.
*/
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01)
	Values
		(@BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16088, 2,
		 'INTran', @BatNbr)
	Goto Abort
End

IF EXISTS(	SELECT	BATNBR
			FROM	INTRAN
			WHERE	CAST(FISCYR AS INTEGER) > @MAXFISCYR
				AND BatNbr = @BatNbr)
Begin
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01, Parm02)
	Values
		(@BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16121, 3,
		 'INTran', @BatNbr, CAST(@MAXFISCYR AS CHAR(4)))
	Goto Abort
End

IF EXISTS(	SELECT	BATNBR
			FROM	INTRAN
			WHERE	BATNBR = @BATNBR
				AND 	((QTY * INVTMULT < 0 AND TRANAMT * INVTMULT > 0)
					OR
					(QTY * INVTMULT > 0 AND TRANAMT * INVTMULT < 0)))
BEGIN
	Insert 	Into IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr)
	Values
		(@BatNbr, @UserAddress, 'DMG_10400_INTRAN_Validation', 16122)
END

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_INTRAN_Validation] TO [MSDSL]
    AS [dbo];

