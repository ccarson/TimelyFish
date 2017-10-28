
CREATE PROCEDURE XDDWrkCheckSel_Load
   @AccessNbr		smallint,
   @BatNbr		varchar( 10 ),
   @FormatID		varchar( 15 )		-- EFT/Wire format associated with the Cpny/Acct/Sub of the BatNbr

AS

   Declare @Acct		varchar( 10 )
   Declare @BatNbrUsed		bit
   --***MVA
   Declare @CheckRefNbr		varchar( 30 )	-- CheckNbr + eConfirm + eStatu
   Declare @ChkWF		varchar( 1 )
   Declare @CpnyID		varchar( 10 )
   Declare @CurrCuryID		varchar( 4 )
   Declare @CurrFormatID    	varchar( 15 )
   Declare @CurrDate		smalldatetime
   Declare @FilterMultiCury	smallint
   Declare @GroupedCnt		smallint
   Declare @GrpNbr		smallint
   Declare @GrpNbrStr		varchar( 1 )
   Declare @ModEFTEmail		varchar( 1 )
   Declare @ModWireEmail	varchar( 1 )
   --***MVA
   Declare @MultiVendAcctUse	smallint
   Declare @NbrChkWF		tinyint
   Declare @NeedSettleDate	bit
   Declare @PayDate		smalldatetime
   Declare @SeparateTxnType	varchar( 10 )
   Declare @SLBatch		bit
   Declare @Sub			varchar( 24 )
   Declare @WirePlusFormat	bit

   SET NOCOUNT ON

   -- strip off minutes... so only date portion remains	
   SET		@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)
   	   
   SELECT	@ModEFTEmail = ModAPEmail,
   			@ModWireEmail = ModWireEmail
   FROM		XDDSetup (nolock)
   
   SELECT	@WirePlusFormat = case when FormatType = 'W'
   			then 1
   			else 0
   			end
   FROM		XDDFileFormat (nolock)
   WHERE	FormatID = @FormatID			

   -- US-ACH NACHA Txns
   -- Left(EntryClass, 3) = 'PPD' or 'CCD'
      			   
   DELETE FROM XDDWrkCheckSel Where AccessNbr = @AccessNbr
   
   -- This takes an Existing Payment Selection Batch (APCheck, APCheckDet)
   -- and recreates a shadow table to WrkCheckSel (XDDWrkCheckSel)
   -- XDDWrkCheckSel has one record for each original APCheckDet record
   --   It is updated with eBanking info for each document
   --   And then is used to "break" into eBanking Batches
   --   New Pmt Selection batch numbers will be assigned to these separate eBanking batches
   
   INSERT INTO XDDWrkCheckSel
   (	AccessNbr,
	Acct,
	AdjFlag,
	ApplyRefNbr,
	BWAmt,
	CheckCuryId,
	CheckCuryRate,
	CheckCuryMultDiv,
	CpnyID, 	
	CheckRefNbr,
	CuryBWAmt,	
	CuryDecPl, 	
	CuryDiscBal, 	
	CuryDiscTkn, 	
	CuryDocBal, 	
	CuryEffDate, 	
	CuryId, 	
	CuryMultDiv, 	
	CuryPmtAmt, 	
	CuryRate, 	
	CuryRateType, 	
	DiscBal, 	
	DiscDate, 	
	DiscTkn, 	
	DocBal, 	
	DocDesc, 	
	DocType, 	
	DueDate, 	
	EBActive,
-- EBAmtALevel,   -- 17 L0, L1, L2 or L0, L1Vendor1, L1Vendor2... etc.	
	EBBatNbr,
        EBCheckDate,
	EBChkWF,
	EBChkWF_CreateMCB,
	EBEmailNotif,	
	EBEntryClass,	
	EBEStatus,	
	EBFormatID,	
	EBGroup,
	EBInvcDate,	
	EBInvcNbr,	
	EBNACHATxn,
	EBPreNoteApp,	
	EBSeparateTxnType,
	EBTerminated,	
	EBTxnType,
	EBVendAcct,
	LineNbr,	
	MultiChk, 	
	PayDate, 	
	PmtAmt, 	
	RefNbr,
	ReqBkupWthld,
	S4Future01,     
	S4Future02,     
	S4Future03,     
	S4Future04,     
	S4Future05,     
	S4Future06,     
	S4Future07,     
	S4Future08,     
	S4Future09,     
	S4Future10,     
	S4Future11,     
	S4Future12,     
	Sub, 	
	User1,
	User2,
	User3,
	User4,
	User5,
	User6,
	User7,
	User8,
	VendId,
	VendName
   )
   
   SELECT
   	@AccessNbr,
	V.Acct,
	case when D.DocType = 'AD'
		then 1
		else 0
		end,
	case when D.DocType = 'AD'
		then V.ApplyRefNbr
		else ''
		end,
	C.BWAmt,
	'',									-- Check Cury ID
	0, 
	'',
	V.CpnyID, 	
	D.CheckRefNbr,				-- Used to aggregate Checks....V.RefNbr, SL uses same VO number when combining docs on the same check
	C.CuryBWAmt,			
	coalesce(CU.DecPl, 2), 	
   	D.CuryDiscAmt,						-- CuryDiscBal
  	D.CuryDiscAmt,						-- CuryDiscTkn
    	case when D.DocType = 'AD'
    		then -(D.CuryPmtAmt + D.CuryDiscAmt)
    		else (D.CuryPmtAmt + D.CuryDiscAmt)
    		end,						-- CuryDocBal
   	V.CuryEffDate, 
   	D.CuryID,
   	D.CuryMultDiv,
   	case when D.DocType = 'AD'
    		then -D.CuryPmtAmt
    		else D.CuryPmtAmt
    		end,						-- CuryPmtAmt
   	D.CuryRate,
   	V.CuryRateType, 
   	D.DiscAmt,							-- DiscBal
   	V.DiscDate, 
   	D.DiscAmt,							-- DiscTkn
   	D.PmtAmt + D.DiscAmt,				-- DocBal
	V.DocDesc, 
	V.DocType, 
	V.DueDate,
	case when XD.Status = 'Y'			-- EBActive
		then 1
		else 0
		end,
	'',						-- EBBatNbr
	dbo.XDDGetOffSetDate(C.DateEnt, case when TT.TxnNACHA = 1	-- EBFormatID 	(XD = XDDDepositor -> APDoc Check)
					then 'US-ACH'		        --		Could be non US-ACH on vendor, but Nacha Txn
					else coalesce(XD.FormatID, '')
					end),				-- C.DateEnt, V.PayDate

	coalesce(TT.ChkWF, 'C'),			-- EBChkWF
        coalesce(TT.ChkWF_CreateMCB, ''),	        -- EBChkWF_CreateMCB
	case when (XF.FormatType = 'E' and @ModEFTEMail = 'Y') or (XF.FormatType = 'W' and @ModWireEmail = 'Y')	-- EBEmailNotif
		then case when XD.EMNotification = 'Y'
			then	1
			else	0	
			end
		else 0
		end,
	coalesce(TT.EntryClass, ''),		        -- EBEntryClass (from XDDTxnType for this Vendor/Voucher/eStatus)
	V.EStatus,					-- EBEStatus,	
	case when TT.TxnNACHA = 1			-- EBFormatID 	(XD = XDDDepositor -> APDoc Check)
		then 'US-ACH'				--		Could be non US-ACH on vendor, but Nacha Txn
		else coalesce(XD.FormatID, '')
		end,			
--	coalesce(XD.FormatID, ''),			-- EBFormatID 	(XD = XDDDepositor -> APDoc Check)
	'',						-- EBGroup
	V.InvcDate,					-- EBInvcDate
	V.InvcNbr,					-- EBInvcNbr
	case when (XF.FormatType = 'W'		        -- EBNACHATxn	(XF = XFFFileFormat -> XDDDepositor)
		and TT.txnNACHA = 1) or rtrim(XD.FormatID) = 'US-ACH'
		then 1
		else 0
		end,
	case when (XF.PreNote = 1 and TT.TxnPreNote = 1)	-- EBPreNoteApp (Format & TxnType using Prenotes)
		then case XD.PNStatus			        -- 		Depositor PreNote Status
		 	when 'N' then 0				-- 		New - PreNote NOT approved
			when 'A' then 1				-- 		Approved
			when 'P' then
				case when PNDate <= @CurrDate 
					then 1
					else 0			-- 		Pending, and PNDate in future - NOT Approved
					end
			else 0
			end
		else 1						-- 		Format doesn't use prenotes (or does, but TxnType doesn't), then approved
		end,						-- 		1 = PreNote is approved, 0= PreNote NOT approved
	case when TT.FilterSeparateFile = 1	                -- EBSeparateTxnType
		then coalesce(TT.TxnType, '')
		else ''
		end,
	case when XD.TermDate <> convert(smalldatetime, '01/01/1900') and XD.TermDate <= GetDate() 	-- EBTerminated
		then 1
		else 0
		end,	
	coalesce(TT.TxnType, ''),			-- EBTxnType (from XDDTxnType for this Vendor/Voucher/eStatus
	coalesce(V.eConfirm, ''),			-- EBVendAcct
	0, 
	VE.MultiChk, 
	V.PayDate,
        D.PmtAmt,					-- PmtAmt
   	V.RefNbr, 
	VE.ReqBkupWthld,
	V.S4Future01,     
	V.S4Future02,     
	V.S4Future03,     
	V.S4Future04,     
	V.S4Future05,     
	V.S4Future06,     
	V.S4Future07,     
	V.S4Future08,     
	0,									-- V.S4Future09,  (we now use when building MCB)
	V.S4Future10,     
	V.S4Future11,     
    	case when D.DocType = 'AD'
    		then V.S4Future12
   		else V.MasterDocNbr
   		end, 
   	V.Sub,
   	C.Acct,
   	C.Sub,
	V.User3,
	V.User4,
	V.User5,
	V.User6,
	V.User7,
	V.User8,
	V.VendID,
	VE.RemitName
--***MVA
	FROM	APCheckDet D (nolock) LEFT OUTER JOIN APCheck C (nolock)
   		ON D.BatNbr = C.BatNbr and D.CheckRefNbr = C.CheckRefNbr LEFT OUTER JOIN APDoc V (nolock)
   		ON D.DocType = V.DocType and D.RefNbr = V.RefNbr LEFT OUTER JOIN XDDDepositor XD (nolock)
   		ON XD.VendCust = 'V' and C.VendID = XD.VendID and V.eConfirm = XD.VendAcct LEFT OUTER JOIN XDDFileFormat XF (nolock)
   		ON XD.FormatID = XF.FormatID LEFT OUTER JOIN Vendor VE (nolock)
   		ON C.VendID = VE.VendID LEFT OUTER JOIN Currncy CU (nolock)
    		ON V.CuryID = CU.CuryID LEFT OUTER JOIN XDDTxnType TT (nolock)
   		ON XD.FormatID = TT.FormatID and V.EStatus = TT.EStatus
	WHERE	D.BatNbr = @BatNbr


   -- Now we need to summarize the data
   
   -- SL Check Batch (Group = blank)
   --	EBEStatus = blank
   --   EBActive = 0
   --	EBPreNoteApp = 0
   --   EBTerminated = 1

   -- Removed from Pmt Selection (Group = X)
   --	@FormatID Not Wire Plus Type and EBFormatID <> @FormatID
   --	OR (Is Wire Plus And EStatus <> US-ACH-NACHA value and EBFormatID <> @FormatID)
   --   OR (Is Wire Plas And EStatus =  US-ACH-NACHA value and EBFormatID <> US-ACH)

   -- No EMail/TxnType Filters
   --	(two possible batches - Wire Plus + US-ACH or just @FormatID)

   -- Make passes thru XDDWrkCheckSel - updating the EBGroup field for each pass
   --						Group
   -- Pass 1 - SL Check Batch			blank
   -- Pass 2 - Removed from Selection   	X
   -- Pass 3 - FormatID				0
   -- Pass 4 - If Wire & NACHA			1

      
   -- ---------------------------------------------------------------
   -- ---------------------------------------------------------------
   -- Pass 1 - SL Check Batch (not an EBanking txn or Not Approve PN)
   -- EBGroup	EBDescr				EBBatNbr
   -- _			SL Computer Checks	Current BatNbr
   -- ---------------------------------------------------------------
   -- ---------------------------------------------------------------
   UPDATE	XDDWrkCheckSel
   SET		EBGroup = '_',
   		EBBatNbr = @BatNbr,
		EBDescr = 'SL Computer Checks',
		EBFormatID = '',		-- Need to remove for grouping
		EBChkWF = 'C'			-- Need to set to Computer Check (C) - for grouping
   WHERE	AccessNbr = @AccessNbr   
   		and (EBEStatus = ' '
   		or EBActive = 0
   		or EBPreNoteApp = 0
   		or EBTerminated = 1)
   		
   -- ---------------------------------------------------------------
   -- ---------------------------------------------------------------
   -- Pass 2 - Remove from Pmt Batch (eBanking, but wrong Format ID)
   --			If a NACHATxn, even if not matching Format ID, then DO NOT throw away
   -- EBGroup	EBDescr	EBBatNbr
   -- R			To be Removed...	blank
   -- ---------------------------------------------------------------
   -- ---------------------------------------------------------------
   UPDATE	XDDWrkCheckSel
   SET		EBGroup = 'R',			-- "Remove" batch
   		EBBatNbr = '',
		EBDescr = 'To be Removed, Vendors'' Format is not: ' + rtrim(@FormatID),
		EBFormatID = ''			-- Need to remove for grouping
   WHERE	AccessNbr = @AccessNbr   
   		and EBGroup = ' '
   		and EBNACHATxn = 0	
   		and ((@WirePlusFormat = 0 and EBFormatID <> @FormatID)
   		or (@WirePlusFormat = 1 and Left(EBEntryClass, 3) NOT IN ('PPD','CCD','IAT') and EBFormatID <> @FormatID)
   		or (@WirePlusFormat = 1 and Left(EBEntryClass, 3)     IN ('PPD','CCD','IAT') and EBFormatID NOT IN ('US-ACH','CA-ACH'))
   		or EBPreNoteApp = 0
   		or EBTerminated = 1)


   SET @GrpNbr = 0   
   SET @GrpNbrStr = convert(varchar(1), @GrpNbr)
   -- Determine if we have any SL Batches
   if exists(Select * FROM XDDWrkCheckSel (nolock)
	   	WHERE 	AccessNbr = @AccessNbr   
	   			and EBGroup = '_')
		SET @SLBatch = 1
   else
   		SET @SLBatch = 0
   
   -- ---------------------------------------------------------------
   -- ---------------------------------------------------------------
   -- Pass 3 - Includes filters for SeparateTxnType, SettleDates and Multi-currency
   -- EBGroup	EBDescr			EBBatNbr
   -- #			Format: Name	blank or current
   -- ---------------------------------------------------------------
   -- ---------------------------------------------------------------

   -- Determine if need to split into settlement date batches
   SET		@NeedSettleDate = 0   
   if exists(SELECT * FROM XDDWrkCheckSel
   		WHERE	AccessNbr = @AccessNbr
   				and EBGroup = ''
   				and EBChkWF_CreateMCB = 'S')
   		SET	@NeedSettleDate = 1

print 'Need SettleDate: ' + convert(varchar(2), @NeedSettleDate)


print '----------------'
print 'Start Wire Pass'
print '----------------'

   -- Determine if we have both 'M'anual and 'C'omputer check batch txns
   SELECT 	@NbrChkWF = count(distinct EBChkWF)
   FROM		XDDWrkCheckSel (nolock)
   WHERE	AccessNbr = @AccessNbr
   			and EBGroup = ''

print 'NbrChkWF: ' + convert(varchar(2), @NbrChkWF)

   -- ---------------------------------------------------------------
   -- First eBanking Batch - not NACHA, must be Wire or non-USACH/EFT (and no EBGroup assigned yet)
   -- ---------------------------------------------------------------

   -- First do 'C'omputer check batches, then 'M'anual checks
   SET @ChkWF = '%'   
   If @NbrChkWF > 1	SET @ChkWF = 'C'

   -- Get Cpny/Acct/Sub for finding XDDBank
   SELECT TOP 1 	@CpnyID = CpnyID,
   			@Acct = User1,
   			@Sub = User2
   		FROM	XDDWrkCheckSel (nolock)
   		WHERE	AccessNbr = @AccessNbr
   					and EBGroup = ''
		ORDER BY 	CuryID
   
   -- Check if filtering by CuryID required
   SET @FilterMultiCury = 0
   SELECT @FilterMultiCury = WTFilterMultiCury 
   		FROM XDDBank (nolock)
   		Where CpnyID = @CpnyID
   			  and Acct = @Acct
   			  and Sub = @Sub

print 'Outside Loop - FilterMultiCury: ' + convert(varchar(2), @FilterMultiCury)
		   
   -- Outer loop, once for each ChkWF
   While (1=1)      
   BEGIN
   
	While (1=1)
	BEGIN
	
	   SET		@GroupedCnt = 0
	 
	   -- Batches left over
	   SELECT	@GroupedCnt = (Select count(Distinct EBGroup) FROM XDDWrkCheckSel (nolock)
				   	WHERE 	AccessNbr = @AccessNbr   
				   			and EBGroup <> '_' 
				   			and EBGroup <> 'R')

	   -- Set Current CuryID, if filtering by ID
	   if @FilterMultiCury = 1
	   BEGIN
   			SET @CurrCuryID = ''
            SET @CurrFormatID = ''
   			SELECT TOP 1 @CurrCuryID = CuryID,
   			            @CurrFormatID = EBFormatID
	   		FROM		XDDWrkCheckSel (nolock)
   			WHERE		AccessNbr = @AccessNbr
   						and EBGroup = ''
					    and EBNACHATxn = 0   
			ORDER BY 	CuryID, EBFormatID

print 'Insideside Loop - CurrCuryID: ' + @CurrCuryID
print 'Insideside Loop - CurrFormat: ' + @CurrFormatID

	   END
	   
	   -- Increment the GrpNbr - indicates another batch	
	   if exists(SELECT * FROM XDDWrkCheckSel
	   	   WHERE	AccessNbr = @AccessNbr
					and EBNACHATxn = 0   
					and EBGroup = ' '
					and EBSeparateTxnType = ''
					and ((@FilterMultiCury = 1 and CuryID = @CurrCuryID and EBFormatID = @CurrFormatID)
						or
						(@FilterMultiCury = 0))
				)
		   BEGIN
			   SET @GrpNbr = @GrpNbr + 1   
			   SET @GrpNbrStr = convert(varchar(1), @GrpNbr)
print 'Insideside Loop - Increase GrpNbr'
		   END
	   else
		   BEGIN
print 'Insideside Loop - No Increase GrpNbr, Break'
		   	   BREAK
	   	   END
	   	
	   if @NeedSettleDate = 1
	   BEGIN
	   	  -- Get Next SettleDate
		  -- Default to 0 in case not found
		  SET		@PayDate = 0
		  SELECT TOP 1 	@PayDate = PayDate
		  FROM		XDDWrkCheckSel
		  WHERE		AccessNbr = @AccessNbr
				and EBNACHATxn = 0   
				and EBGroup = ' '
				and EBSeparateTxnType = ''
				and EBChkWF_CreateMCB = 'S'
				and ( (@FilterMultiCury = 1 and CuryID = @CurrCuryID and EBFormatID = @CurrFormatID)
					  or
				  (@FilterMultiCury = 0)
						)
	   	  ORDER BY	PayDate
	   END

print 'Insideside Loop - About to Update - Format: ' + @FormatID

	   UPDATE	XDDWrkCheckSel
	   SET		EBGroup = case when rtrim(@FormatID) = rtrim(EBFormatID) and @GroupedCnt = 0
					then ''
					else @GrpNbrStr
					end,
				EBBatNbr = case when @SLBatch = 0 and @GroupedCnt <=1 	-- rtrim(@FormatID) = rtrim(EBFormatID) and @GroupedCnt = 0 
					then @BatNbr 
					else ''
					end,
				EBDescr = 'Format: ' + rtrim(@FormatID)
	   WHERE	AccessNbr = @AccessNbr
			and EBNACHATxn = 0   
			and EBGroup = ' '
			and EBSeparateTxnType = ''
			and ( ((@NeedSettleDate = 1 and PayDate = @PayDate and EBChkWF_CreateMCB = 'S')
				or (@NeedSettleDate = 1 and @PayDate = 0)
	                      )
			      	or
			      (@NeedSettleDate = 0)
			     )
			and EBChkWF LIKE @ChkWF
			and ( (@FilterMultiCury = 1 and CuryID = @CurrCuryID and EBFormatID = @CurrFormatID)
			       or
			      (@FilterMultiCury = 0)
			    )
	END	
	
print 'Wire Pass, end inner loop - ChkWF: ' + @ChkWF
	-- Does 'C'omputer checks first, then 'M'anual batches
	if @ChkWF = '%' or @ChkWF = 'M'
		BREAK
	else
		SET @ChkWF = 'M'			      
   
   END  -- Each @ChkWF type - Computer, Manual

-- RETURN   
print '----------------'
print 'Start ACH Pass'
print '----------------'
   
   -- ---------------------------------------------------------------
   -- Next eBanking Batch - ACH and no EBGroup assigned yet
   -- ---------------------------------------------------------------
   -- EBGroup	EBDescr				EBBatNbr
   -- #		Format: US-ACH (BatFormat)	blank or current
   -- #		Format: US-ACH (WireFormat)	blank or current
   -- #		Format: US-ACH 			blank or current
   -- 

   SET @ChkWF = '%'   
   If @NbrChkWF > 1	SET @ChkWF = 'C'

   -- Outer loop, once for each ChkWF
   While (1=1)      
   BEGIN
   
	While (1=1)
	BEGIN
	
	   SET		@GroupedCnt = 0
	   SELECT	@GroupedCnt = (Select count(distinct EBGroup) FROM XDDWrkCheckSel (nolock)
				   	WHERE 	AccessNbr = @AccessNbr   
				   		and EBGroup <> '_' 
				   		and EBGroup <> 'R' 
				   		and EBGroup <> @GrpNbrStr)
	

	   -- Set Current CuryID, if filtering by ID
	   if @FilterMultiCury = 1
	   BEGIN
   			SET @CurrCuryID = ''
			SET @CurrFormatID = ''
   			SELECT TOP 1 	@CurrCuryID = CuryID,
   			            	@CurrFormatID = EBFormatID
	   		FROM		XDDWrkCheckSel (nolock)
   			WHERE		AccessNbr = @AccessNbr
   					and EBGroup = ''
					and EBNACHATxn = 1  
			ORDER BY 	CuryID, EBFormatID

print 'Insideside Loop - CurrCuryID: ' + @CurrCuryID
print 'Insideside Loop - CurrFormat: ' + @CurrFormatID

	   END


	   if exists(SELECT * FROM XDDWrkCheckSel
	   			WHERE AccessNbr = @AccessNbr
				and EBNACHATxn = 1   
				and EBGroup = ' '
				and EBSeparateTxnType = '')
	   BEGIN
		   SET @GrpNbr = @GrpNbr + 1   
		   SET @GrpNbrStr = convert(varchar(1), @GrpNbr)
print 'Insideside Loop - Increase GrpNbr'
	   END

	   else

	   BEGIN
print 'Insideside Loop - No Increase GrpNbr, Break'
	   		BREAK
	   END
	   
	   if @NeedSettleDate = 1
	   BEGIN
	   	-- Get Next SettleDate
		-- Default to 0 in case not found
		SET		@PayDate = 0
		SELECT TOP 1 	@PayDate = PayDate
		FROM		XDDWrkCheckSel
		WHERE		AccessNbr = @AccessNbr
				and EBNACHATxn = 1   
				and EBGroup = ' '
				and EBSeparateTxnType = ''
				and EBChkWF_CreateMCB = 'S'
	   	ORDER BY	PayDate
	   END
	
	   	
	   -- Check if some records have been already been assigned to the current batch number
	   if exists (SELECT * from XDDWrkCheckSel	
	   		WHERE 	AccessNbr = @AccessNbr
	   			and EBBatNbr = @BatNbr)
			SET	@BatNbrUsed = 1
	   else
			SET	@BatNbrUsed = 0
					
print 'Insideside Loop - About to Update - Format: ' + @FormatID

	   UPDATE	XDDWrkCheckSel
	   SET		EBGroup = case when rtrim(@FormatID) = rtrim(EBFormatID) and @GroupedCnt = 0
					then ''
					else @GrpNbrStr
					end,
			EBBatNbr = case when @SLBatch = 0 and @BatNbrUsed = 0 	-- rtrim(@FormatID) = rtrim(EBFormatID) and @GroupedCnt = 0 
					then @BatNbr
					else ''
					end,
			EBDescr = case when rtrim(@FormatID) <> 'US-ACH'
					then 'Format: US-ACH (' + rtrim(@FormatID) + ')'
					else case when rtrim(EBFormatID) <> 'US-ACH'
						then 'Format: US-ACH (' + rtrim(EBFormatID) + ')'
						else 'Format: US-ACH'
						end
					end,
			EBFormatID = case when rtrim(@FormatID) <> 'US-ACH'
					then 'US-ACH'
					else EBFormatID
					end
	   WHERE	AccessNbr = @AccessNbr
				and EBNACHATxn = 1   
				and EBGroup = ' '
				and EBSeparateTxnType = ''
				and ( ((@NeedSettleDate = 1 and PayDate = @PayDate and EBChkWF_CreateMCB = 'S')
					or (@NeedSettleDate = 1 and @PayDate = 0)
	                      )
					or
					(@NeedSettleDate = 0)
					)  
				and EBChkWF LIKE @ChkWF
				and ((@FilterMultiCury = 1 and CuryID = @CurrCuryID and EBFormatID = @CurrFormatID)
 					or
					(@FilterMultiCury = 0))
	
		END
print 'ACH Pass, end inner loop - ChkWF: ' + @ChkWF
		if @ChkWF = '%' or @ChkWF = 'M'
			BREAK
		else
			SET @ChkWF = 'M'			      
   END
   
print 'Start SeparateTxns'
   
   -- ---------------------------------------------------------------
   -- All that is left are SeparateTxnTypes (if any)
   -- ---------------------------------------------------------------
   SET @ChkWF = '%'   
   If @NbrChkWF > 1	SET @ChkWF = 'C'

   -- Outer loop, once for each ChkWF
   While (1=1)      
   BEGIN
   
	While (1=1)
	BEGIN
	
		SET		@SeparateTxnType = ''
		SELECT TOP 1 	@SeparateTxnType = EBSeparateTxnType
		FROM		XDDWrkCheckSel (nolock)
		WHERE		AccessNbr = @AccessNbr
				and EBGroup = ' '
		
		print 'SepTxn: ' + @SeparateTxnType
		
		if @SeparateTxnType = '' BREAK
		
		SET @GrpNbr = @GrpNbr + 1   
		SET @GrpNbrStr = convert(varchar(1), @GrpNbr)
		
		-- Check if some records have been already been assigned to the current batch number
		if exists (SELECT * from XDDWrkCheckSel	
				WHERE 	AccessNbr = @AccessNbr
					and EBBatNbr = @BatNbr)
			SET	@BatNbrUsed = 1
		else
			SET	@BatNbrUsed = 0
		
		if @NeedSettleDate = 1
		BEGIN
		   	-- Get Next SettleDate
			-- Default to 0 in case not found
			SET		@PayDate = 0
			SELECT TOP 1 	@PayDate = PayDate
			FROM		XDDWrkCheckSel
			WHERE		AccessNbr = @AccessNbr
					and EBGroup = ' '
					and EBSeparateTxnType = @SeparateTxnType
					and EBChkWF_CreateMCB = 'S'
		   	ORDER BY	PayDate
		
		print 'PayDate: ' + convert(varchar(12), @PayDate)
		
		END
					
		UPDATE	XDDWrkCheckSel
		SET	EBGroup = case when rtrim(@FormatID) = rtrim(EBFormatID) and @GroupedCnt = 0
				then ''
				else @GrpNbrStr
				end,
			EBBatNbr = case when @SLBatch = 0 and @BatNbrUsed = 0 	-- rtrim(@FormatID) = rtrim(EBFormatID) and @GroupedCnt = 0 
				then @BatNbr
				else ''
				end,
			EBDescr = case when rtrim(@FormatID) = 'US-ACH'
				then 'Format: US-ACH'
				else case when EBNACHATxn = 1
					then 'Format: US-ACH (' + rtrim(EBFormatID) + ')'
					else 'Format: ' + rtrim(@FormatID)
					end
				end 
				+ ' (' + rtrim(EBTxnType) + ')'		-- add TxnType
		WHERE	AccessNbr = @AccessNbr
				and EBGroup = ' '
				and EBSeparateTxnType = @SeparateTxnType
				and ( ((@NeedSettleDate = 1 and PayDate = @PayDate and EBChkWF_CreateMCB = 'S')
					or (@NeedSettleDate = 1 and @PayDate = 0)
		              )
					or
					(@NeedSettleDate = 0)
					)  
				and EBChkWF LIKE @ChkWF
		END
print 'Separate Txn Pass, end inner loop - ChkWF: ' + @ChkWF
		if @ChkWF = '%' or @ChkWF = 'M'
			BREAK
		else
			SET @ChkWF = 'M'			      
   END

   -- Check if we have any MCBs
   --	along with batch by Settlement Date or Separate by File
   -- If we have AD txns they might now be mixed across various batches

   -- CheckRefNbr	Voucher		VendAcct+PayBy	CuryID
   -- 000001		1		A		AB
   --			2		A		AB
   --			3		B		AB
   -- With ADs - mixed VendAccts+PayBys are no good
   --  			  mixed curyIDs are no good

   --***MVA
   -- Set Flag for MVA
   SET		@MultiVendAcctUse = 0 
   SELECT 	@MultiVendAcctUse = MultiVendAcctUse
   FROM		XDDSetupEx (nolock)
	  
   if exists(Select * from XDDWrkCheckSel (nolock) WHERE DocType = 'AD')
   BEGIN

   	-- Remove all txns for a CheckRefNbr if an AD and if we have more than one FormatID + VendAcct + PayBys combo
   	--	or we have more than one EBGroup (could have one FormatID+PayBy but two groups because of Settlement Date)
   	-- Use 'D' for this group?, so we can write to Event Log
	While (1=1)
	BEGIN

		-- Set by SL CheckRefNbr is by Vendor - if Separate Check option, then 1 for each voucher
		SET		@CheckRefNbr = ''


		--***MVA
		If @MultiVendAcctUse = 1	
		BEGIN	
			--***MVA
			SELECT TOP 1 	@CheckRefNbr = W.CheckRefNbr + W.EBVendAcct
			FROM		XDDWrkCheckSel W (nolock)
			WHERE		W.AccessNbr = @AccessNbr
					and ( ((Select count(distinct EBFormatID + EBVendAcct + EBeStatus + CuryID) FROM XDDWrkCheckSel (nolock) 
						Where CheckRefNbr + EBVendAcct = W.CheckRefNbr + W.EBVendAcct) > 1)
						or 
				  	       ((Select count(distinct EBGroup) FROM XDDWrkCheckSel (nolock) Where (CheckRefNbr + EBVendAcct) = rtrim(W.CheckRefNbr + W.EBVendAcct)) > 1)
				    	    )
					and exists(Select * FROM XDDWrkCheckSel (nolock) WHere rtrim(CheckRefNbr + EBVendAcct) = rtrim(W.CheckRefNbr + W.EBVendAcct) and Doctype = 'AD')
					and W.S4Future09 = 0

			-- When no more are found... exit
			if @CheckRefNbr = '' BREAK
		
			-- This CheckRefNbr + EBVendAcct has an AD and PayBys are different
			--***MVA
	   		UPDATE	XDDWrkCheckSel
			SET	EBGroup = 'D',			-- "AD - Remove" batch
			   	EBBatNbr = '',
				EBDescr = case when @FilterMultiCury = 0
						then 'To be Removed, ADs and Multiple Account+PayBys and/or Batches'
						else 'To be Removed, ADs and Multiple Account+PayBys, Currencies and/or Batches'
						end,
				EBFormatID = '',		-- Need to remove for grouping
				S4Future09 = 1
			WHERE	AccessNbr = @AccessNbr   
		   		and CheckRefNbr + EBVendAcct = @CheckRefNbr
		END

		else

		BEGIN
		-- Not using MVA
			SELECT TOP 1 	@CheckRefNbr = W.CheckRefNbr
			FROM		XDDWrkCheckSel W (nolock)
			WHERE		W.AccessNbr = @AccessNbr
					and ( ((Select count(distinct EBFormatID + EBeStatus + CuryID) FROM XDDWrkCheckSel (nolock) Where CheckRefNbr = W.CheckRefNbr) > 1)
				      		  or 
				      		  ((Select count(distinct EBGroup) FROM XDDWrkCheckSel (nolock) Where CheckRefNbr = W.CheckRefNbr) > 1)
				    		)
					and exists(Select * FROM XDDWrkCheckSel (nolock) WHere CheckRefNbr = W.CheckRefNbr and Doctype = 'AD')
					and W.S4Future09 = 0

			-- When no more are found... exit
			if @CheckRefNbr = '' BREAK
		
			-- This CheckRefNbr has an AD and PayBys are different
		   	UPDATE	XDDWrkCheckSel
			SET	EBGroup = 'D',			-- "AD - Remove" batch
			   	EBBatNbr = '',
				EBDescr = case when @FilterMultiCury = 0
						then 'To be Removed, ADs and Multiple PayBys and/or Batches'
						else 'To be Removed, ADs and Multiple PayBys, Currencies and/or Batches'
						end,
				EBFormatID = '',		-- Need to remove for grouping
				S4Future09 = 1
			WHERE	AccessNbr = @AccessNbr   
		   		and CheckRefNbr = @CheckRefNbr

		END

	END

	-- Reset S4Future09
	UPDATE	XDDWrkCheckSel
	SET	S4Future09 = 0
	WHERE	AccessNbr = @AccessNbr

   END
   
   -- Now remove the SL Checks "_" placeholder
   UPDATE		XDDWrkCheckSel
   SET			EBGroup = ' '
   WHERE		AccessNbr = @AccessNbr   
   			and EBGroup = '_'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDWrkCheckSel_Load] TO [MSDSL]
    AS [dbo];

