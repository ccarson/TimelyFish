 CREATE PROC Create_New_Batch @P_lastbatnbr VARCHAR(10), @P_module VARCHAR(2),@P_newbatnbr VARCHAR(10) OUTPUT as

BEGIN TRANSACTION

DECLARE @batchlen INT
DECLARE @batnbr_str VARCHAR(11)
DECLARE @batcount INT
DECLARE @baterr INT

SELECT  @batnbr_str = @P_lastbatnbr

IF @@ERROR <> 0 GOTO ABORT

SELECT @batchlen = LEN(LTRIM(RTRIM(@batnbr_str)))

IF @@ERROR <> 0 GOTO ABORT

IF @batchlen < 6
   SELECT @batchlen = 6

IF @@ERROR <> 0 GOTO ABORT

Select @batcount = 1

While @batcount <> 0
  Begin

    SELECT @batnbr_str = LTRIM(STR((CONVERT(FLOAT,@batnbr_str) + 1),11,0))

    IF @@ERROR <> 0 GOTO ABORT

    IF LEN(@batnbr_str) > @batchlen
       SELECT @batnbr_str = '000001'

    IF @@ERROR <> 0 GOTO ABORT

    IF Len(@batnbr_str) < @batchlen
       SELECT @batnbr_str = REPLICATE('0',(@batchlen - Len(@batnbr_str))) + @batnbr_str

    IF @@ERROR <> 0 GOTO ABORT
    IF EXISTS (SELECT * FROM Batch WHERE BatNbr=@BatNbr_str and Module=@P_module) --by maria
	SELECT @baterr=2627
    ELSE
    BEGIN
    	INSERT BATCH(AutoRev,AutoRevCopy,Batnbr,BatType,Descr,EditScrnNbr,GlPostOpt,JrnlType,module,PerEnt,
		PerPost,Rlsed,Status,Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User,
		NbrCycle,CrTot,CtrlTot,CuryCrTot,CuryCtrlTot,CuryDrtot,DrTot,CuryDepositAmt,Cycle,Acct,BalanceType,BankAcct,
		BankSub,BaseCuryID,ClearAmt,Cleared,CpnyID,CuryEffDate,CuryID,CuryMultDiv,CuryRate,CuryRateType,
		DateClr,DateEnt,DepositAmt,LedgerID,NoteID,OrigBatnbr,origCpnyID,OrigScrnNbr,Sub,S4Future01,
		S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,S4Future09,
		S4Future10,S4Future11,S4Future12,User1,User2,User3,User4,User5,User6,User7,User8, VOBatNbrForPP)
    	VALUES(0,0,@batnbr_str,space(1),space(1), space(1),space(1),space(1),@P_module,space(1),
	space(1),0,space(1),GetDate(),space(1),space(1),GetDate(),space(1),space(1),0,0,0,0,0,0,0,0,0,space(1),
	space(1),space(1),space(1),space(1),0,0,space(1),GetDate(),space(1),space(1),0,space(1),GetDate(),GetDate(),
	0,space(1),0,space(1),space(1),space(1),space(1),space(1),space(1),0,0,0,0,GetDate(),GetDate(),0,0,space(1),
	space(1),space(1),space(1),0,0,space(1),space(1),getdate(),getdate(),'')

    	SELECT @baterr = @@ERROR
    END

    IF @baterr <> 2627
      Begin
       IF @baterr = 0
        Begin
	 SELECT @P_newbatnbr = @batnbr_str
         SELECT @batcount = 0
        END
       ELSE
	 GOTO ABORT
      End
End

COMMIT TRANSACTION
GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Create_New_Batch] TO [MSDSL]
    AS [dbo];

