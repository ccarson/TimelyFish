 CREATE PROCEDURE pp_OffsetICTran
	@BatNbr char(10),
	@Module char(2),
	@ProgID	char(8),
	@RetCode int Out
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

/* Initial creation by Maria Du
Last modified 6/3/98 by Maria Du */

SET DEADLOCK_PRIORITY  Low
DECLARE @bCpnyID 	char(10),
	@Screen		char(7),
	@bDatabaseName 	char(30),

	@CpnyID 	char(10),
	@Acct		char(10),
	@Sub		char(24),
	@CrAmt		float,
	@DrAmt		float,
	@CuryCrAmt	float,
	@CuryDrAmt	float,
	@LineNbr	smallint,
	@IC_Distr	smallint,

	@FromAcct	char(10),
	@FromSub	char(24),
	@ToAcct		char(10),
	@ToSub		char(24),
	@Module1	char(2),
	@Screen1	char(7),

	@MaxLineNbr	int,
	@NewLineNbr	int,
	@CrTot		float,
	@DrTot		float,
	@CuryCrTot	float,
	@CuryDrTot	float

DECLARE	@BreakFlg	SMALLINT
SELECT	@BreakFlg=0
CREATE	TABLE #Lines (LineNbr SMALLINT)
INSERT	#Lines
SELECT	LineNbr FROM GLTran WHERE Module=@Module AND BatNbr=@BatNbr
IF @@ERROR<>0 GOTO Abort

/***** Load Used GLSetup Fields into variables *****/
DECLARE @PerNbr VarChar ( 6)

Select @PerNbr = PerNbr from GLSetup (NOLOCK)

/***** End Loading Used GLSetup Field into variables *****/

SELECT @bCpnyID=CpnyID, @Screen=EditScrnNbr FROM Batch WHERE BatNbr=@BatNbr and Module=@Module

SELECT @bDatabaseName = DatabaseName FROM vs_Company WHERE CpnyID=@bCpnyID

SELECT @MaxLineNbr = Max(LineNbr) FROM GLTran WHERE BatNbr=@BatNbr and Module=@Module

/* MAH 10/07/99 Commented out because the actual line number will be used for this.
       SELECT @NewLineNbr=@MaxLineNbr */
IF @@ERROR <> 0 GOTO ABORT

/* Set IC_Distribution=1 if FromCompany_database <> ToCompany_database */
UPDATE GLTran
SET IC_Distribution = 1
WHERE BatNbr=@BatNbr and Module=@Module and
	(SELECT DatabaseName FROM vs_Company w WHERE w.CpnyID=GLTran.CpnyID)<>@bDatabaseName

IF @@ERROR <> 0 GOTO ABORT

/* MAH 10/7/99 Added instensitive to declare to enhace performance with large records.  Also added
       statment to elimate the IC trans GL is adding back into the gltran record from being processed. */

DECLARE c_ICTran INSENSITIVE CURSOR FOR
	SELECT CpnyID,Acct,Sub,CrAmt,DrAmt,CuryCrAmt,CuryDrAmt,LineNbr,IC_Distribution
	FROM GLTran
	WHERE BatNbr=@BatNbr and
              Module=@Module and
              CpnyID <> @bCpnyID and
              LineNbr <= @MaxLineNbr and
              Trantype <> 'IC'

OPEN c_ICTran

FETCH NEXT FROM c_ICTran INTO
	@CpnyID,@Acct,@Sub,@CrAmt,@DrAmt,@CuryCrAmt,@CuryDrAmt,@LineNbr,@IC_Distr

WHILE @@FETCH_STATUS = 0
BEGIN
	/* determine which (Module, Screen) should be used to retrieve InterCompany info */
	if exists (select * from vs_InterCompany where FromCompany=@bCpnyID and ToCompany=@CpnyID
						and Module=@Module and Screen=@Screen)
		SELECT @Module1=@Module,@Screen1=@Screen
	else if exists (select * from vs_InterCompany where FromCompany=@bCpnyID and ToCompany=@CpnyID
						and Module=@Module and Screen='ALL')
		SELECT @Module1=@Module,@Screen1='ALL'
	else
		SELECT @Module1='**',@Screen1='ALL'
	/* retrieve InterCompany info */
	IF @IC_Distr=0 	/* FromCompany and ToCompany are in SAME database */
		SELECT @FromAcct=FromAcct, @FromSub=FromSub, @ToAcct=ToAcct, @ToSub=ToSub
		FROM vs_InterCompany
		WHERE FromCompany=@bCpnyID and ToCompany=@CpnyID and Module=@Module1 and Screen=@Screen1
	ELSE /* FromCompany and ToCompany are in DIFFERENT databases */
		SELECT @FromAcct=FromAcct, @FromSub=FromSub, @ToAcct=@Acct, @ToSub=@Sub
		FROM vs_InterCompany
		WHERE FromCompany=@bCpnyID and ToCompany=@CpnyID and Module=@Module1 and Screen=@Screen1

	IF @@ERROR <> 0 GOTO ABORT

	/* Offset each Inter-Company Transaction by inserting two records into GLTran */
		/* MAH 10/7/99  New linenber will add + 1 to the original line number to use dead space
               DSD creates when inserting records instead of adding the IC records
	       to the bottom of the batch.  This was causing a problem when big batches
            were entered during TI. */

	IF @BreakFlg=0 SELECT @NewLineNbr = @LineNbr + 1 ELSE SELECT @NewLineNbr=@NewLineNbr + 1
	WHILE EXISTS(SELECT * FROM #Lines WHERE LineNbr=@NewLineNbr)
		IF @NewLineNbr>=32767 IF @BreakFlg=0 SELECT @NewLineNbr=-32768, @BreakFlg=1 ELSE GOTO Abort
		ELSE SELECT @NewLineNbr=@NewLineNbr+1
	INSERT #Lines VALUES(@NewLineNbr)

	INSERT GLTran /*insert 1 record for FromCompany*/
              (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime,
               Crtd_Prog, Crtd_User, CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv,
               CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id,
               JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime, LUpd_Prog,
               LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
               PC_Status, PerEnt, PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed,
               S4Future01, S4Future02, S4Future03,
	       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
               S4Future11,S4Future12, ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType,
               Units, User1, User2, User3, User4, User5, User6,	User7, User8)
	SELECT Acct=@FromAcct,AppliedDate, BalanceType, BaseCuryID, BatNbr, @bCpnyID,
		CrAmt=@CrAmt, GetDate(), @ProgID, 'Solomon', CuryCrAmt=@CuryCrAmt,
		CuryDrAmt=@CuryDrAmt, CuryEffDate, CuryID,
		CuryMultDiv, CuryRate, CuryRateType, DrAmt=@DrAmt, EmployeeID,
		ExtRefNbr, FiscYr, IC_Distribution=0,Id, JrnlType, Labor_Class_Cd,
		LedgerID, LineID, @NewLineNbr, LineRef, getdate(),@ProgID,'Solomon',
		Module, NoteID, OrigAcct=@Acct,
		OrigBatNbr, OrigCpnyID, OrigSub=@Sub, PC_Flag, PC_ID, PC_Status,
		PerEnt=@PerNbr,  PerPost, Posted, ProjectID, Qty,
		RefNbr, RevEntryOption, Rlsed,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
		S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
		Sub=@FromSub, TaskID, TranDate, TranDesc,
		TranType='IC', Units, User1, User2, User3, User4, User5, User6, User7, User8
	FROM GLTran WHERE BatNbr = @BatNbr and Module=@Module and LineNbr=@LineNbr

	IF @@ERROR <> 0 GOTO ABORT
		/* MAH 10/7/99  New linenber will add + 2 to the original line number to use dead space
               DSD creates when inserting records instead of adding the IC records
	       to the bottom of the batch.  This was causing a problem when big batches
               were entered during TI. */

	SELECT @NewLineNbr = @NewLineNbr + 1
	WHILE EXISTS(SELECT * FROM #Lines WHERE LineNbr=@NewLineNbr)
		IF @NewLineNbr>=32767 IF @BreakFlg=0 SELECT @NewLineNbr=-32768, @BreakFlg=1 ELSE GOTO Abort
		ELSE SELECT @NewLineNbr=@NewLineNbr+1
	INSERT #Lines VALUES(@NewLineNbr)

	INSERT GLTran
             (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime,
               Crtd_Prog, Crtd_User, CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv,
               CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id,
               JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime, LUpd_Prog,
               LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
               PC_Status, PerEnt, PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed,
               S4Future01, S4Future02, S4Future03,
	       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
               S4Future11,S4Future12, ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType,
               Units, User1, User2, User3, User4, User5, User6, User7, User8)
	SELECT Acct=@ToAcct,AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID,
		CrAmt=@DrAmt, GetDate(), @ProgID, 'Solomon', CuryCrAmt=@CuryDrAmt,
		CuryDrAmt=@CuryCrAmt, CuryEffDate, CuryID,
		CuryMultDiv, CuryRate, CuryRateType, DrAmt=@CrAmt, EmployeeID,
		ExtRefNbr, FiscYr, IC_Distribution=0,Id, JrnlType, Labor_Class_Cd,
		LedgerID, LineID, @NewLineNbr, LineRef, getdate(),@ProgID,'Solomon',
		Module, NoteID, OrigAcct=@Acct,
		OrigBatNbr, OrigCpnyID, OrigSub=@Sub, PC_Flag, PC_ID, PC_Status,
		PerEnt=@PerNbr,  PerPost, Posted, ProjectID, Qty,
		RefNbr, RevEntryOption, Rlsed,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
		S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
		Sub=@ToSub, TaskID, TranDate, TranDesc,
		TranType='IC', Units, User1, User2, User3, User4, User5, User6, User7, User8
	FROM GLTran WHERE BatNbr = @BatNbr and Module=@Module and LineNbr=@LineNbr
		IF @@ERROR <> 0 GOTO ABORT
	FETCH NEXT FROM c_ICTran INTO
		@CpnyID,@Acct,@Sub,@CrAmt,@DrAmt,@CuryCrAmt,@CuryDrAmt,@LineNbr,@IC_Distr

END

CLOSE c_ICTran
DEALLOCATE c_ICTran

/* Updating Batch with new CrTot, etc. */
SELECT @CrTot=Sum(CrAmt),@DrTot=Sum(DrAmt),@CuryCrTot=Sum(CuryCrAmt),@CuryDrTot=Sum(CuryDrAmt)
FROM GLTran
WHERE BatNbr=@BatNbr and Module=@Module

IF @@ERROR <> 0 GOTO ABORT

UPDATE Batch
SET CrTot=@CrTot, DrTot=@DrTot, CtrlTot=@CrTot ,
	CuryCrTot=@CuryCrTot, CuryDrTot=@CuryDrTot, CuryCtrlTot=@CuryCrTot
WHERE BatNbr=@BatNbr and Module=@Module

IF @@ERROR <> 0 GOTO ABORT

SELECT @RetCode=0
GOTO FINISH

ABORT:
SELECT @RetCode=-1

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_OffsetICTran] TO [MSDSL]
    AS [dbo];

