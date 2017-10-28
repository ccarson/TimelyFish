
CREATE PROCEDURE XDDManual_Check_Batch_Update
   @AccessNbr		smallint,
   @GroupNbr		varchar( 1 ),
   @BatNbr		varchar( 10 ),
   @Crtd_User		varchar( 10 )

AS

   Declare @Acct		varchar( 10 )
   Declare @AdjFlag		smallint
   Declare @APDocRefNbr		varchar( 10 )
   Declare @BaseCuryPrec	smallint
   Declare @BatchCuryPrec	smallint
   Declare @ChkRefNbr		varchar( 10 )
   Declare @CpnyID		varchar( 10 )
   Declare @Crtd_Prog		varchar( 8 )
   Declare @DocType		varchar( 2 )
   Declare @EBNextNbr		varchar( 10 )
   Declare @EBNbrLen		smallint
   Declare @EBNbrPrefix		varchar( 2 )
   Declare @EBUseNbr		smallint
   Declare @FilterMultiCury	smallint
   Declare @LenRefNbr		tinyint
   Declare @LineNbr		smallint
   Declare @NextRefNbr		varchar( 10 )
   Declare @PayDate		smalldatetime
   Declare @PerEnt		varchar( 6 )
   Declare @PerPost		varchar( 6 )
   Declare @RefNbr		varchar( 10 )
   Declare @Sub			varchar( 24 )
   Declare @VendID		varchar( 15 )
   Declare @VendName		varchar( 60 )
   Declare @VendNameTilde	varchar( 60 )
--***MVA
   Declare @VendAcct            varchar( 10 )
   Declare @EntryClass		varchar( 4 )
   Declare @ChkKey		varchar( 47 )           -- 15 + 10 + 18 + 4
   Declare @ChkKeyHold		varchar( 47 )       -- 15 + 10 + 18 + 4

   SET  NOCOUNT ON
   
   SET 	@Crtd_Prog = '03030'
   SET	@APDocRefNbr = ''
   SET	@EBNbrPrefix = ''
   SET	@EBNbrLen = 6

   SET  @ChkKeyHold = ''
      
   -- Get the base currency precision
   SELECT	@BaseCuryPrec = c.DecPl
   FROM		GLSetup s (nolock),
			Currncy c (nolock)
   WHERE	s.BaseCuryID = c.CuryID

   -- Get the batch currency precision
   SELECT	@BatchCuryPrec = c.DecPl
   FROM		Batch B (nolock) left outer join Currncy c (nolock)
			ON B.CuryID = C.CuryID
   WHERE	B.Module = 'AP'
			and B.BatNbr = @BatNBr

   -- Multi-currency filtering
   SET @FilterMultiCury = 0
   
   -- Cycle thru picking up each voucher
   -- APDoc - Checks will be keyed on: VendID + CheckRefNbr + EBVendAcct + EBEntryClass
   While (1=1)
   BEGIN
  
    -- PayDate - Check Date for HC/EP
    -- If using Settlement Dates, then use PayDate
    -- If not using Settlement Dates, use EBCheckDate
	SET		@ChkRefNbr = ''
	SET		@VendID = ''
	SET		@VendAcct = ''
	SET		@EntryClass = ''
   	SELECT TOP 1  	@ChkRefNbr = CheckRefNbr,
   			@VendID = VendID,
			@VendAcct = EBVendAcct,
			@EntryClass = EBEntryClass,
   			@RefNbr = RefNbr,
   			@DocType = DocType,
   			@AdjFlag = AdjFlag,
   			@PayDate = case when TT.ChkWF_CreateMCB = 'S'
   			                then PayDate
   			                else EBCheckDate
   			                end
   	FROM		XDDWrkCheckSel W (nolock) LEFT OUTER JOIN XDDFileFormat F (nolock)
   			ON W.EBFormatID = F.FormatID LEFT OUTER JOIN XDDTxnType TT (nolock)
   			ON W.EBFormatID = TT.FormatID and W.EBEStatus = TT.EStatus
   	
   	WHERE		AccessNbr = @AccessNbr
   			and EBGroup = @GroupNbr
   			and S4Future09 = 0
   	ORDER BY	VendID, CheckRefNbr, EBVendAcct, EBEntryClass, RefNbr

	-- Added ChkRefNbr to accommodate SL separate check
	SET @ChkKey = @VendID + @ChkRefNbr + @VendAcct + @EntryClass

	SELECT	@VendName = RemitName 
	FROM 	Vendor (nolock)
	WHERE	Vendid = @VendID

print 'After Select ChkKey ' + @ChkKey

	-- Remove tilde if any.... SL does not remove the tilde
	-- EXEC XDDFixName @VendNameTilde, @VendName OUTPUT

	-- Total APDoc for last Check
	if (@ChkKey <> @ChkKeyHold) and @ChkKeyHold <> '' 	-- (@VendID <> @VendIDHold or @LastMultiChk = 1) and @VendIDHold <> ''
	BEGIN

print 'Inside Update APDoc'

		-- Total APTrans to APDoc
		-- Subtract ADs from VO/ACs
		UPDATE	APDoc
		SET	CuryOrigDocAmt = round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BatchCuryPrec) 
					 - round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BatchCuryPrec),

			CuryPmtAmt = round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BatchCuryPrec)
				     - round(coalesce((Select sum(T.CuryTranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BatchCuryPrec),

			CuryDiscBal = round(coalesce((Select sum(T.CuryUnitPrice) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BatchCuryPrec)
				     - round(coalesce((Select sum(T.CuryUnitPrice) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BatchCuryPrec),

			OrigDocAmt = round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BaseCuryPrec)
				     - round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BaseCuryPrec),

			PmtAmt = round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType <> 'AD'), 0), @BaseCuryPrec)	
			         - round(coalesce((Select sum(T.TranAmt) FROM APTran T (nolock) WHERE T.BatNbr = @BatNbr and T.RefNbr = @APDocRefNbr and T.DrCr = 'S' and T.CostType = 'AD'), 0), @BaseCuryPrec)
   
		WHERE	BatNbr = @BatNbr		
			and RefNbr = @APDocRefNbr

		COMMIT TRANSACTION
	END

print 'Before BREAK ' + @ChkKey + '|' + @ChkKeyHold

	If @ChkKey = '' BREAK

	   	
	-- Check for new VendID + CheckRefNbr + VendAcct + EntryClass
	if @ChkKey <> @ChkKeyHold
	BEGIN

print 'Before BEGIN TRAN ' + @ChkKey + '|' + @ChkKeyHold
	
		BEGIN TRANSACTION
		
		SET 	@ChkKeyHold = @ChkKey
		
		SET	@LineNbr = -32768
		
		SELECT	@Acct = BankAcct,
				@Sub = BankSub,
				@CpnyID = CpnyID,
				@PerEnt = PerEnt,
				@PerPost = PerPost
		FROM	Batch (nolock)
		WHERE	BatNbr = @BatNbr
				and Module = 'AP'

	   	-- Check if filtering by CuryID required
		SET	@EBNbrPrefix = ''
		SELECT	@EBUseNbr = MCB_UseEBNbr,
			@EBNextNbr = MCB_NextEBNbr,
			@EBNbrPrefix = MCB_EBNbrPrefix,
			@EBNbrLen = case when MCB_EBNbrLen < 6		-- never less than 6
				then 6
				else MCB_EBNbrLen
			end,
			@FilterMultiCury = Case When (WTFilterMultiCury = 1 and WTFilterMCBatInBC = 0)
							Then convert(smallint, 1)
							Else convert(smallint, 0)
							end
		FROM	XDDBank (nolock)
		WHERE	CpnyID = @CpnyID
			and Acct = @Acct
			and Sub = @Sub
						
		-- ----------------------------	
		-- Get/Set Next Check RefNbr
		-- ----------------------------	
		if @EBUseNbr = 1
		BEGIN
		
			SET	@NextRefNbr = ltrim(rtrim(@EBNextNbr))
			-- RefNbr part = Overall length - Prefix length
			SET	@LenRefNbr = @EBNbrLen - Len(rtrim(@EBNbrPrefix))
			SET	@NextRefNbr = right('0000000000' + @NextRefNbr, @LenRefNbr)
			
			-- Check if EBNextNbr is being used?
			While (1=1)
			BEGIN
			
				if not exists(Select RefNbr FROM APDoc (nolock) 
						WHERE 	DocClass = 'C'
							and DocType IN ('CK', 'MC', 'SC', 'ZC', 'VC', 'HC', 'EP')	-- Added 'HC'
							and Acct = @Acct
							and Sub = @Sub
							and RefNbr = @EBNbrPrefix + @NextRefNbr)
				BEGIN
					-- If not found, then use it
					BREAK
				END

				else

				BEGIN
					-- Increment Number
					SET	@NextRefNbr = right('0000000000' + ltrim(rtrim(convert(varchar(10), convert(int, @NextRefNbr) + 1))), @LenRefNbr)
				END				
			
			END

			-- Set Var to use for both APDoc and APTran
			SET 	@APDocRefNbr = rtrim(@EBNbrPrefix) + @NextRefNbr

		END
		
		else
		
		BEGIN
			-- MUST have all numeric number
			Select 	@NextRefNbr = Case when MAX(case When c.RefNbr IS NULL 
								then APDoc.RefNbr 
								else '' 
								end) = '' 
						then '0' 
						else ISNULL(MAX(case When c.RefNbr IS NULL 
								then APDoc.RefNbr 
								else '' 
								end), '0') 
						end   
			FROM	APDoc Left OUTER JOIN APDoc c 
				ON APDoc.VendID = c.VendID AND APDoc.RefNbr = c.RefNbr AND APDoc.Acct = c.Acct AND APDoc.Sub = c.Sub AND APDoc.DocType = 'VC' AND c.DocType IN ('HC', 'EP')  
			WHERE	APDoc.DocClass = 'C' 
				and APDoc.DocType IN ('CK', 'MC', 'SC', 'ZC', 'VC', 'HC', 'EP')	-- Added 'HC'
				and APDoc.Acct = @Acct
				and APDoc.Sub = @Sub
				and substring(APdoc.RefNbr, 1, 1) LIKE '[0-9]'
				and substring(APdoc.Refnbr, 2, 1) LIKE '[0-9]'
				and substring(APdoc.Refnbr, 3, 1) LIKE '[0-9]'
				and substring(APdoc.Refnbr, 4, 1) LIKE '[0-9]'
				and substring(APdoc.Refnbr, 5, 1) LIKE '[0-9]'
				and substring(APdoc.Refnbr, 6, 1) LIKE '[0-9]'
				and substring(APdoc.Refnbr, 7, 1) LIKE '[0-9 ]'
				and substring(APdoc.Refnbr, 8, 1) LIKE '[0-9 ]'
				and substring(APdoc.Refnbr, 9, 1) LIKE '[0-9 ]'
				and substring(APdoc.Refnbr, 10, 1) LIKE '[0-9 ]'
			
			-- Get highest number and add
			SET	@LenRefNbr = Len(rtrim(@NextRefNbr))
			if @LenRefNbr < 6 SET @LenRefNbr = 6
			SET	@NextRefNbr = right('0000000000' + ltrim(rtrim(convert(varchar(10), convert(int, @NextRefNbr) + 1))), @LenRefNbr)

			-- Set Var to use for both APDoc and APTran
			SET 	@APDocRefNbr = @NextRefNbr

		END

print 'Adding APDoc'
		
		-- ----------------------------	
	   	-- Add APDoc record
		-- ----------------------------	
		INSERT INTO APDoc
		(Acct, AddlCost, ApplyAmt, ApplyDate, ApplyRefNbr,
		BatNbr, BatSeq, BWAmt, CashAcct, CashSub, ClearAmt, ClearDate,	
		CodeType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
		CurrentNbr, 
		CuryBWAmt, CuryDiscBal, CuryDiscTkn, CuryDocBal, CuryEffDate, CuryId, CuryMultDiv,
		CuryOrigDocAmt, CuryPmtAmt, 
		CuryRate, CuryRateType,
		CuryTaxTot00, CuryTaxTot01, CuryTaxTot02, CuryTaxTot03, 
		CuryTxblTot00, CuryTxblTot01, CuryTxblTot02, CuryTxblTot03,
		Cycle, DfltDetail, DirectDeposit, DiscBal, DiscDate, DiscTkn,
		Doc1099, DocBal, DocClass, DocDate, DocDesc, DocType, DueDate,
		Econfirm, Estatus, ExcludeFreight, FreightAmt, InstallNbr, InvcDate, InvcNbr, LCCode, LineCntr,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		MasterDocNbr, NbrCycle, NoteID, OpenDoc, 
		OrigDocAmt,	
		PayDate, PayHoldDesc, PC_Status, PerClosed, PerEnt, PerPost, 
		PmtAmt, 
		PmtID, PmtMethod, PONbr, PrePay_RefNbr,	ProjectID, 	-- RecordID,
		RefNbr, Retention, RGOLAmt, Rlsed, 
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
		Selected, Status, Sub,
		TaxCntr00, TaxCntr01, TaxCntr02, TaxCntr03, TaxId00, TaxId01, TaxId02, TaxId03, 
		TaxTot00, TaxTot01, TaxTot02, TaxTot03,
		Terms, TxblTot00, TxblTot01, TxblTot02, TxblTot03,
		User1, User2, User3, User4, User5, User6, User7, User8,
		VendId, VendName)

		SELECT
		@Acct, 0, 0, 0, '',
		@BatNbr, 0, 0, '', '', 0, 0,
		'EP', @CpnyID, GetDate(), @Crtd_Prog, @Crtd_User, 	-- CodeType
		0,
		0, 0, 0, 0, B.CuryEffDate, B.CuryID, B.CuryMultDiv,	-- CuryBWAmt, CuryDiscBal, CuryDiscTkn, CuryDocBal
		0, 0, 								-- CuryOrigDocAmt, CuryPmtAmt, sum later from APTran.CuryTranAmt
		B.CuryRate, B.CuryRateType,			-- CuryRate, CuryRateType
		0, 0, 0, 0,
		0, 0, 0, 0,
		1, 0, '', 0, 0, 0,				-- Cycle
		0, 0, 'C', @PayDate, '', 'EP', 0,		-- Doc1099
		'', '', '', 0, 0, 0, '', '', 0,
		GetDate(), @Crtd_Prog, @Crtd_User, 		-- LUpd_DateTime
		'', 0, 0, 0, 
		0,			-- OrigDocAmt - sum later from APTran.TranAmt
		0, '', '', '', @PerEnt, @PerPost,
		0,			-- PmtAmt - same as OrigDocAmt
		'', 'C', '', '', '',
		@APDocRefNbr, 0, 0, 0,
		'', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 
		0, 'O', @Sub,					-- Selected, Status = 'O'utstanding
		0, 0, 0, 0, '', '', '', '', 
		0, 0, 0, 0,
		'', 0, 0, 0, 0,
		'', '', 0, 0, '', '', 0, 0,
		@VendID, @VendName

		FROM 	Batch B (nolock)
		WHERE 	B.BatNbr = @BatNbr
			and B.Module = 'AP'

print 'After Adding APDoc'

		if @EBUseNbr = 1
		BEGIN

print 'Using EB Numbering'

			-- Increment the number and save back to XDDBank
			-- RefNbr part = Overall length - Prefix length
			SET	@LenRefNbr = @EBNbrLen - Len(rtrim(@EBNbrPrefix))
			SET	@NextRefNbr = right('0000000000' + ltrim(rtrim(convert(varchar(10), convert(int, @NextRefNbr) + 1))), @LenRefNbr)

print 'Before XDDBank Update, NextRefNbr ' + @NextRefNbr

			-- Update XDDBank for this Cpny/Acct/Sub
			UPDATE	XDDBank
			SET	MCB_NextEBNbr = @NextRefNbr
			WHERE	CpnyID = @CpnyID
				and Acct = @Acct
				and Sub = @Sub

print 'After XDDBank Update'

		END
	END

print 'Adding APTran'

   	-- Add APTran record
	INSERT INTO APTran
	(Acct, AcctDist, AlternateID, Applied_PPRefNbr,
	BatNbr, BOMLineRef, BoxNbr, Component, CostType, CostTypeWO,
	CpnyID,
	Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryId, CuryMultDiv, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, 
	CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, 
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, 
	CuryUnitPrice,
	DrCr, Employee, EmployeeID, Excpt, ExtRefNbr, FiscYr, 
	InstallNbr, InvcTypeID, InvtID,
	JobRate, JrnlType, Labor_Class_Cd, LCCode,
	LineId, LineNbr, LineRef, LineType,
	LUpd_DateTime, LUpd_Prog, LUpd_User,
	MasterDocNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost,
	PmtMethod, POExtPrice, POLineRef, PONbr, POQty, POUnitPrice, PPV,
	ProjectID, Qty, QtyVar, RcptLineRef, RcptNbr, RcptQty,	--	RecordID
	RefNbr, Rlsed, 
	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
	ServiceDate, SiteId, SoLineRef, SOOrdNbr, SOTypeID,
	Sub, TaskID,
	TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03,	TaxCalced, TaxCat,
	TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt,
	TranAmt,
	TranClass, TranDate, TranDesc, TranType,
	TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03,
	UnitDesc, UnitPrice,
	User1, User2, User3, User4, User5, User6, User7, User8,
	VendId,
	WONbr, WOStepNbr)
	
	SELECT
	@Acct, 0, '', '',
	@BatNbr, '', '', '',  W.DocType, '',    -- W.Doctype = CostType
	W.CpnyID,
	0, '', '',
	W.CuryID, W.CuryMultDiv, 0, 0, 0,
	W.CuryRate, 0, 0, 0, 0,			
	Case when @FilterMultiCury = 0		-- CuryTranAmt
		then W.CuryPmtAmt
		-- W.CuryDocBal is in BASE currency (go figure)
		-- V.DocBal is voucher base currency - if matches with W.CuryDocBal, then no partial
		else case when convert(float, round(  convert(decimal(28,3), W.CuryDocBal), @BatchCuryPrec)) =  
					   case when W.CuryMultDiv = 'M'	-- bring back to base
					   		then convert(float, round(  convert(decimal(28,3), V.CuryDocBal * W.CuryRate), @BatchCuryPrec))    --	full doc balance was paid
							else convert(float, round(  convert(decimal(28,3), V.CuryDocBal / W.CuryRate), @BatchCuryPrec))
							end
				then V.CuryDocBal
				else case when W.CuryMultDiv = 'M'
						then convert(float, round(  convert(decimal(28,3), W.CuryDocBal) / convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						else convert(float, round(  convert(decimal(28,3), W.CuryDocBal) * convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						end
				end
		end,
	0, 0, 0, 0,
	Case when @FilterMultiCury = 0 			-- CuryUnitPrice
		then W.CuryDiscTkn			-- CuryDiscTkn
		-- W.CuryDiscTkn is in BASE currency (go figure)
		-- V.DiscTkn is voucher base currency - if matches with W.CuryDocBal, then no partial
		else case when convert(float, round(  convert(decimal(28,3), W.CuryDiscTkn), @BatchCuryPrec)) =  
					   case when W.CuryMultDiv = 'M' 
					   		then convert(float, round(  convert(decimal(28,3), V.CuryDiscTkn * W.CuryRate), @BatchCuryPrec))    --	full doc balance was paid
							else convert(float, round(  convert(decimal(28,3), V.CuryDiscTkn / W.CuryRate), @BatchCuryPrec))
							end
				then V.CuryDiscTkn
				else case when W.CuryMultDiv = 'M'
						then convert(float, round(  convert(decimal(28,3), W.CuryDiscTkn) / convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						else convert(float, round(  convert(decimal(28,3), W.CuryDiscTkn) * convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						end
				end
		end,
	'S', '', '', 0, '', Left(@PerPost, 4),
	0, '', '',					-- InstallNbr
	0, 'AP', '', '',				-- JobRate
	0, @LineNbr, '', '',
	GetDate(), @Crtd_Prog, @Crtd_User,		-- LUpd...
	'', 0, '', '', '', @PerEnt, @PerPost,		-- MasterDocNbr
	'', 0, '', '', 0, 0, 0,				-- PmtMethod
	'', W.DiscTkn, 0, '', '', 0,  			-- ProjectID
	@APDocRefNbr, 0,				-- RefNbr
	'', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 	-- S4Future??
	0, '', '', '', '', 				-- ServiceDate
	@Sub, '',
	0, 0, 0, 0, '', '',				-- TaxAmt...
	'', '', '', '', '',				-- TaxID??...
	Abs(W.PmtAmt),		-- TranAmt (when created by Pmt Selection, this is negative and shouldn't be - therefore added Abs())
	'', @PayDate, '', 'EP',				-- TranClass
	0, 0, 0, 0,
	W.RefNbr, 					-- UnitDesc (VchRefNbr)
	case when W.DocType = 'AD'			-- UnitPrice (signed CuryTranAmt)
		then Case when @FilterMultiCury = 0 
				then -W.CuryPmtAmt			-- CuryTranAmt
				-- W.CuryDocBal is in BASE currency (go figure)
				-- V.DocBal is voucher base currency - if matches with W.CuryDocBal, then no partial
				else case when convert(float, round(  convert(decimal(28,3), W.CuryDocBal), @BatchCuryPrec)) =  
					   case when W.CuryMultDiv = 'M' 
					   		then convert(float, round(  convert(decimal(28,3), V.CuryDocBal * W.CuryRate), @BatchCuryPrec))    --	full doc balance was paid
							else convert(float, round(  convert(decimal(28,3), V.CuryDocBal / W.CuryRate), @BatchCuryPrec))
							end
					then -V.CuryDocBal
					else case when W.CuryMultDiv = 'M'
						then -convert(float, round(  convert(decimal(28,3), W.CuryDocBal) / convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						else -convert(float, round(  convert(decimal(28,3), W.CuryDocBal) * convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						end
				end
			end
		else Case when @FilterMultiCury = 0 
				then W.CuryPmtAmt	-- CuryTranAmt
				-- W.CuryDocBal is in BASE currency (go figure)
				-- V.DocBal is voucher base currency - if matches with W.CuryDocBal, then no partial
				else case when convert(float, round(  convert(decimal(28,3), W.CuryDocBal), @BatchCuryPrec)) =  
					   case when W.CuryMultDiv = 'M' 
					   		then convert(float, round(  convert(decimal(28,3), V.CuryDocBal * W.CuryRate), @BatchCuryPrec))    --	full doc balance was paid
							else convert(float, round(  convert(decimal(28,3), V.CuryDocBal / W.CuryRate), @BatchCuryPrec))
							end
					then V.CuryDocBal
					else case when W.CuryMultDiv = 'M'
						then convert(float, round(  convert(decimal(28,3), W.CuryDocBal) / convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						else convert(float, round(  convert(decimal(28,3), W.CuryDocBal) * convert(decimal(16,9),  W.CuryRate), @BatchCuryPrec))
						end
					end
				end
		end, 
	'', '', 0, 0, '', '', 0, 0,
	@VendID,
	'', ''
	FROM	XDDWrkCheckSel W (nolock)
		LEFT OUTER JOIN APDoc V (nolock)
		ON W.Vendid = V.Vendid and W.DocType = V.Doctype and W.RefNbr = V.RefNbr
   	WHERE	W.AccessNbr = @AccessNbr
   		and W.EBGroup = @GroupNbr
		and W.CheckRefNbr = @ChkRefNbr
   		and W.VendID = @VendID
		and W.EBVendAcct = @VendAcct
		and W.EBEntryClass = @EntryClass
   		and W.RefNbr = @RefNbr
   		and W.DocType = @DocType
   		and W.AdjFlag = @AdjFlag	
	
	SET	@LineNbr = @LineNbr + 32

	-- Unselect the voucher, now that it has been added to the MCB
	UPDATE	APDoc
	SET	Selected = 0
	WHERE	VendID = @VendID
		and DocType = @DocType
		and RefNbr = @RefNbr
		
Print 'About to Update XDDWrkCheckSel'

   	-- Now flag S4Future09, so will not be picked up again	
   	UPDATE	XDDWrkCheckSel
   	SET	S4Future09 = 1
   	WHERE	AccessNbr = @AccessNbr
   		and EBGroup = @GroupNbr
		and CheckRefNbr = @ChkRefNbr
   		and VendID = @VendID
		and EBVendAcct = @VendAcct
		and EBEntryClass = @EntryClass
   		and RefNbr = @RefNbr
   		and DocType = @DocType
   		and AdjFlag = @AdjFlag	
   END

   BEGIN TRANSACTION
   
   -- Total APDocs to Batch   	
   UPDATE	Batch
   SET		CrTot = round(coalesce((Select sum(D.OrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BaseCuryPrec),
		CtrlTot = round(coalesce((Select sum(D.OrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BaseCuryPrec),
		CuryCrTot = round(coalesce((Select sum(D.CuryOrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BatchCuryPrec),
		CuryCtrlTot = round(coalesce((Select sum(D.CuryOrigDocAmt) FROM APDoc D (nolock) WHERE D.BatNbr = @BatNbr), 0), @BatchCuryPrec),
		CuryDepositAmt = 0,
		CuryDrTot = 0	
   WHERE	Module = 'AP'
		and BatNbr = @BatNbr

   -- Remove any records from APCheck, APCheckDet
   DELETE	FROM APCheck
   WHERE	BatNbr = @BatNbr

   DELETE	FROM APCheckDet
   WHERE	BatNbr = @BatNbr
   
   COMMIT TRANSACTION

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDManual_Check_Batch_Update] TO [MSDSL]
    AS [dbo];

