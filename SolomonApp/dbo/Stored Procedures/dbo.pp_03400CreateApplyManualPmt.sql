 CREATE PROCEDURE
	pp_03400CreateApplyManualPmt
		@Sol_User varchar(10),
		@BatNbr varchar(10),
		@Result int output
AS

--This proc is called by pp_03400 to handle the case where manual checks were entered for one or more documents
--in the Voucher and Adjustment Entry (03.010.00) screen.  Manual Check APDocs are temporarily placed in the
--Voucher and Adjustment batch.  When that batch is released, a Manual Check batch needs to be created, and all
--Manual Check APDocs need to be applied and moved to the new batch.  The new batch will have Status = B
--when it leaves this proc.  (It is ready to be released.)

SET NOCOUNT ON

DECLARE @ApplyAmt float,
		@ApplyDate smalldatetime,
		@ApplyRefNbr char(10),
		@BatchStatus char(1),
		@CpnyID char(10),
		@CuryDiscBal float,
		@CuryEffDate smalldatetime,
		@CuryID char(4),
		@CuryMultDiv Char(1),
		@CuryRate float,
		@CuryRateType char(6),
		@DocType char(2),
		@EditScrnNbr char(5),
		@PerPost char(6),
		@RefNbr char(10),
		@NewBatNbr char(10),
		@CurrPerNbr char(6),
		@BaseCuryID char(4),
		@BaseDecPl int,
		@TranDecPl int,
		@BWAmt float,
		@CuryBWAmt float

SELECT  @EditScrnNbr = EditScrnNbr, @BatchStatus = Status FROM Batch
WHERE BatNbr = @BatNbr AND Module = 'AP'

IF @EditScrnNbr <> '03010' OR @BatchStatus <> 'U'
BEGIN
	GOTO FINISH
END	

--Loop through APDocs associated with a temporary Manual Check APDoc.
--If any are found, create a new Batch.  (All Manual Check docs from current batch will be placed in the same new batch.)
DECLARE ppCsr CURSOR FOR 

	SELECT ApplyAmt, ApplyDate, ApplyRefNbr, CpnyID, CuryDiscBal, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DocType, PerPost, RefNbr, BWAmt, CuryBWAmt from APDoc
	WHERE BatNbr = @BatNbr
	AND ApplyRefNbr IN (SELECT RefNbr FROM APDoc WHERE BatNbr = @BatNbr AND DocType  = 'VC' AND Status = 'T')
	ORDER BY ApplyRefNbr 
	
OPEN ppCsr
FETCH ppCsr INTO @ApplyAmt, @ApplyDate, @ApplyRefNbr, @CpnyID, @CuryDiscBal, @CuryEffDate, @CuryId, @CuryMultDiv, @CuryRate, @CuryRateType, @DocType, @PerPost, @RefNbr, @BWAmt, @CuryBWAmt
If @@FETCH_STATUS = 0
	BEGIN
		--Print @ApplyRefNbr + ' ' + @CpnyID + ' ' + @CuryId + ' ' + @CuryMultDiv + ' ' + @CuryRateType + ' ' + @PerPost + ' ' + @RefNbr
	
		UPDATE APSetup
		SET LastBatNbr =
		RIGHT(REPLICATE('0',LEN(LastBatNbr)) + RTRIM(LTRIM(STR(CONVERT(INT,(LastBatNbr)) + 1))),LEN(LastBatNbr)),
		@NewBatNbr = RIGHT(REPLICATE('0',LEN(LastBatNbr)) + RTRIM(LTRIM(STR(CONVERT(INT,(LastBatNbr)) + 1))),LEN(LastBatNbr))
		IF @@ERROR < > 0 GOTO ABORT
		
		SELECT @CurrPerNbr = CurrPerNbr from APSetup
	
		SELECT @BaseCuryID = g.BaseCuryId,
				@BaseDecPl = c.DecPl
		FROM GLSetup g (nolock), Currncy c (nolock)
		WHERE g.BaseCuryId = c.CuryId
		
		INSERT Batch (Acct, AutoRev, AutoRevCopy, BalanceType, BankAcct, BankSub, BaseCuryID,
			BatNbr, BatType, clearamt, Cleared, CpnyID, Crtd_DateTime, Crtd_Prog,
			Crtd_User, CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt,
			CuryDrTot, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType,
			Cycle, DateClr, DateEnt, DepositAmt, Descr, DrTot, EditScrnNbr,
			GLPostOpt, JrnlType, LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User,
			Module, NbrCycle, NoteID, OrigBatNbr, OrigCpnyID, OrigScrnNbr, PerEnt,
			PerPost, Rlsed,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
			Status, Sub, User1, User2, User3, User4, User5, User6, User7, User8, VOBatNbrForPP)
			
		SELECT Acct, AutoRev, AutoRevCopy, '', BankAcct, BankSub,BaseCuryID,
			@NewBatNbr, 'N', ClearAmt, Cleared, CpnyID, getdate(), '03400',
			@Sol_User, 0.0, 0.0, 0.0, 0.0, CuryDepositAmt,
			0.0, CuryEffDate, CuryID, CuryMultDiv, CuryRate, CuryRateType,
			Cycle, DateClr, DateEnt, DepositAmt, Descr, 0.0, '03030',
			GLPostOpt, 'AP', LedgerID, getdate(), '03400', @Sol_User,
			'AP', NbrCycle, NoteID, OrigBatNbr, OrigCpnyID, OrigScrnNbr, @CurrPerNbr,
			@PerPost, 0,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
			'B', Sub, User1, User2, User3, User4, User5, User6, User7, User8,''
		FROM Batch WHERE BatNbr = @BatNbr AND Module = 'AP'
		IF @@ERROR < > 0 GOTO ABORT
	END

--Update the Manual Check APDocs to "apply" them.  Change DocType to "HC' or 'EP' and Change Batnbr to new BatNbr.
--Create an APTran for each Manual Check.  Update batch totals as each Manual Check is added.
WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT @TranDecPl = @BaseDecPl
	
		IF @CuryID <> @BaseCuryID
			BEGIN
				SELECT @TranDecPl = DecPl FROM Currncy (nolock) WHERE CuryId = @CuryID
			
				--Look up currency rate info using apply date as currency effective date.
				--If no record is found, curyrate, curymultdiv, curyeffdate should retain values read from apdoc.
				SELECT Top 1 @CuryRate = Rate, @CuryMultDiv = MultDiv, @CuryEffDate = EffDate
				FROM CuryRate (nolock)
				WHERE FromCuryId = @CuryID AND ToCuryId = @BaseCuryID AND RateType = @CuryRateType AND EffDate <= @ApplyDate
				ORDER BY CuryRate.EffDate DESC
			END

		UPDATE APDoc SET
			ApplyAmt = @ApplyAmt,
			ApplyDate = @ApplyDate,
			BWAmt = @BWAmt,
			BatNbr = @NewBatNbr,
			CuryBWAmt = @CuryBWAmt,
			CuryDiscBal = @CuryDiscBal,
			CuryDiscTkn = @CuryDiscBal,
			CuryEffDate = @CuryEffDate,
			CuryMultDiv = @CuryMultDiv,
			CuryOrigDocAmt = @ApplyAmt,
			CuryPmtAmt = @ApplyAmt,
			CuryRate = @CuryRate,
			Cycle = 1,
			DiscBal = CASE WHEN @CuryMultDiv = 'M' then
								ROUND(@CuryDiscBal * @CuryRate, @BaseDecPl)
							ELSE
								ROUND(@CuryDiscBal / @CuryRate, @BaseDecPl)
							END,
			DiscTkn = CASE WHEN @CuryMultDiv = 'M' then
								ROUND(@CuryDiscBal * @CuryRate, @BaseDecPl)
							ELSE
								ROUND(@CuryDiscBal / @CuryRate, @BaseDecPl)
							END,
			DocDate = @ApplyDate,
			DocType = CodeType,
			OrigDocAmt = CASE WHEN @CuryMultDiv = 'M' then
								ROUND(@ApplyAmt * @CuryRate, @BaseDecPl)
							ELSE
								ROUND(@ApplyAmt / @CuryRate, @BaseDecPl)
							END,
			PmtAmt = CASE WHEN @CuryMultDiv = 'M' then
								ROUND(@ApplyAmt * @CuryRate, @BaseDecPl)
							ELSE
								ROUND(@ApplyAmt / @CuryRate, @BaseDecPl)
							END
					
		WHERE BatNbr = @BatNbr AND RefNbr = @ApplyRefNbr
		IF @@ERROR < > 0 GOTO ABORT
	
	
		INSERT APTran (Acct, AcctDist, AlternateID, Applied_PPrefNbr, BatNbr, BOMLineRef, BoxNbr, Component,
			CostType, CostTypeWO, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId,
			CuryMultDiv, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, CuryRate, CuryTaxAmt00, CuryTaxAmt01,
			CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03,
			CuryUnitPrice, DrCr, Employee, EmployeeId, Excpt, ExtRefNbr, FiscYr,
			InstallNbr, InvcTypeId, InvtID, JobRate, JrnlType, Labor_Class_Cd, LineId,
			LineNbr, LineRef, LineType, Lupd_DateTime, Lupd_Prog, Lupd_user, MasterDocNbr,
			NoteId, PC_Flag, PC_Id, PC_Status, PerEnt, PerPost, PmtMethod,
			POExtPrice, POLineRef, PONbr, POQty, POUnitPrice, PPV, ProjectId,
			Qty, QtyVar, RcptLineRef, RcptNbr, RcptQty, RefNbr, Rlsed,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
			S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate, SiteId,
			SoLineRef, SOOrdNbr, SOTypeID, Sub, TaskId, TaxAmt00, TaxAmt01,
			TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01, TaxId02,
			TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType,
			TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc, UnitPrice, User1,
			User2, User3, User4, User5, User6, User7, User8,
			VendId, WONbr, WOStepNbr)
		SELECT Acct, 0, '', '', @NewBatNbr, '', '', '',
			@DocType, '', CpnyID, GETDATE(), '03400', @Sol_User, CuryId,
			CuryMultDiv, 0.0, 0.0, 0.0, CuryRate, 0.0, 0.0,
			0.0, 0.0, CuryPmtAmt, 0.0, 0.0, 0.0, 0.0,
			CuryDiscTkn, 'S', '', '', 0, RefNbr, '',
			0, '', '', DiscTkn, '', '', 0,
			Case when BWAmt > 0 then -32768 else 0 end, '', '', GETDATE(), '03400', @Sol_User, '',
			0, '', '', '', '', '', PmtMethod,
			0.0, '', '', BWAmt, CuryBWAmt, 0.0, '',
			CuryDiscTkn, 0.0, '', '', 0.0, RefNbr, 0,
			'', '', 0.0, 0.0, 0.0, 0.0, '01-01-1900',
			'01-01-1900', 0, 0, '', '', '01-01-1900', '',
			'', '', '', Sub, '', 0.0, 0.0,
			0.0, 0.0, '', '', '', '', '',
			'', '', PmtAmt, '', DocDate, DocDesc, DocType,
			0.0, 0.0, 0.0, 0.0, @RefNbr, PmtAmt, User1,
			User2, User3, User4, '', '', '01-01-1900', '01-01-1900',
			VendId, '', ''
		FROM APDoc
		WHERE BatNbr = @NewBatNbr AND RefNbr = @ApplyRefNbr
		IF @@ERROR < > 0 GOTO ABORT
		
		UPDATE Batch SET
			CuryCrTot = ROUND(CuryCrTot + @ApplyAmt, @TranDecPl),
			CuryCtrlTot = ROUND(CuryCtrlTot + @ApplyAmt, @TranDecPl),
			CrTot = CASE WHEN @CuryMultDiv = 'M' THEN
						ROUND(CrTot + (@ApplyAmt * @CuryRate), @BaseDecPl)
					ELSE
						ROUND(CrTot + (@ApplyAmt / @CuryRate), @BaseDecPl)
					END,
			CtrlTot = CASE WHEN @CuryMultDiv = 'M' THEN
						ROUND(CrTot + (@ApplyAmt * @CuryRate), @BaseDecPl)
					ELSE
						ROUND(CrTot + (@ApplyAmt / @CuryRate), @BaseDecPl)
					END			
		WHERE BatNbr = @NewBatNbr AND Module = 'AP'	
		IF @@ERROR < > 0 GOTO ABORT
		
		FETCH ppCsr INTO @ApplyAmt, @ApplyDate, @ApplyRefNbr, @CpnyID, @CuryDiscBal, @CuryEffDate, @CuryId, @CuryMultDiv, @CuryRate, @CuryRateType, @DocType, @PerPost, @RefNbr, @BWAmt, @CuryBWAmt
	END

CLOSE ppCsr
DEALLOCATE ppCsr

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_03400CreateApplyManualPmt] TO [MSDSL]
    AS [dbo];

