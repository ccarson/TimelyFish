 CREATE	PROCEDURE ReverseGL @ComputerName CHAR(21), @UserID CHAR(10)

AS
Set NOCOUNT ON
CREATE	TABLE #AutoReverse (OldBatNbr CHAR(10), NewBatNbr CHAR(10), NewPerPost CHAR(6), NewTranDate SMALLDATETIME)

DECLARE	@BorderPeriod	SMALLINT
DECLARE	@DeltaYearBefore	SMALLINT
DECLARE	@DeltaYearAfter	SMALLINT
DECLARE	@i			SMALLINT

DECLARE	@OldBatNbr		CHAR(10)
DECLARE	@NewBatNbr		CHAR(10)
DECLARE	@PerPost		CHAR(6)

DECLARE	@MonthDay		CHAR(4)

DECLARE	@Result		INT
DECLARE	@Error		INT
DECLARE	@BasePl		SMALLINT

SELECT	@BasePl=c.DecPl
FROM	GLSetup g INNER JOIN Currncy c ON c.CuryID=g.BaseCuryID
IF @BasePl IS NULL RETURN

IF (SELECT NbrPer FROM GLSetup) = 1
	SELECT	@BorderPeriod = 0, @DeltaYearBefore = 0, @DeltaYearAfter = 0
ELSE IF EXISTS(SELECT * FROM GLSetup WHERE FiscalPerEnd00 <=
	CASE NbrPer
		WHEN 1  THEN FiscalPerEnd00
		WHEN 2  THEN FiscalPerEnd01
		WHEN 3  THEN FiscalPerEnd02
		WHEN 4  THEN FiscalPerEnd03
		WHEN 5  THEN FiscalPerEnd04
		WHEN 6  THEN FiscalPerEnd05
		WHEN 7  THEN FiscalPerEnd06
		WHEN 8  THEN FiscalPerEnd07
		WHEN 9  THEN FiscalPerEnd08
		WHEN 10 THEN FiscalPerEnd09
		WHEN 11 THEN FiscalPerEnd10
		WHEN 12 THEN FiscalPerEnd11
		WHEN 13 THEN FiscalPerEnd12
	END
	AND '1231' <>
	CASE NbrPer
		WHEN 1  THEN FiscalPerEnd00
		WHEN 2  THEN FiscalPerEnd01
		WHEN 3  THEN FiscalPerEnd02
		WHEN 4  THEN FiscalPerEnd03
		WHEN 5  THEN FiscalPerEnd04
		WHEN 6  THEN FiscalPerEnd05
		WHEN 7  THEN FiscalPerEnd06
		WHEN 8  THEN FiscalPerEnd07
		WHEN 9  THEN FiscalPerEnd08
		WHEN 10 THEN FiscalPerEnd09
		WHEN 11 THEN FiscalPerEnd10
		WHEN 12 THEN FiscalPerEnd11
		WHEN 13 THEN FiscalPerEnd12
	END)
	SELECT	@BorderPeriod = 1, @DeltaYearBefore = BegFiscalYr - 1, @DeltaYearAfter = BegFiscalYr FROM GLSetup
ELSE BEGIN
	SELECT	@i = 1, @BorderPeriod = 0, @DeltaYearBefore = 0, @DeltaYearAfter = 0
	WHILE	@i < (SELECT NbrPer FROM GLSetup)
		IF EXISTS(SELECT * FROM GLSetup WHERE
			CASE @i - 1
				WHEN 0  THEN FiscalPerEnd00
				WHEN 1  THEN FiscalPerEnd01
				WHEN 2  THEN FiscalPerEnd02
				WHEN 3  THEN FiscalPerEnd03
				WHEN 4  THEN FiscalPerEnd04
				WHEN 5  THEN FiscalPerEnd05
				WHEN 6  THEN FiscalPerEnd06
				WHEN 7  THEN FiscalPerEnd07
				WHEN 8  THEN FiscalPerEnd08
				WHEN 9  THEN FiscalPerEnd09
				WHEN 10 THEN FiscalPerEnd10
				WHEN 11 THEN FiscalPerEnd11
			END
			<
			CASE @i
				WHEN 1  THEN FiscalPerEnd01
				WHEN 2  THEN FiscalPerEnd02
				WHEN 3  THEN FiscalPerEnd03
				WHEN 4  THEN FiscalPerEnd04
				WHEN 5  THEN FiscalPerEnd05
				WHEN 6  THEN FiscalPerEnd06
				WHEN 7  THEN FiscalPerEnd07
				WHEN 8  THEN FiscalPerEnd08
				WHEN 9  THEN FiscalPerEnd09
				WHEN 10 THEN FiscalPerEnd10
				WHEN 11 THEN FiscalPerEnd11
				WHEN 12 THEN FiscalPerEnd12
			END)
			SELECT	@i = @i + 1
		ELSE
			SELECT	@BorderPeriod = @i + 1, @i = NbrPer,
				@DeltaYearBefore = BegFiscalYr - 1, @DeltaYearAfter = BegFiscalYr FROM GLSetup
END

BEGIN	TRANSACTION

DECLARE	RBatchCursor CURSOR FOR
	SELECT	BatNbr, PerPost
	FROM	Batch
	WHERE	Module='GL' AND Status='P' AND AutoRev=1
	--v-bbinkl Order By clause added so reverse transaction are in same order consistently
	ORDER BY Module, BatNbr
IF @@ERROR <> 0 GOTO Abort

OPEN	RBatchCursor
IF @@ERROR <> 0 BEGIN DEALLOCATE RBatchCursor GOTO Abort END

FETCH	FROM RBatchCursor INTO @OldBatNbr, @PerPost

WHILE	@@FETCH_STATUS = 0 BEGIN

AutoRef:
UPDATE	GLSetup SET LastBatNbr = RIGHT(REPLICATE('0', LEN(LastBatNbr)) + RTRIM(LTRIM(STR(CONVERT(INT,(LastBatNbr)) + 1))),
	LEN(LastBatNbr)),
	@NewBatNbr = RIGHT(REPLICATE('0', LEN(LastBatNbr)) + RTRIM(LTRIM(STR(CONVERT(INT,(LastBatNbr)) + 1))),
	LEN(LastBatNbr)), @i = LEN(LastBatNbr)
IF @@ERROR <> 0 BEGIN CLOSE RBatchCursor DEALLOCATE RBatchCursor GOTO Abort END
IF EXISTS(SELECT * FROM Batch WHERE Module='GL' AND BatNbr=@NewBatNbr) AND @NewBatNbr<=REPLICATE('9', @i)
	GOTO AutoRef

INSERT	Batch
	(Acct, AutoRev, AutoRevCopy, BalanceType, BankAcct, BankSub, BaseCuryID, BatNbr, BatType, clearamt, Cleared, CpnyID,
	Crtd_DateTime, Crtd_Prog, Crtd_User, CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt, CuryDrTot, CuryEffDate,
	CuryId, CuryMultDiv, CuryRate, CuryRateType, Cycle, DateClr, DateEnt, DepositAmt, Descr, DrTot, EditScrnNbr,
	GLPostOpt, JrnlType, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NbrCycle, NoteID, OrigBatNbr, OrigCpnyID,
	OrigScrnNbr, PerEnt, PerPost, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
	S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, Status, Sub, User1, User2, User3, User4,
	User5, User6, User7, User8, VOBatNbrForPP)
SELECT	Acct, 0, 1, BalanceType, BankAcct, BankSub, b.BaseCuryID, @NewBatNbr, BatType, ClearAmt, Cleared, b.CpnyID,
	GETDATE(), '01560', @UserID, DrTot, CtrlTot, CuryDrTot, CuryCtrlTot, CuryDepositAmt, CuryCrTot, CuryEffDate,
	CuryID, CuryMultDiv, CuryRate, CuryRateType, Cycle, DateClr, DateEnt, DepositAmt, Descr, CrTot, EditScrnNbr,
	GLPostOpt, JrnlType, b.LedgerID, GETDATE(), '01560', @UserID, 'GL', NbrCycle, b.NoteID, @OldBatNbr, OrigCpnyID,
	OrigScrnNbr, PerEnt,
	CONVERT(CHAR(4),(CONVERT(INT,SUBSTRING(PerPost,1,4))*NbrPer+CONVERT(INT,SUBSTRING(PerPost,5,2)))/NbrPer)+
	RIGHT('0'+RTRIM(CONVERT(CHAR(2),(CONVERT(INT,SUBSTRING(PerPost,1,4))*NbrPer+CONVERT(INT,SUBSTRING(PerPost,5,2)))%NbrPer+1)),2),
	1, b.S4Future01, b.S4Future02, b.S4Future03, b.S4Future04, b.S4Future05, b.S4Future06,
	b.S4Future07, b.S4Future08, b.S4Future09, b.S4Future10, b.S4Future11, b.S4Future12, 'U', Sub, b.User1, b.User2, b.User3, b.User4,
	b.User5, b.User6, b.User7, b.User8, b.VOBatNbrForPP
FROM	Batch b CROSS JOIN GLSetup
WHERE	Module = 'GL' AND BatNbr = @OldBatNbr
IF @@ERROR<>0 OR @@ROWCOUNT<>1 BEGIN CLOSE RBatchCursor DEALLOCATE RBatchCursor GOTO Abort END

SELECT	@MonthDay = CASE CONVERT(INT,SUBSTRING(PerPost,5,2))
		WHEN 1  THEN FiscalPerEnd00
		WHEN 2  THEN FiscalPerEnd01
		WHEN 3  THEN FiscalPerEnd02
		WHEN 4  THEN FiscalPerEnd03
		WHEN 5  THEN FiscalPerEnd04
		WHEN 6  THEN FiscalPerEnd05
		WHEN 7  THEN FiscalPerEnd06
		WHEN 8  THEN FiscalPerEnd07
		WHEN 9  THEN FiscalPerEnd08
		WHEN 10 THEN FiscalPerEnd09
		WHEN 11 THEN FiscalPerEnd10
		WHEN 12 THEN FiscalPerEnd11
		WHEN 13 THEN FiscalPerEnd12
	END
FROM	Batch CROSS JOIN GLSetup
WHERE	Module = 'GL' AND BatNbr = @OldBatNbr
IF @@ERROR<>0 BEGIN CLOSE RBatchCursor DEALLOCATE RBatchCursor GOTO Abort END

INSERT	#AutoReverse (OldBatNbr, NewBatNbr, NewPerPost, NewTranDate)
SELECT	@OldBatNbr, @NewBatNbr,
	CONVERT(CHAR(4),(CONVERT(INT,SUBSTRING(PerPost,1,4))*NbrPer+CONVERT(INT,SUBSTRING(PerPost,5,2)))/NbrPer)+
	RIGHT('0'+RTRIM(CONVERT(CHAR(2),(CONVERT(INT,SUBSTRING(PerPost,1,4))*NbrPer+CONVERT(INT,SUBSTRING(PerPost,5,2)))%NbrPer+1)),2),
	CASE @MonthDay WHEN '0229' THEN
	CONVERT(SMALLDATETIME,CONVERT(CHAR(4),CONVERT(INT,SUBSTRING(PerPost,1,4))+
	CASE WHEN CONVERT(INT,SUBSTRING(PerPost,5,2))<@BorderPeriod THEN @DeltaYearBefore ELSE @DeltaYearAfter END)+
	'0301',112) ELSE
	DATEADD(day,1,CONVERT(SMALLDATETIME,CONVERT(CHAR(4),CONVERT(INT,SUBSTRING(PerPost,1,4))+
	CASE WHEN CONVERT(INT,SUBSTRING(PerPost,5,2))<@BorderPeriod THEN @DeltaYearBefore ELSE @DeltaYearAfter END)+
	@MonthDay,112)) END
FROM	Batch CROSS JOIN GLSetup
WHERE	Module = 'GL' AND BatNbr = @OldBatNbr
IF @@ERROR<>0 BEGIN CLOSE RBatchCursor DEALLOCATE RBatchCursor GOTO Abort END

FETCH	FROM RBatchCursor INTO @OldBatNbr, @PerPost

END

CLOSE	RBatchCursor

DEALLOCATE RBatchCursor

INSERT	GLTran(Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr, FiscYr,
	IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime, LUpd_Prog,
	LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost,
	Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate, Sub, TaskID,
	TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6, User7, User8)
SELECT	Acct, AppliedDate, BalanceType, BaseCuryID, NewBatNbr, CpnyID, DrAmt, GETDATE(), '01560', @UserID,
	CuryDrAmt, CuryCrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, CrAmt, EmployeeID, ExtRefNbr, SUBSTRING(NewPerPost,1,4),
	IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, GETDATE(), '01560',
	@UserID, 'GL', NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
	CASE WHEN PC_Status = '' OR PC_Status = '0' THEN PC_Status ELSE '1' END, PerEnt, NewPerPost,
	'U', ProjectID, Qty, RefNbr, RevEntryOption, 1, S4Future01, S4Future02,
	CASE S4Future11 WHEN 'O' THEN 0 ELSE ABS(CuryCrAmt-CuryDrAmt) END,
	S4Future04, S4Future05, S4Future06,
	CASE S4Future11 WHEN 'O' THEN '' ELSE NewTranDate END,
	S4Future08, S4Future09, S4Future10,
	CASE S4Future11 WHEN 'O' THEN 'O' ELSE 'C' END,
	S4Future12, ServiceDate, Sub, TaskID,
	NewTranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6, User7, User8
FROM	#AutoReverse r INNER JOIN GLTran g ON g.BatNbr = r.OldBatNbr
WHERE	g.Module = 'GL'
IF @@ERROR<>0 GOTO Abort

DELETE	WrkRelease
WHERE	UserAddress = @ComputerName AND Module='GL'
IF @@ERROR<>0 GOTO Abort

INSERT	WrkRelease (BatNbr, Module, UserAddress)
SELECT	NewBatNbr, 'GL', @ComputerName
FROM	#AutoReverse
IF @@ERROR<>0 GOTO Abort

EXEC pp_01400cashsum @ComputerName, '01560', @UserID, @Result OUTPUT
SELECT	@Error = @@ERROR

DELETE	WrkRelease
WHERE	UserAddress = @ComputerName AND Module='GL'
IF @@ERROR<>0 GOTO Abort
IF @Error <> 0 OR @Result = 0 GOTO ABORT

UPDATE	Batch SET AutoRev=0
FROM	#AutoReverse
WHERE	Batch.Module='GL' AND Batch.BatNbr=#AutoReverse.OldBatNbr

DELETE	WrkPost
WHERE	UserAddress = @ComputerName
IF @@ERROR<>0 GOTO Abort

INSERT	WrkPost (BatNbr, Module, UserAddress)
SELECT	NewBatNbr, 'GL', @ComputerName
FROM	#AutoReverse
IF @@ERROR<>0 GOTO Abort

COMMIT
RETURN

Abort:
ROLLBACK



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ReverseGL] TO [MSDSL]
    AS [dbo];

