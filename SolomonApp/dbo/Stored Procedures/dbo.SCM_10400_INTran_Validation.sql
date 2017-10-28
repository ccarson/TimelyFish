 Create Procedure SCM_10400_INTran_Validation
	@RecordID		Integer,
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@PerNbr			VarChar(6),
	@InitMode		Smallint
As
	Set NoCount On
	/*
	This procedure will audit the INTran records for a given batch to determine
	if all the necessary fields have values in each of the transaction records.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@SQLErrorNbr		SmallInt
	Declare @LineRef		Char(5)

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@MinFiscYr	INTEGER
	Declare	@MaxFiscYr	INTEGER
	Declare @CurrentPeriod INTEGER
	Declare @CurrentYear INTEGER
	Declare @glPostOption VARCHAR(1)
	Declare @glPriorYear INTEGER
	declare @module as VARCHAR(180)
	/*
	The inventory batch release will only allow transactions
	*/

	SELECT @MINFISCYR = CAST(SUBSTRING(PERNBR, 1, 4) AS INTEGER) - 5 FROM INSETUP (NOLOCK)
	SELECT @MAXFISCYR = CAST(SUBSTRING(PERNBR, 1, 4) AS INTEGER) + 5 FROM INSETUP (NOLOCK)
	SELECT @LineRef = LineRef FROM INTran where RecordID = @RecordID
	SELECT @CurrentPeriod = PerNbr FROM INSETUP (NOLOCK)
	SELECT @CurrentYear = CAST(SUBSTRING(PERNBR, 1, 4) AS INTEGER) FROM INSETUP (NOLOCK)
	SELECT @glPostOption = AllowPostOpt FROM GLSETUP (NOLOCK)
	SELECT @glPriorYear = PriorYearPost FROM GLSETUP (NOLOCK)
	Select @module = modpriorpost from GLSETUP (NOLOCK)

	/*
		Solomon Error # 16145 - %s Record (%s) is missing required data in the following field(s):  %s
		This will generate a listing in the event log of every field by record in the batch that has missing fields.
	*/

	Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'ACCT'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(Acct)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'CPNYID'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(CpnyID)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'FISCYR'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(FiscYr)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'INVTACCT'
	            From INTran  (NoLock)
	            Where   DataLength(RTrim(InvtAcct)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'INVTID'
	            From INTran  (NoLock)
	            Where   DataLength(RTrim(InvtID)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'INVTSUB'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(InvtSub)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'INVTMULT'
	            From INTran (NoLock)
	            Where   InvtMult = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'JRNLTYPE'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(JrnlType)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'LINEREF'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(LineRef)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'PERENT'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(PerEnt)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'PERPOST'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(PerPost)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'SUB'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(Sub)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'TRANTYPE'
	            From INTran (NoLock)
	            Where   DataLength(RTrim(TranType)) = 0
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'SITEID'
	            From INTran (NoLock)
	            Where   (S4Future09 = 0 And DataLength(Rtrim(SiteID)) = 0)
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', RecordID, 'WHSELOC'
	            From INTran (NoLock)
	            Where   (S4Future09 = 0 And DataLength(RTrim(WhseLoc)) = 0)
			AND RecordID = @RecordID
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', INTran.RecordID, 'TOWHSELOC'
		FROM	INTran (NoLock) Inner Join TRNSFRDOC (NoLock)
			ON INTran.BATNBR = TRNSFRDOC.BATNBR
			And INTran.CpnyID = TrnsfrDoc.CpnyID
		WHERE	TRNSFRDOC.TRANSFERTYPE = 1
			AND INTran.RecordID = @RecordID
			And INTran.Qty * INTran.InvtMult < 0
			AND DataLength(RTRIM(INTran.TOWHSELOC)) = 0
		Insert 	Into IN10400_RETURN (BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt, Parm00, Parm01, Parm02)
	    Select @BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16145, 3, 'INTran', INTran.RecordID, 'TOSITEID'
		FROM	INTran (NoLock) Inner Join TRNSFRDOC (NoLock)
			ON INTran.BATNBR = TRNSFRDOC.BATNBR
			And INTran.CpnyID = TrnsfrDoc.CpnyID
		WHERE	TRNSFRDOC.TRANSFERTYPE = 1
			AND INTran.TRANTYPE = 'TR'
			AND INTran.RecordID = @RecordID
			And INTran.Qty * INTran.InvtMult < 0
			AND DataLength(RTRIM(INTran.TOSITEID)) = 0
		IF	EXISTS(SELECT BATNBR FROM IN10400_RETURN (NoLock) WHERE BatNbr = @BatNbr AND COMPUTERNAME = @USERADDRESS)
	Begin
	/*
		Solomon Error # 16088 - Required field values missing in '%s' record for Batch '%s'.  The batch will not be released.
	*/
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
			Parm00, Parm01)
		Values
			(@BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16088, 2,
			 'INTran', @BatNbr)
		Goto Abort
	End

	-- Begin Period/Year Checks
	IF EXISTS(	SELECT	BATNBR
				FROM	INTran (NoLock)
				WHERE	PerPost < @CurrentPeriod
					AND RecordID = @RecordID) AND @glPostOption = 'P' AND @InitMode = 0 AND charindex('IN', @module) = 0
	Begin
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt)
		Values
			(@BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 24, 0)
		Goto Abort
	End

	IF EXISTS(	SELECT	BATNBR
				FROM	INTran (NoLock)
				WHERE	CAST(FISCYR AS INTEGER) < @CurrentYear
					AND RecordID = @RecordID) AND @glPriorYear = 1 AND @InitMode = 0
	Begin
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt)
		Values
			(@BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 24, 0)
		Goto Abort
	End

	IF EXISTS(	SELECT	BATNBR
				FROM	INTran (NoLock)
				WHERE	(CAST(FISCYR AS INTEGER) < @MinFiscYr
					OR CAST(FISCYR AS INTEGER) > @MaxFiscYr)
					AND RecordID = @RecordID)
	Begin
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
			Parm00, Parm01, Parm02)
		Values
			(@BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16121, 3,
			 @BatNbr, CAST(@MinFiscYr AS CHAR(4)), CAST(@MaxFiscYr AS CHAR(4)))
		Goto Abort
	End
		IF EXISTS(	SELECT	BATNBR
				FROM	INTran (NoLock)
				WHERE	RecordID = @RecordID
					AND 	((QTY * INVTMULT < 0 AND TRANAMT * INVTMULT > 0)
						OR
						(QTY * INVTMULT > 0 AND TRANAMT * INVTMULT < 0)))
	BEGIN
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, MsgNbr)
		Values
			(@BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16122)
	END
		-- Validate the batch for duplicate lineref in INTran records
	IF EXISTS(	SELECT LineRef, COUNT(*) FROM INTran (nolock)
				WHERE BatNbr = @BatNbr
				      AND LineRef = @LineRef
				GROUP BY LineRef HAVING  COUNT(*) > 1)
	BEGIN
		Insert Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
			Parm00, Parm01, Parm02)
		Values
			(@BatNbr, @UserAddress, 'SCM_10400_INTran_Validation', 16361, 3,
			 @BatNbr, @RecordID, @LineRef)
		Goto Abort
	END
Goto Finish
	Abort:
	Return @False
	Finish:
	Return @True


