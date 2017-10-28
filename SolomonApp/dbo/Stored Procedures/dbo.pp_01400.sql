 /****** Object:  Stored Procedure dbo.pp_01400    Script Date: 5/20/98 11:22:07 AM ******/
CREATE PROCEDURE pp_01400
	@UserAddress varchar(21),
	@Sol_User varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

Set NoCount ON
SET DEADLOCK_PRIORITY  Low
/*Initial creation by Jerry Johnson
Last modified 10/29/98 by Chuck Schroeder */
DECLARE @Debug INT
SELECT @Debug = CASE WHEN @UserAddress = "GLDebug" THEN 1
                     ELSE 0
                END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    Select 'Debug is on.  Output file will contain all selects.'
    PRINT "Debug...Step 100:  Clear worktables"
  END

/***** Clear all exceptions *****/
delete  WrkReleaseBad where UserAddress = @UserAddress

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 200:  Declare variables"
  END

/***** Load Used GLSetup Values into variables ******/
DECLARE @GLSetPerNbr VarChar ( 6), @AutoRevOpt VarChar ( 1), @UpDateCa SmallInt, @Result INT

Select @GLSetPerNbr = PerNbr, @AutoRevOpt = AutoRevOpt, @UpdateCa = UpdateCa from GLSetup (NOLOCK)

/***** End Loading GLSetup Records *****/

/***** Check for Currency Rounding Situations ******/
BEGIN TRANSACTION

DECLARE @CrDiff FLOAT, @DrDiff FLOAT, @mod CHAR ( 2), @bat CHAR ( 10)
DECLARE @CrLnNbr Int, @DrLnNbr Int, @DecPrec SmallInt

SELECT @CrDiff = 0
SELECT @DrDiff = 0

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 300:  Currency rounding checking"
  END

DECLARE CuryDiffSel Cursor FOR
SELECT ROUND((Batch.CrTot) - (ROUND(SUM(GLTran.CrAmt), Currncy.DecPl)),Currncy.DecPl),
ROUND((Batch.DrTot) - (ROUND(SUM(GLTran.DrAmt), Currncy.DecPl)),Currncy.DecPl), GLTran.Module, GLTran.Batnbr, Currncy.DecPl
from GLTran, Batch, Currncy, WrkRelease
Where Batch.BaseCuryID = Currncy.CuryID AND Batch.Batnbr = GLTran.Batnbr AND Batch.Module = GLTran.Module AND Batch.Batnbr = WrkRelease.Batnbr AND Batch.Module = WrkRelease.Module
GROUP BY GLTran.batnbr, Batch.CrTot, Batch.DrTot, Batch.CuryCrTot, Batch.CuryDrTot, GLTran.LineID, GLTran.Module, Currncy.DecPl
HAVING ((ROUND(SUM(GLTran.CrAmt),Currncy.DecPl) <> ROUND(Batch.CrTot,Currncy.DecPl))
OR (ROUND(SUM(GLtran.DrAmt),Currncy.DecPl) <> ROUND(Batch.DrTot,Currncy.DecPl)))
AND ((ROUND(SUM(GLTran.CuryCrAmt), 5) = ROUND(Batch.CuryCrTot,5))
AND (ROUND(SUM(GLTran.CuryDrAmt),5) = ROUND(Batch.CuryDrTot,5)))

OPEN CuryDiffSel
FETCH CuryDiffSel Into @CrDiff, @DrDiff, @Mod, @Bat, @DecPrec
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @CrLnNbr = Min(LineNbr) FROM GLTran WHERE Module = @mod AND Batnbr = @bat and CrAmt <> 0
	SELECT @DrLnNbr = Min(LineNbr) FROM GLTran WHERE Module = @mod AND Batnbr = @bat and DrAmt <> 0

IF @CrDiff <> 0
       UPDATE GLTran SET CrAmt = ROUND((CrAmt + @CrDiff), @DecPrec) WHERE LineNbr = @CrLnNbr AND Module = @mod AND Batnbr = @bat


IF @DrDiff <> 0
       UPDATE GLTran SET DrAmt = ROUND((DrAmt + @DrDiff), @DecPrec) WHERE LineNbr = @DrLnNbr AND Module = @mod AND Batnbr = @bat

FETCH CuryDiffSel Into @CrDiff, @DrDiff, @Mod, @Bat, @DecPrec
END
CLOSE CuryDiffSel
DEALLOCATE CuryDiffSel
COMMIT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Currency rounding checking finished"
  END
/*****End Cury Rounding Checking****/

/***** Start transaction set. *****/
BEGIN TRANSACTION

DECLARE @ProgID char(8)
SELECT @ProgID='01400'

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 400:  Suspending bathes out of balance"
  END
/***** Check for batches out of balance and suspend them. *****/

 

INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
	SELECT w.BatNbr, w.Module, 6019, w.UserAddress
	FROM WrkRelease w
WHERE BatNbr IN (
	SELECT w.BatNbr
	FROM Batch b, GLTran t, Currncy c, WrkRelease w, Ledger l
	WHERE b.BaseCuryID = c.CuryID AND b.BatNbr = t.BatNbr AND b.Module = t.Module AND b.Module = "GL" AND b.BatNbr = w.BatNbr AND b.Module = w.Module AND b.LedgerID = l.LedgerID AND w.UserAddress = @UserAddress
	GROUP BY w.BatNbr, b.Module, b.CrTot, b.BatType, b.Status, c.DecPl, l.BalRequired
	HAVING ((ABS(CrTot - ROUND(SUM(t.DRAmt), c.DecPl)) > (1/Power(10.0,c.DecPl+1)) AND ABS(CrTot - ROUND(SUM(t.CRAmt), c.DecPl)) > (1/Power(10.0,c.DecPl+1)) AND (dbo.getNonReversNonCorrBatType(w.BatNbr, b.Module, b.batType) = "J" OR l.BalRequired = 0)) OR
		((ABS(CrTot - ROUND(SUM(t.DRAmt), c.DecPl)) > (1/Power(10.0,c.DecPl+1)) OR ABS(CrTot - ROUND(SUM(t.CRAmt), c.DecPl)) > (1/Power(10.0,c.DecPl+1))) AND (dbo.getNonReversNonCorrBatType(w.BatNbr, b.Module, b.batType)  <> "J" AND l.BalRequired = 1))))

IF @@ERROR < > 0 GOTO ABORT

INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
	SELECT DISTINCT w.BatNbr, w.Module, 12341, w.UserAddress
	FROM WrkRelease w INNER JOIN Batch b ON w.BatNbr = b.BatNbr AND w.Module = b.Module
		INNER JOIN GLTran t ON b.BatNbr = t.BatNbr AND b.module = t.module
WHERE t.CpnyID <> b.CpnyID and UserAddress = @UserAddress AND w.Module = 'GL' AND b.JrnlType <> 'IC'
AND NOT EXISTS (SELECT * FROM vp_ShareInterCpnyScreenAll v WHERE v.FromCpny = b.CpnyID AND v.ToCpny = t.CpnyID
		AND v.Screen = b.EditScrnNbr+'00' AND v.Module = b.Module)

IF @@ERROR < > 0 GOTO ABORT

DELETE FROM WrkRelease FROM WrkRelease w, WrkReleaseBad wb
WHERE w.UserAddress = @UserAddress AND wb.UserAddress = @UserAddress
AND w.BatNbr = wb.BatNbr AND w.Module = wb.Module AND w.Module = "GL"

IF @@ERROR < > 0 GOTO ABORT

/***** Check for batches not set to status B and remove records. *****/

INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
	SELECT  w.BatNbr, w.Module, 832, w.UserAddress
	FROM WrkRelease w, Batch b
	WHERE w.UserAddress = @UserAddress AND w.BatNbr = b.BatNbr AND w.Module = b.Module AND w.Module = "GL" AND b.Status <> "B"

IF @@ERROR < > 0 GOTO ABORT

DELETE FROM WrkRelease FROM WrkRelease w, Batch b
WHERE w.UserAddress = @UserAddress AND w.BatNbr = b.BatNbr AND w.Module = b.Module AND w.Module = "GL" AND b.Status <> "B"

IF @@ERROR < > 0 GOTO ABORT

/***** Check for missing batches and remove records. *****/

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 500:  Missing batches should be removed"
  END

INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
	SELECT w.BatNbr, w.Module, 835 ,w.UserAddress
	FROM WrkRelease w
	WHERE NOT EXISTS (SELECT b.Module, b.BatNbr FROM Batch b WHERE b.BatNbr = w.BatNbr AND b.Module = w.Module) AND w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

DELETE WrkRelease from WrkRelease w
 WHERE NOT EXISTS (SELECT Module, BatNbr
                    FROM Batch b
                   WHERE b.batnbr = w.batnbr and b.module = w.module  )
   AND UserAddress = @UserAddress AND Module = "GL"
IF @@ERROR < > 0 GOTO ABORT

/***** Check for batches of type M and process them. *****/

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 600:  Processing M-type batches"
  END

DECLARE @MBatNbr Char(10), @NewBatNbr Char(10)

DECLARE MBatchCursor CURSOR FOR
	SELECT w.BatNbr FROM WrkRelease w, Batch b
	WHERE w.UserAddress = @UserAddress AND w.BatNbr = b.BatNbr AND w.Module = b.Module AND b.Module = "GL" AND dbo.getNonReversNonCorrBatType(w.BatNbr, b.Module, b.batType) = "M"
OPEN MBatchCursor
FETCH NEXT FROM MBatchCursor INTO @MBatNbr
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	IF (@@FETCH_STATUS <> -2)
	BEGIN
		EXEC pp_NextGLBatNbr @NewBatNbr OUTPUT
		IF @@ERROR < > 0 GOTO ABORT

		INSERT WrkRelease (UserAddress, BatNbr, Module)
			VALUES (@UserAddress, @NewBatNbr, "GL")
		IF @@ERROR < > 0 GOTO ABORT

		INSERT Batch (Acct, AutoRev, AutoRevCopy, BalanceType, BankAcct, BankSub, BaseCuryID,
					BatNbr, BatType, clearamt, Cleared, CpnyID, Crtd_DateTime, Crtd_Prog,
					Crtd_User, CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt,
					CuryDrTot, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType,
					Cycle, DateClr, DateEnt, DepositAmt, Descr, DrTot, EditScrnNbr,
					GLPostOpt, JrnlType, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User,
					Module, NbrCycle, NoteID, OrigBatNbr, OrigCpnyID, OrigScrnNbr, PerEnt,
					PerPost, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04,
					S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
					S4Future11, S4Future12, Status, Sub, User1, User2, User3, User4, User5,
					User6, User7, User8, VOBatNbrForPP)
		SELECT Acct, AutoRev, AutoRevCopy, BalanceType, BankAcct, BankSub,BaseCuryID,
			@NewBatNbr, "N", ClearAmt, Cleared, CpnyID, getdate(), @ProgID, @Sol_User,
			CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt,
			CuryDrTot, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, Cycle, DateClr, DateEnt, DepositAmt, Descr, DrTot, EditScrnNbr,
			GLPostOpt, JrnlType, LedgerID, getdate(), @ProgID,@Sol_User,
			Module, NbrCycle, NoteID, @MBatNbr, OrigCpnyID, OrigScrnNbr,
			@GLSetPerNbr, PerPost, Rlsed,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
			"B", Sub, User1, User2, User3, User4, User5, User6, User7, User8, ''
		FROM Batch WHERE BatNbr = @MBatNbr AND Module = "GL"

		IF @@ERROR < > 0 GOTO ABORT

		INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt,
					Crtd_DateTime, Crtd_Prog, Crtd_User, CuryCrAmt, CuryDrAmt,
					CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt,
					EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id,JrnlType,
					Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime,
					LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr,
					OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost,
					Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01,
					S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
					S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
					Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3,
					User4, User5, User6, User7, User8)
		SELECT Acct,AppliedDate, BalanceType, BaseCuryID, @NewBatNbr, CpnyID,
			CrAmt, getdate(), @ProgID,@Sol_User, CuryCrAmt, CuryDrAmt,
			CuryEffDate, CuryID, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
			ExtRefNbr, FiscYr, IC_Distribution,Id, JrnlType, Labor_Class_Cd,
			LedgerID, LineID, LineNbr, LineRef, getdate(), @ProgID,@Sol_User,
			Module, NoteID, OrigAcct,
			OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status,
			@GLSetPerNbr, PerPost, Posted, ProjectID, Qty,
			RefNbr, RevEntryOption, 1,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
			Sub, TaskID, TranDate, TranDesc,
			TranType, Units, User1, User2, User3, User4, User5, User6, User7, User8
		FROM GLTran WHERE BatNbr = @MBatNbr AND Module = "GL"

		IF @@ERROR < > 0 GOTO ABORT

		UPDATE Batch SET Status = "H"
			WHERE BatNbr = @MBatNbr AND Module = "GL"
		IF @@ERROR < > 0 GOTO ABORT

		DELETE FROM WrkRelease
 			WHERE BatNbr = @MBatNbr AND Module = "GL"
		IF @@ERROR < > 0 GOTO ABORT

	END
	FETCH NEXT FROM MBatchCursor INTO @MBatNbr
END
CLOSE MBatchCursor
DEALLOCATE MBatchCursor

/***** Check for auto reversing batches and process them ****/
If @AutoRevOpt = 'R'
BEGIN
  IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 650:  Processing auto reversing batches"
	SELECT w.BatNbr,b.perpost FROM WrkRelease w, Batch b
	 WHERE w.UserAddress = @UserAddress
           AND w.BatNbr = b.BatNbr
           AND w.Module = b.Module
           AND b.Module = "GL" AND b.Autorev= 1
  END

  DECLARE RBatchCursor CURSOR FOR
	SELECT w.BatNbr,b.perpost FROM WrkRelease w, Batch b
	 WHERE w.UserAddress = @UserAddress
   AND w.BatNbr = b.BatNbr
           AND w.Module = b.Module
           AND b.Module = "GL" AND b.Autorev= 1
  DECLARE @cPerPost char(6), @nPerPost char(6), @nTrandate smalldatetime
  DECLARE @cAllPerEnd char(52), @charcurymd char(8)
  declare @pernbr     int,@npernbr int
  declare @BegFiscalYr smallint, @NbrPer smallint
  declare @lastPerEnd char(4), @perEnd char (4),  @fiscalYear char(4), @yearofbegfiscalyear char(4)
  declare @dateOfEndFiscalYear smalldatetime,  @dateOfBegFiscalYear smalldatetime, @datePerEnd smalldatetime

/**** Build an array of all fisc period end dates *****/

  select @cAllPerEnd=FiscalPerEnd00 + FiscalPerEnd01 + FiscalPerEnd02 + FiscalPerEnd03  + FiscalPerEnd04
                   + FiscalPerEnd05 + FiscalPerEnd06 + FiscalPerEnd07 + FiscalPerEnd08  + FiscalPerEnd09
                   + FiscalPerEnd10 + FiscalPerEnd11 + FiscalPerEnd12, @BegFiscalYr=BegFiscalYr, @NbrPer=NbrPer
                   from glsetup (NOLOCK)
  OPEN RBatchCursor
  FETCH NEXT FROM RBatchCursor INTO @MBatNbr, @CPerPost
  WHILE (@@FETCH_STATUS <> -1)
  BEGIN
	IF (@@FETCH_STATUS <> -2)
	BEGIN
		EXEC pp_NextGLBatNbr @NewBatNbr OUTPUT
		EXEC gl_plus_pernbr @cPerPost, @nPerPost OUTPUT

/**** Figure out transaction date. It should be the last date of the this period ****/
/**** plus one day. ****/

               select @pernbr=convert(int,substring(@cPerpost,5,2))
               select @lastPerEnd = substring (@cAllPerEnd,(4 * @NbrPer)-3,4)
               select @perEnd = substring (@cAllPerEnd,(4 * @perNbr)-3,4)
               select @fiscalYear = substring (@cPerpost,1,4)
               if  @lastPerEnd = '1231'
                          select @charcurymd = @fiscalYear + @perEnd

               else
               begin
                  if @BegFiscalYr = 0
                       select @dateOfEndFiscalYear =  convert (smalldatetime, @fiscalYear+@lastPerEnd, 112)
                  else
                       select @dateOfEndFiscalYear =  convert (smalldatetime, convert (char (4), (convert (int, @fiscalYear)) + 1) +@lastPerEnd, 112)
                  select @dateOfBegFiscalYear = dateadd (day, 1, @dateOfEndFiscalYear)
                  select @dateOfBegFiscalYear = dateadd (year, -1, @dateOfBegFiscalYear)
	          select @yearofbegfiscalyear = convert (char (4),@dateOfBegFiscalYear,112)
                  select @datePerEnd = convert (smalldatetime, @yearofbegfiscalyear + @perEnd, 112)
                  if  @datePerEnd<@dateOfBegFiscalYear
                       select  @charcurymd = convert (char(4), convert (int, @yearofbegfiscalyear)+1) + @perEnd
                  else
                       select  @charcurymd = @yearofbegfiscalyear + @perEnd
               end

/**** Bump date by one day. Hardcode exception for period end of 02/29 since dateadd won't ****/
/**** handle on non-leap years. ***/
                if substring(@charcurymd,5,4) = '0229'
                  Begin
                     select @charcurymd = substring(@charcurymd,1,4)+'0301'
                     select @ntrandate = @charcurymd
                   end
                else
                    Begin
                     select @ntrandate = @charcurymd
                     select @ntrandate = dateadd(day,1,@ntrandate)
                    end
                IF @@ERROR < > 0 GOTO ABORT

		INSERT WrkRelease (UserAddress, BatNbr, Module)
			VALUES (@UserAddress, @NewBatNbr, "GL")
		IF @@ERROR < > 0 GOTO ABORT

		INSERT Batch (Acct, AutoRev, AutoRevCopy, BalanceType, BankAcct, BankSub, BaseCuryID,
					BatNbr, BatType, clearamt, Cleared, CpnyID, Crtd_DateTime, Crtd_Prog,
					Crtd_User, CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt,
					CuryDrTot, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType,
					Cycle, DateClr, DateEnt, DepositAmt, Descr, DrTot, EditScrnNbr,
					GLPostOpt, JrnlType, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User,
					Module, NbrCycle, NoteID, OrigBatNbr, OrigCpnyID, OrigScrnNbr, PerEnt,
					PerPost, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04,
					S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
					S4Future11, S4Future12, Status, Sub, User1, User2, User3, User4, User5,
					User6, User7, User8, VOBatNbrForPP)
		SELECT Acct, 0, 1, BalanceType, BankAcct, BankSub,BaseCuryID,
			@NewBatNbr, "N", ClearAmt, Cleared, CpnyID, getdate(), @ProgID, @Sol_User,
			CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt,
			CuryDrTot, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, Cycle, DateClr, DateEnt, DepositAmt, Descr, DrTot, EditScrnNbr,
			GLPostOpt, JrnlType, LedgerID, getdate(), @ProgID,@Sol_User,
			Module, NbrCycle, NoteID, @MBatNbr, OrigCpnyID, OrigScrnNbr,
			PerEnt, @nPerPost, Rlsed,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
			Status, Sub, User1, User2, User3, User4, User5, User6, User7, User8, ''
		FROM Batch WHERE BatNbr = @MBatNbr AND Module = "GL"

		IF @@ERROR < > 0 GOTO ABORT

		INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt,
					Crtd_DateTime, Crtd_Prog, Crtd_User, CuryCrAmt, CuryDrAmt,
					CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt,
					EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id,JrnlType,
					Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime,
					LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr,
					OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost,
					Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01,
					S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
					S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
					Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3,
					User4, User5, User6, User7, User8)

		SELECT Acct,AppliedDate, BalanceType, BaseCuryID, @NewBatNbr, CpnyID,
			DrAmt, getdate(), @ProgID,@Sol_User, CuryDrAmt, CuryCrAmt,
			CuryEffDate, CuryID, CuryMultDiv, CuryRate, CuryRateType, CrAmt, EmployeeID,
			ExtRefNbr, substring(@nPerPost,1,4), IC_Distribution,Id, JrnlType, Labor_Class_Cd,
			LedgerID, LineID, LineNbr, LineRef, getdate(), @ProgID,@Sol_User,
			Module, NoteID, OrigAcct,
			OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status,
			@GLSetPerNbr, @nPerPost, Posted, ProjectID, Qty,
			RefNbr, RevEntryOption, 1,
			S4Future01, S4Future02,
			CASE S4Future11 WHEN 'O' THEN 0 ELSE ABS(CuryCrAmt-CuryDrAmt) END,
			S4Future04, S4Future05, S4Future06,
			CASE S4Future11 WHEN 'O' THEN '' ELSE @nTranDate END,
			S4Future08, S4Future09, S4Future10,
			CASE S4Future11 WHEN 'O' THEN 'O' ELSE 'C' END,
			S4Future12, ServiceDate,
			Sub, TaskID, @nTranDate, TranDesc,
			TranType, Units, User1, User2, User3, User4, User5, User6, User7, User8
		FROM GLTran WHERE BatNbr = @MBatNbr AND Module = "GL"

		IF @@ERROR < > 0 GOTO ABORT

            UPDATE batch set AutoRev = 0 where Module = 'GL' AND
            BatNbr = @MBatNbr

            IF @@ERROR < > 0 GOTO ABORT


	END
	FETCH NEXT FROM RBatchCursor INTO @MBatNbr, @cPerPost
  END
  CLOSE RBatchCursor
  DEALLOCATE RBatchCursor
END

/***** Create New Record in CashSumD if No Matching Record Exist *****/

EXEC pp_01400cashsum @UserAddress, @ProgID, @Sol_User, @Result OUTPUT
IF @Result = 0 GOTO ABORT

UPDATE GLTran
   SET OrigCpnyID=b.CpnyID
  FROM GLTran t, Batch b, WrkRelease w
 WHERE w.BatNbr=b.BatNbr
   and w.Module = b.module
   And b.batnbr = t.batnbr
   and b.Module=t.Module
   and w.Module='GL'
   AND w.UserAddress = @UserAddress

/*Go through GLTran batch by batch to offset intercompany transactions */
IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...Step 700:  Processing InterCompany batches"
  END
DECLARE c_TreatICTran CURSOR FOR
	SELECT distinct w.BatNbr , b.JrnlType
          FROM WrkRelease w, batch b, gltran t
         WHERE UserAddress = @UserAddress and b.Module='GL'
           and w.batnbr = b.batnbr
           and w.module = b.module
           and b.module = t.module
           and b.batnbr = t.batnbr
           and b.JrnlType <> 'IC'
/****   IC trans should be balanced within company and do not need intercompany trans ****/
           and t.cpnyid <> b.cpnyid

DECLARE @cBatNbr char(10), @cJrnlType char(3), @RetCode int

OPEN c_TreatICTran
IF @@ERROR < > 0 GOTO ABORT

FETCH NEXT FROM c_TreatICTran INTO @cBatNbr, @cJrnlType

WHILE @@FETCH_STATUS = 0
BEGIN
	EXECUTE pp_OffsetICTran @cBatNbr, 'GL', @ProgID, @RetCode Out
      IF @RetCode <> 0 GOTO ABORT
	FETCH NEXT FROM c_TreatICTran INTO @cBatNbr, @cJrnlType
END
CLOSE c_TreatICTran
IF @@ERROR < > 0 GOTO ABORT
DEALLOCATE c_TreatICTran


/* SELECT 'WrkRelease', * FROM WrkRelease w WHERE UserAddress = @UserAddress */

/***** When the process is complete, change the appropriate statuses. *****/

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT "Debug...:  Finishing process"
  END
UPDATE Batch
SET Status = "U", Rlsed = 1
FROM Batch b, WrkRelease w
WHERE b.BatNbr = w.BatNbr AND b.Module = w.Module and w.Module='GL'
	AND w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

UPDATE GLTran
SET Posted = "U", Rlsed = 1
FROM GLTran t, WrkRelease w
WHERE t.Module = w.Module AND t.BatNbr = w.BatNbr and w.Module='GL'
	and w.UserAddress=@UserAddress

IF @@ERROR < > 0 GOTO ABORT

COMMIT TRANSACTION

GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_01400] TO [MSDSL]
    AS [dbo];

