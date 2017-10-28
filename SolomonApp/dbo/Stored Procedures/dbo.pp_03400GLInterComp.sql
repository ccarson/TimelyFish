 CREATE PROCEDURE pp_03400GLInterComp @UserAddress VARCHAR(21), @Sol_User Char(10),@Debug INT,
                 @Result INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

DECLARE @Counter  Int
DECLARE @Screen   char(12), @Module   char (2)
DECLARE @FromCpnyID char(10), @FromAcct char(10), @FromSub char(24)
DECLARE @ToCpny   char(10), @ToAcct   char(10),@ToSub   char(24)

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 23000: Update WRK GLTran records Distribution', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Wrk_gltran Gl, WrkRelease w
    WHERE  gl.UserAddress = @UserAddress
           AND w.module = 'AP'
 END
/***** Set IC flags for external db companies *****/
UPDATE Wrk_gltran SET IC_Distribution = CASE c1.DatabaseName
        WHEN c2.DatabaseName THEN 0
        ELSE 1 END
FROM Wrk_gltran t, vs_Company c1, vs_Company c2
WHERE t.CpnyID = c1.CpnyID AND t.FromCpnyID = c2.CpnyID and t.useraddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

/** Fetch info from rows that need intercompany processing **/
DECLARE GL_CSR INSENSITIVE CURSOR  FOR
SELECT DISTINCT FromCpnyID, CpnyID, Screen,  Module
  FROM WRK_GLTRAN
 WHERE FromCpnyID <> CpnyID
   AND UserAddress = @UserAddress

OPEN GL_CSR

FETCH GL_CSR INTO @FromCpnyID, @ToCpny, @Screen,  @Module

WHILE @@FETCH_STATUS = 0
BEGIN
  SELECT @FROMACCT = NULL

  SELECT @FROMACCT=FROMACCT,@FROMSUB=FROMSUB,
         @TOACCT=TOACCT,@TOSUB=TOSUB
    FROM vp_ShareInterCpnyScreenAll v
   WHERE v.FromCpny = @FromCpnyID AND v.ToCpny = @ToCpny
     AND v.Screen = @Screen AND v.Module = @Module

  IF @FROMACCT IS NULL
    BEGIN
      SELECT @Result = 12341
      GOTO ABORT
    END

/***** Pass one for Intercompany *****/
  INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
         CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
         ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
         LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
         PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
         S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
         ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
         User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
  SELECT @FromAcct, min(t.AppliedDate), min(t.BalanceType), min(t.BaseCuryID), min(t.BatNbr), @FromCpnyId, CASE WHEN SUM(convert(dec(28,3),t.cramt) - convert(dec(28,3),t.drAmt)) >0 THEN SUM(convert(dec(28,3),t.cramt) - convert(dec(28,3),t.drAmt)) ELSE 0 END,
         GETDATE(), min(t.Crtd_Prog), min(t.Crtd_User), CASE WHEN SUM(convert(dec(28,3),t.curycramt) - convert(dec(28,3),t.curydrAmt)) >0 THEN SUM(convert(dec(28,3),t.curycramt) - convert(dec(28,3),t.curydrAmt)) ELSE 0 END, CASE WHEN SUM(convert(dec(28,3),t.curydramt) - convert(dec(28,3),t.curycramt)) >0 THEN SUM(convert(dec(28,3),t.curydramt) - convert(dec(28,3),t.CurycrAmt)) ELSE 0 END, min(t.CuryEffDate), min(t.CuryId),
         min(t.CuryMultDiv), min(t.CuryRate), min(t.CuryRateType), CASE WHEN SUM(convert(dec(28,3),t.dramt) - convert(dec(28,3),t.cramt)) >0 THEN SUM(convert(dec(28,3),t.dramt) - convert(dec(28,3),t.crAmt)) ELSE 0 END, min(t.EmployeeID), min(t.ExtRefNbr), min(t.FiscYr),
         0, min(t.Id), min(t.JrnlType), min(t.Labor_Class_Cd), min(t.LedgerID), min(t.LineID), min(t.LineNbr), min(t.LineRef),
         GETDATE(), min(t.LUpd_Prog), min(t.LUpd_User), min(t.Module), 0, min(t.Acct), t.BatNbr, t.CpnyID, min(t.Sub),
         min(t.PC_Flag), min(t.PC_ID), min(t.PC_Status), min(t.PerEnt), min(t.PerPost), min(t.Posted), min(t.ProjectID), min(t.Qty), t.RefNbr,
         min(t.RevEntryOption), min(t.Rlsed), min(t.S4Future01), min(t.S4Future02), min(t.S4Future03), min(t.S4Future04), min(t.S4Future05),
         min(t.S4Future06), min(t.S4Future07), min(t.S4Future08), min(t.S4Future09), min(t.S4Future10), min(t.S4Future11), min(t.S4Future12),
         min(t.ServiceDate), @FromSub, min(t.TaskID), min(t.TranDate), 'Inter-Company Transaction', 'IC', min(t.Units),
         min(t.User1), min(t.User2), min(t.User3), min(t.User4), min(t.User5), min(t.User6), min(t.User7), min(t.User8),
         min(t.FromCpnyID), min(t.Screen), min(t.RecordId), @UserAddress
    FROM Wrk_GLTran t
   WHERE t.FromCpnyID = @FromCpnyID AND t.CpnyID = @ToCpny AND t.FromCpnyID <> t.CpnyID AND
         t.Screen = @Screen AND t.Module = @Module and t.UserAddress = @UserAddress
   GROUP BY t.CpnyID, t.batnbr, t.refnbr
    IF @@ERROR <> 0 GOTO ABORT

/***** Pass two for Intercompany *****/
  INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
         CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
         ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
         LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
         PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
         S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
         ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
         User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
  SELECT @ToAcct, min(t.AppliedDate), min(t.BalanceType), min(t.BaseCuryID),
         t.BatNbr, @ToCpny, CASE WHEN SUM(convert(dec(28,3),t.dramt) - convert(dec(28,3),t.cramt)) >0 THEN SUM(convert(dec(28,3),t.dramt) - convert(dec(28,3),t.crAmt)) ELSE 0 END,
         GETDATE(), min(t.Crtd_Prog), min(t.Crtd_User), CASE WHEN SUM(convert(dec(28,3),t.curydramt) - convert(dec(28,3),t.curycramt)) >0 THEN SUM(convert(dec(28,3),t.curydramt) - convert(dec(28,3),t.CurycrAmt)) ELSE 0 END,  CASE WHEN SUM(convert(dec(28,3),t.curycramt) - convert(dec(28,3),t.curydramt)) >0 THEN SUM(convert(dec(28,3),t.curycramt) - convert(dec(28,3),t.CurydrAmt)) ELSE 0 END, min(t.CuryEffDate), min(t.CuryId),
         min(t.CuryMultDiv), min(t.CuryRate), min(t.CuryRateType), CASE WHEN SUM(convert(dec(28,3),t.cramt) - convert(dec(28,3),t.drAmt)) >0 THEN SUM(convert(dec(28,3),t.cramt) - convert(dec(28,3),t.drAmt)) ELSE 0 END, min(t.EmployeeID), min(t.ExtRefNbr), min(t.FiscYr),
         0, min(t.Id),min( t.JrnlType),min( t.Labor_Class_Cd),min( t.LedgerID),min( t.LineID), min(t.LineNbr),min( t.LineRef),
         GETDATE(),min( t.LUpd_Prog), min(t.LUpd_User), min(t.Module), 0,min( t.Acct), t.BatNbr, t.CpnyID, min(t.Sub),
         min(t.PC_Flag), min(t.PC_ID),min( t.PC_Status),min( t.PerEnt),min( t.PerPost), min(t.Posted), min(t.ProjectID),min( t.Qty), t.RefNbr,
         min(t.RevEntryOption), min(t.Rlsed), min(t.S4Future01), min(t.S4Future02), min(t.S4Future03), min(t.S4Future04), min(t.S4Future05),
         min(t.S4Future06), min(t.S4Future07), min(t.S4Future08), min(t.S4Future09),min( t.S4Future10), min(t.S4Future11), min(t.S4Future12),
         min(t.ServiceDate), @ToSub, min(t.TaskID), min(t.TranDate),
         'Inter-Company Transaction', 'IC', min(t.Units), min(t.User1), min( t.User2), min( t.User3),
         min(t.User4),min( t.User5), min(t.User6), min(t.User7), min(t.User8), min(t.FromCpnyID),
         min( t.Screen), min(t.RecordId), @UserAddress
    FROM Wrk_GLTran t
   WHERE t.FromCpnyID = @FromCpnyID AND t.CpnyID = @ToCpny AND t.FromCpnyID <> t.CpnyID AND
         t.Screen = @Screen AND t.Module = @Module AND t.IC_Distribution = 0 AND t.UserAddress = @UserAddress
   GROUP BY t.CpnyID, t.batnbr, t.refnbr
   IF @@ERROR <> 0 GOTO ABORT

/***** Pass three for Intercompany in a different DB*****/
  INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
         CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
         ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
         LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
         PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
         S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
         ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
         User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
  SELECT t.Acct ,
         t.AppliedDate, t.BalanceType, t.BaseCuryID, t.BatNbr, @ToCpny, t.DrAmt,
         GETDATE(), t.Crtd_Prog, t.Crtd_User, t.CuryDrAmt, t.CuryCrAmt, t.CuryEffDate, t.CuryId,
         t.CuryMultDiv, t.CuryRate, t.CuryRateType, t.CrAmt, t.EmployeeID, t.ExtRefNbr, t.FiscYr,
         0, t.Id, t.JrnlType, t.Labor_Class_Cd, t.LedgerID, t.LineID, t.LineNbr, t.LineRef,
         GETDATE(), t.LUpd_Prog, t.LUpd_User, t.Module, 0, t.Acct, t.BatNbr, t.CpnyID, t.Sub,
         t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.Posted, t.ProjectID, t.Qty, t.RefNbr,
         t.RevEntryOption, t.Rlsed, t.S4Future01, t.S4Future02, t.S4Future03, t.S4Future04, t.S4Future05,
         t.S4Future06, t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12,
         t.ServiceDate, t.Sub,
         t.TaskID, t.TranDate,  'Inter-Company Transaction', 'IC', t.Units,
         t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, t.User7, t.User8, t.FromCpnyID, t.Screen,
         t.RecordId, @UserAddress
    FROM Wrk_GLTran t
   WHERE t.FromCpnyID = @FromCpnyID AND t.CpnyID = @ToCpny AND t.FromCpnyID <> t.CpnyID AND
         t.Screen = @Screen AND t.Module = @Module AND  t.IC_Distribution <> 0 AND t.UserAddress = @UserAddress
      IF @@ERROR <> 0 GOTO ABORT

FETCH GL_CSR INTO @FromCpnyID, @ToCpny, @Screen,  @Module

END
CLOSE GL_CSR
DEALLOCATE GL_CSR
SELECT @Result = 1
GOTO FINISH

ABORT:
IF @RESULT <> 12341
BEGIN
  SELECT @Result = 0
END
FINISH:


