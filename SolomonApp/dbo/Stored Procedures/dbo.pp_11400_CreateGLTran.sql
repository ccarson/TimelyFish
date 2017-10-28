 CREATE PROC pp_11400_CreateGLTran
			@BatNbr       VARCHAR(10),              -- Batch Number
                        @JrnlType     VARCHAR(2),               -- Journal Type
                        @EditScrnNbr  VARCHAR(5),               -- Edit Screen Number
			@UserIdGL     VARCHAR(10),		-- User Id
            		@CompanyId    VarChar(10),      	-- CompanyId
                        @RecordCount  INT OUTPUT,               -- G/L Tran Record Count
                        @CrTot        FLOAT OUTPUT,             -- Batch Credit Total
                        @CtrlTot      FLOAT OUTPUT,             -- Batch Control Total
                        @DrTot        FLOAT OUTPUT,             -- Batch Debit Total
                        @P_Error      VARCHAR(1) OUTPUT AS      -- Error Flag

    DECLARE @BalanceType  CHAR(1)
    DECLARE @BaseCuryId   CHAR(4)
    DECLARE @BMIDfltRttp  CHAR(6)
    DECLARE @CuryId       CHAR(4)
    DECLARE @Rlsed        INT
    DECLARE @FiscYr       CHAR(4)
    DECLARE @GLPostOpt    CHAR(1)
    DECLARE @LedgerId     CHAR(10)
    DECLARE @PerEnt       CHAR(6)
    DECLARE @PerPost      CHAR(6)


    SELECT @P_Error         = ' '


    CREATE TABLE #Wrk10400_GLTran_B (Acct                 CHAR(10),
                                     CrAmt                FLOAT,
                                     DrAmt                FLOAT,
                                     LineId               INT identity(1,1),
                                     ProjectID            CHAR(16),
                                     Qty                  FLOAT,
                                     RefNbr               CHAR(15),
                                     Sub                  CHAR(24),
                                     TaskID               CHAR(32),
                                     TranDate             SMALLDATETIME,
                                     TranDesc             CHAR(30),
                                     TranType             CHAR(2),
                                     BMICuryId            CHAR(4),
                                     BMIRtTp              CHAR(6),
                                     InvtId               CHAR(24),
                                     tstamp               TIMESTAMP)
    IF @@ERROR <> 0 GOTO ABORT

    SELECT @CuryId =  CuryId,
           @FiscYr =  SUBSTRING(PerPost,1,4),
           @PerEnt =  PerEnt,
           @PerPost = PerPost
    FROM Batch (NOLOCK)
    WHERE BatNbr = @BatNbr AND Module = 'IN'

    SELECT @BaseCuryId = BaseCuryId,
           @LedgerId = LedgerId
    FROM GLSetup (NOLOCK)

    SELECT @BMIDfltRttp = bmidfltrttp
    FROM INSETUP(NOLOCK)


    SELECT @BalanceType = (SELECT BalanceType FROM Ledger (NOLOCK) WHERE LedgerId = @LedgerId)

    SELECT @GLPostOpt = (SELECT GLPostOpt FROM INSetup (NOLOCK))

    IF (@GLPostOpt = 'S')    -- Post in Summary, create summarized GLTran records.
        BEGIN
            INSERT #WRK10400_GLTran_B (Acct, CrAmt, DrAmt, ProjectID, Qty, RefNbr, Sub, TaskId,
                                       TranDate, TranDesc, TranType,BMICuryId, BMIRttp, InvtId)
             SELECT t.Acct,
                          CrAmt = sum(Case When T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End < 0
                                            Then T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End * -1 Else 0 End),
                          DrAmt = sum(Case When T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End > 0
                                            Then T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End Else 0 End),
                          ProjectId = min(t.projectid),
                          Qty  = SUM(t.Qty),
                          RefNbr = Min(t.RefNbr),
                          Sub = Min(t.Sub),
                          TaskId = MIN(t.TaskId),
                          TranDate = MIN(t.TranDate),
                 TranDesc = Min('Summarized By Batch'),
                          tranType = Min(t.Trantype),
                          BMICuryId = Min(t.BMICuryId),
                          BMIRttp = Min(t.BMIRttp),
                          InvtiD = Min(t.InvtId)
                     FROM INTran T
                     WHERE @BatNbr = t.BatNbr and t.trantype not in ('CT')
                   Group By t.Acct, t.Sub, t.DrCr
            IF @@ERROR <> 0 GOTO ABORT
        END
    ELSE
        BEGIN                -- Post in Detail, create detailed GLTran records.
            INSERT #WRK10400_GLTran_B (Acct, CrAmt, DrAmt, ProjectID, Qty, RefNbr, Sub, TaskId,
                                       TranDate, TranDesc, TranType, BMICuryId, BMIRttp, InvtId)
                   SELECT t.Acct,
                          CrAmt = Case When T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End < 0
                                            Then T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End * -1 Else 0 End,
                          DrAmt = Case When T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End > 0
                                            Then T.ExtCost * Case When T.DrCr = 'C' Then -1 Else 1 End Else 0 End,
                          T.ProjectId,
                          T.Qty,
                          T.RefNbr,
                          T.Sub,
                          T.TaskId,
                          T.TranDate,
                          T.InvtID,
                          T.Trantype,
                          T.BMICuryId,
                          T.BMIRttp,
                          T.InvtId
                     FROM INTran T
                     WHERE T.BatNbr = @batnbr
            IF @@ERROR <> 0 GOTO ABORT
        END

    SELECT @CtrlTot = 0
    SELECT @CrTot = 0
    SELECT @DrTot = 0

    IF (@@Identity > 0)           -- G/L Transactions need to be created.
        BEGIN
            SELECT @RecordCount = Count(*),
                   @CtrlTot = COALESCE(SUM(@CtrlTot + DrAmt),0),
                   @CrTot = COALESCE(SUM(@CrTot + CrAmt),0),
                   @DrTot = COALESCE(SUM(@DrTot + DrAmt),0)
             FROM #Wrk10400_GLTran_B W
            WHERE ((W.CrAmt <> 0 OR W.DrAmt <> 0 )
                    OR (W.cramt = 0 AND W.dramt = 0
                    AND W.trantype = 'AS'))
            IF @@ERROR <> 0 GOTO ABORT


            IF (@RecordCount > 0)          -- G/L Transactions need to be Created
                BEGIN
                    INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryId, BatNbr, CpnyId, CrAmt,
				   Crtd_DateTime, Crtd_Prog, Crtd_User, CuryCrAmt, CuryDrAmt, CuryEffDate,
				   CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeId, ExtRefNbr,
				   FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerId, LineID,
				   LineNbr, LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteId,
				   OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status,
				   PerEnt, PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed,
				   S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
				   S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
				   S4Future12, ServiceDate, Sub, TaskId, TranDate, TranDesc, TranType,
                                   Units, User1, User2, User3, User4, User5, User6, User7, User8)
                           SELECT W.Acct, '', @BalanceType, @BaseCuryId, @BatNbr, @CompanyId, W.CrAmt,
				  GetDate(), '11400SQL', @UserIdGL, W.CrAmt, W.DrAmt, '',
				  @CuryId, 'M', 1, '', W.DrAmt, '', '',
				  @FiscYr, 0, '', @JrnlType, '', @LedgerId, (-32768 + W.LineId),
				  W.LineId, Space(1), GetDate(), '11400SQL', @UserIdGL, 'IN', 0,
				  '', '', '', '', '', '', '',
				  @PerEnt, @PerPost, 'U', W.ProjectId, W.Qty, W.RefNbr, '', 0,
				  '', '', 0, 0, 0, 0,
				  '', '', 0, 0, '',
				  '', '', W.Sub, W.TaskId, W.TranDate, W.TranDesc, W.Trantype,
				  0, '', '', 0, 0, '', '', '', ''
                           FROM #wrk10400_GLTran_B W
                           WHERE ((w.CrAmt <> 0 OR w.DrAmt <> 0 )
                                  OR (w.cramt = 0 AND w.dramt = 0
                                  AND w.trantype = 'AS'))
                    IF @@ERROR <> 0 GOTO ABORT
                END
        END

    GOTO FINISH

ABORT:
    SELECT @P_Error = 'Y'

FINISH:


