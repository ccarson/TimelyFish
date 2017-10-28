
CREATE PROCEDURE XDDMCB_Batches_Update_Rates
	@BatNbr		    varchar( 10 ),
    @EBFileNbr      varchar( 6 ),
    @FileType       varchar( 1 ),
	@NewStatus      varchar( 1 ),
	@CuryEffDate    smalldatetime,
    @CuryMultDiv    varchar( 1 ),
	@CuryRate       float,
	@CuryRateType   varchar( 6 ),
	@Upd_Prog       varchar( 8 ),
	@Upd_User       varchar( 10 ),
	@UpdStatusOnly	smallint

AS

    declare @CuryDecPl  		smallint 
	Declare	@CurrDate 			smalldatetime
	declare @FilterMultiCury	smallint
	declare @APDocRefNbr		varchar(10)
	declare @BaseCuryPrec		smallint
	declare @TxnCuryPrec		smallint
	declare @LUpd_Prog			varchar(8)

	SET NOCOUNT ON
	
	SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)

	-- Only update status
	if @UpdStatusOnly = 1
	BEGIN
	    UPDATE Batch
	    SET    Status = @NewStatus,
	           LUpd_DateTime = @CurrDate,
	           LUpd_User = @Upd_User,
	           LUpd_Prog = @Upd_Prog
	    WHERE  BatNbr = @BatNbr
	           and Module = 'AP'
	           and EditScrnNbr = '03030'     -- just to be safe

	    RETURN
	END

	-- Determine if batch is in Paying Account Currency or in Vendor Currency
	-- @FilterMultiCury = 1, if in Vendor Currencty		
	Select	@FilterMultiCury = Case When (B.WTFilterMultiCury = 1 and B.WTFilterMCBatInBC = 0)
								Then convert(smallint, 1)
								Else convert(smallint, 0)
								end
	FROM 	XDDFile_Wrk W (nolock) left outer join XDDBank B (nolock)
			ON W.ChkCpnyID = B.CpnyID and W.ChkAcct = B.Acct and W.ChkSub = B.Sub
	WHERE	W.EBFileNbr = @EBFileNbr
			and W.FileType = 'W'

    -- XDDBatch Update
    UPDATE XDDBatch
    SET    CuryEffDate = @CuryEffDate,
           CuryMultDiv = @CuryMultDiv,
           CuryRate = @CuryRate,
           CuryRateType = @CuryRateType             
    WHERE  EBFileNbr = @EBFileNbr
           and BatNbr = @BatNbr
           and FileType = @FileType
		
	-- If in Vendor Currency, update all levels of batch		
	if @FilterMultiCury = 1
	BEGIN

		-- Get currency precision for this batch
		SELECT	@CuryDecPl = DecPl
		FROM	Currncy (nolock)
		WHERE	CuryID = (Select TOP 1 CuryID FROM Batch (nolock) 
	            WHERE  BatNbr = @BatNbr
	                   and Module = 'AP'
	                    and EditScrnNbr = '03030')

	    -- Batch Update
	    UPDATE Batch
	    SET    Status = @NewStatus,
	           CuryRate = @CuryRate,
	           CrTot = Case When CuryMultDiv = 'M'
	                        then Round(CuryCrTot * @CuryRate, @CuryDecPl)
	                        else Round(CuryCrTot / @CuryRate, @CuryDecPl)
	                        end,
	           CtrlTot = Case When CuryMultDiv = 'M'
	                        then Round(CuryCtrlTot * @CuryRate, @CuryDecPl)
	                        else Round(CuryCtrlTot / @CuryRate, @CuryDecPl)
	                        end,
	           CuryRateType = @CuryRateType,             
	           CuryEffDate = @CuryEffDate,
	           LUpd_DateTime = @CurrDate,
	           LUpd_User = @Upd_User,
	           LUpd_Prog = @Upd_Prog
	    WHERE  BatNbr = @BatNbr
	           and Module = 'AP'
	           and EditScrnNbr = '03030'     -- just to be safe
	
	    -- APDoc Update
	    UPDATE APDoc
	    SET    CuryRate = @CuryRate,
	           OrigDocAmt = Case When CuryMultDiv = 'M'
	                        then Round(CuryOrigDocAmt * @CuryRate, @CuryDecPl)
	                        else Round(CuryOrigDocAmt / @CuryRate, @CuryDecPl)
	                        end,
	           PmtAmt = Case When CuryMultDiv = 'M'
	                        then Round(CuryOrigDocAmt * @CuryRate, @CuryDecPl)
	                        else Round(CuryOrigDocAmt / @CuryRate, @CuryDecPl)
	                        end,
	           CuryRateType = @CuryRateType,             
	           CuryEffDate = @CuryEffDate,
	           LUpd_DateTime = @CurrDate,
	           LUpd_User = @Upd_User,
	           LUpd_Prog = @Upd_Prog
	    WHERE  BatNbr = @BatNbr                      
	
	    -- APTran Update - note that some Cury fields don't get updated... this is the way SL does it
	    UPDATE APTran
	           -- CuryRate = @CuryRate,
	    SET    TranAmt = Case When CuryMultDiv = 'M'
	                        then Round(UnitPrice * @CuryRate, @CuryDecPl)
	                        else Round(UnitPrice / @CuryRate, @CuryDecPl)
	                        end,
	           -- CuryRateType = @CuryRateType,             
	           -- CuryEffDate = @CuryEffDate,
	           LUpd_DateTime = @CurrDate,
	           LUpd_User = @Upd_User,
	           LUpd_Prog = @Upd_Prog
	    WHERE  BatNbr = @BatNbr                      
	END
	
	Else
	
	BEGIN
		-- Get currency precision for this batch
		SELECT	@BaseCuryPrec = DecPl
		FROM	Currncy (nolock)
		WHERE	CuryID = (Select TOP 1 CuryID FROM Batch (nolock) 
	            WHERE  BatNbr = @BatNbr
	                   and Module = 'AP'
	                   and EditScrnNbr = '03030')

   		-- Get the Txn currency precision
		SELECT	@TxnCuryPrec = DecPl
		FROM	Currncy (nolock)
		WHERE	CuryID = (Select TOP 1 CuryID FROM APTran (nolock) 
	            WHERE  BatNbr = @BatNbr)
		
		-- First mark all APDocs with blank LUpd_Prog
		UPDATE 	APDoc
		SET		LUpd_Prog = ''
		WHERE	BatNbr = @BatNbr
		
		-- Process thru All APDocs for this Batch
		-- Only update APTran, then roll-up numbers
		While (1=1)
		BEGIN
		
			SELECT 		TOP 1 
						@LUpd_Prog = rtrim(LUpd_Prog),
						@APDocRefNbr = RefNbr
			FROM		APDoc (nolock)
			WHERE		BatNbr = @BatNbr
			ORDER BY	LUpd_Prog
	
			-- We're done if we've updated all APDocs
			IF @LUpd_Prog <> '' BREAK

			-- take current CuryTranAmt, divide by current Rate = Voucher currency amount
			-- now multiply by the new rate = New Base currency amount
			UPDATE		APTran
			SET		TranAmt = case when CuryMultDiv = 'M'
							then round(coalesce(round(CuryTranAmt / CuryRate, @TxnCuryPrec),0) * @CuryRate, @TxnCuryPrec)
							else round(coalesce(round(CuryTranAmt * CuryRate, @TxnCuryPrec),0) / @CuryRate, @TxnCuryPrec)
							end,
					CuryTranAmt = case when CuryMultDiv = 'M'
							then round(coalesce(round(CuryTranAmt / CuryRate, @TxnCuryPrec),0) * @CuryRate, @TxnCuryPrec)
							else round(coalesce(round(CuryTranAmt * CuryRate, @TxnCuryPrec),0) / @CuryRate, @TxnCuryPrec)
							end,
					-- UnitPrice is negative for ADs
					UnitPrice = case when CuryMultDiv = 'M'
							then Case when CostType = 'AD'
								then -round(coalesce(round(CuryTranAmt / CuryRate, @TxnCuryPrec),0) * @CuryRate, @TxnCuryPrec)
								else round(coalesce(round(CuryTranAmt / CuryRate, @TxnCuryPrec),0) * @CuryRate, @TxnCuryPrec)
								end
							else Case when CostType = 'AD'
								then -round(coalesce(round(CuryTranAmt * CuryRate, @TxnCuryPrec),0) / @CuryRate, @TxnCuryPrec)
								else round(coalesce(round(CuryTranAmt * CuryRate, @TxnCuryPrec),0) / @CuryRate, @TxnCuryPrec)
								end
							end,
					CuryRate = @CuryRate,
					LUpd_DateTime = @CurrDate,
	           			LUpd_User = @Upd_User,
	           			LUpd_Prog = @Upd_Prog
			WHERE		BatNbr = @BatNbr
					and RefNbr = @APDocRefNbr


			-- Now update the APDoc from the APTrans
			-- Total APTrans to APDoc
			-- Subtract ADs from VO/ACs
			UPDATE	APDoc
			SET		CuryOrigDocAmt = round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @TxnCuryPrec) 
						 - round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @TxnCuryPrec),
	
					CuryPmtAmt = round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @TxnCuryPrec)
					     - round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @TxnCuryPrec),
	
					CuryDiscBal = round(coalesce((Select sum(T.CuryUnitPrice) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @TxnCuryPrec)
					     - round(coalesce((Select sum(T.CuryUnitPrice) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @TxnCuryPrec),
	
					OrigDocAmt = round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BaseCuryPrec)
					     - round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BaseCuryPrec),
	
					PmtAmt = round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BaseCuryPrec)	
				         - round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BaseCuryPrec),
	           		LUpd_DateTime = @CurrDate,
	           		LUpd_User = @Upd_User,
	           		LUpd_Prog = @Upd_Prog,
				User4 = @CuryRate		--***MC
			WHERE	BatNbr = @BatNbr		
					and RefNbr = @APDocRefNbr

		END	-- end of APDoc loop
	

		-- Now Update the Batch record		
	   	UPDATE	Batch
		SET		CrTot = round(coalesce((Select sum(D.OrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BaseCuryPrec),
				CtrlTot = round(coalesce((Select sum(D.OrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BaseCuryPrec),
				CuryCrTot = round(coalesce((Select sum(D.CuryOrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @TxnCuryPrec),
				CuryCtrlTot = round(coalesce((Select sum(D.CuryOrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @TxnCuryPrec),
				CuryDepositAmt = 0,
				CuryDrTot = 0,
				Status = @NewStatus,
				User4 = @CuryRate	--***MC
		WHERE	Module = 'AP'
				and BatNbr = @BatNbr
	           		and EditScrnNbr = '03030'     -- just to be safe

	END

