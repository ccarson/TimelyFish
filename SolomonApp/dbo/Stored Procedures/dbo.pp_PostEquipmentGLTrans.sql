CREATE PROCEDURE pp_PostEquipmentGLTrans @DocNbr VARCHAR(10), @LineNbr INT, @CpnyID VARCHAR(10), @Project VARCHAR(16), 
                                         @Acct VARCHAR(10), @SubAcct VARCHAR(24), @Amount FLOAT, @BatNbr VARCHAR(10),    
                                         @gGLTranLinenbr INT, @gPostPeriod VARCHAR(6), @SolUser Varchar(10), @ProgID VARCHAR(8),                                              
                                         @PPTranResult INT OUTPUT
AS
 DECLARE @BaseCuryID VARCHAR(4)
 DECLARE @LedgerID VARCHAR(10)
 SELECT @BaseCuryID = g.BaseCuryId, @LedgerID = g.LedgerID
   FROM GLSetup g WITH(NOLOCK)

 DECLARE @ERRORNBR INT
                                     
 INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, 
                CpnyID, 
                CrAmt, 
                Crtd_DateTime, Crtd_Prog, Crtd_User, 
                CuryCrAmt, 
                CuryDrAmt, 
                CuryEffDate, CuryId, CuryMultDiv, 
                CuryRate, CuryRateType, 
                DrAmt, EmployeeID, ExtRefNbr, 
                FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, 
                LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime, 
                LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, 
                OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, 
                PC_Status, PerEnt, PerPost, Posted, ProjectID, 
                Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, 
                S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, 
                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, 
                S4Future12, ServiceDate, Sub, TaskID, TranDate, 
                TranDesc, TranType, Units, User1, User2, 
                User3, User4, User5, User6, User7, 
                User8)
 SELECT @Acct, CAST(0x00000000 AS SmallDateTime), 'A', @BaseCuryID, @BatNbr, 
        @CpnyID, 
        CASE WHEN @Amount < 0 THEN @Amount * -1 ELSE 0 END,  --CrAmt
        GETDATE(), @ProgID, @SolUser, 
        CASE WHEN @Amount < 0 THEN @Amount * -1 ELSE 0 END, --CuryCrAmt
        CASE WHEN @Amount > 0 THEN @Amount ELSE 0 END, --CuryDrAmt
        CAST(0x00000000 AS SmallDateTime), @BaseCuryID, 'M', 
        1, '', 
        CASE WHEN @Amount > 0 THEN @Amount ELSE 0 END, --DrAmt
        CASE WHEN t.employee = 'NONE' THEN '' ELSE t.employee END, CAST(t.linenbr as varchar(15)), 
        LEFT(@gPostPeriod,4), 0, '', 'EQ', '', 
        @LedgerID, 0, @gGLTranLinenbr, '', GETDATE(), 
        @ProgID, @SolUser, 'TM', 0, '', 
        '', '', '', '', '', 
        2, @gPostPeriod, @gPostPeriod, 'U', @Project, 
        t.equip_units, t.docnbr, '', 1, '', 
        '', 0, 0, 0, 0, 
        CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 0, 0, '', 
        '', CAST(0x00000000 AS SmallDateTime), @SubAcct, t.pjt_entity, t.tl_date, 
        '', 'TM', 0, '', '', 
        0, 0, '', '', CAST(0x00000000 AS SmallDateTime), 
        CAST(0x00000000 AS SmallDateTime)              
    FROM PJTIMDET t JOIN PJTIMHDR h
                      ON t.docnbr = h.docnbr
   WHERE t.docnbr = @DocNbr
     AND t.linenbr = @LineNbr                                     
  IF @@ERROR <> 0
     BEGIN
        SET @ERRORNBR = 4000
        GOTO ABORT
     END            
     
 SELECT @PPTranResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    4000 - GLTran
 **/
 SELECT @PPTranResult = @ERRORNBR

 FINISH:     


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_PostEquipmentGLTrans] TO [MSDSL]
    AS [dbo];

