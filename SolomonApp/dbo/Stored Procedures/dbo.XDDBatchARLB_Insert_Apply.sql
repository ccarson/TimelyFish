
CREATE PROCEDURE XDDBatchARLB_Insert_Apply
	@PmtDocType		varchar(2),			-- DocType applying 'CM' or 'PA'
	@ChkAmt			float,				-- check amount or CM original balance (Pmt Currency)
	@LBBatNbr		varchar( 10 ),
	@CustID			varchar( 15 ),
	@InvcNbr		varchar( 10 ),
	@InvApplyAmt		float,				-- amount to apply to the invoice (Pmt Currency)
	@DiscApplyAmt		float,				-- in Pmt currency
	@ChkDate		smalldatetime,
	@PmtCuryPrec		smallint,
	@CurrDate		smalldatetime,
	@Crtd_Prog		varchar( 8 ),
	@Crtd_User		varchar( 10 ),
	@PmtRecordID		int,				-- RecordID from XDDBatchARLB (Good grid)
	@ApplicMethod		varchar( 2 ),
	@ChkNbr			varchar( 10 ),			-- Check/CM Number
	@BaseCuryID		varchar( 4 ) 


AS
	Declare @AlwaysApplyDisc	smallint
	Declare	@AmtApplied		float
	Declare @ApplyAmt		float
	Declare @ApplyAmtRem		float
	Declare @CMCurrentBal		float
	Declare @CMRemainBal		float
	Declare @CuryDocBal		float
	Declare @CuryDiscBal		float
	Declare @CuryID			varchar( 4 )
	Declare @DiscBal		float
	Declare @DiscBalPmtCury		float
	Declare @DiscDate		smalldatetime
	Declare @DocBal			float
	Declare @DocSeq			varchar(1)
	Declare @DocType		varchar( 2 )
	Declare @InvBal			float
	Declare @InvBalPmtCury		float
	Declare @InvCuryID		varchar( 4 )
	Declare @LineNbr		smallint
	Declare @LineNbrInc		smallint
	Declare @MaxToApply		float
	Declare @OtherApplPending	bit
	Declare @PmtCuryID		varchar( 4 )
	Declare @PmtCuryRateType	varchar( 6 )
	Declare @PmtCuryEffDate		smalldatetime
	Declare @RefNbr			varchar( 10 )
	Declare	@SumApplyAmtPmtCury	float
	Declare	@SumDiscApplyAmtPmtCury	float
	Declare @TotalRemBal		float

	-- DN	Document number order (lowest to highest LH)
	-- IN	Invoice number order (first applied to invoices (LH), then DM, Fin Chrg)
	-- DD	Oldest due date (any doc type - when tied, then LH doc nbr)
	-- DI	Oldest due date (Invoices first) (then DM, Fin Chrg)
	-- DA	Oldest document date
	-- NO	No application						

	SET NOCOUNT ON

	-- -------------------------------------------------------
	-- Get Values from XDDSetupEx
	-- -------------------------------------------------------	
	SET	@AlwaysApplyDisc = 0
	SELECT	@AlwaysApplyDisc = LBAlwaysApplyDisc
	FROM	XDDSetupEx (nolock)

	-- -------------------------------------------------------
	-- Get Values from XDDBatch
	-- -------------------------------------------------------	
	SELECT	@PmtCuryID = CuryID,
		@PmtCuryRateType = CuryRateType,
		@PmtCuryEffDate = CuryEffDate
	FROM	XDDBatch (nolock)
	WHERE	BatNbr = @LBBatNbr
		and FileType = 'L'
	
	if rtrim(@InvcNbr) <> ''
	BEGIN
		-- Specific Invoice
		DECLARE         Doc_Cursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT TOP 1	RefNbr,	
				DocType, 
				CuryDocBal,
				CuryDiscBal,
				DiscDate,
				'1' As DocSeq,
				CuryID,
				DocBal,
				DiscBal
		FROM            ARDoc (nolock)
		WHERE		CustID = @CustID
				and RefNbr = @InvcNbr
				and OpenDoc = 1
				and CuryDocBal > 0
	END
	
	else
	
	BEGIN
		-- Blank Applic Method or No Application or Not one of the defined methods
		if rtrim(@ApplicMethod) = '' 
			or rtrim(@ApplicMethod) = 'NO' 
			or CHARINDEX(@ApplicMethod, 'DN,IN,DD,DI,DA,') = 0
			GOTO ABORT

		if rtrim(@ApplicMethod) = 'DN'	-- Document number order
			-- Lowest to Highest RefNbr order
		        DECLARE         Doc_Cursor CURSOR LOCAL FAST_FORWARD
            		FOR
			SELECT 		RefNbr,
					DocType,
					CuryDocBal,
					CuryDiscBal,
					DiscDate,
					'1' As DocSeq,
					CuryID,
					DocBal,
					DiscBal
			FROM            ARDoc (nolock)
			WHERE		CustID = @CustID
					and DocType IN ('IN', 'DM', 'FI')
					and OpenDoc = 1
					and CuryDocBal > 0
			ORDER BY	RefNbr		

		if rtrim(@ApplicMethod) = 'IN'	-- Invoice number order
			-- DocType = 'IN' (RefNbr low to high), then DM, FI
		        DECLARE         Doc_Cursor CURSOR LOCAL FAST_FORWARD
            		FOR
			SELECT 		RefNbr,
					DocType,
					CuryDocBal,
					CuryDiscBal,
					DiscDate,
					case DocType
					when 'IN' then '1'
					when 'DM' then '2'
					when 'FI' then '3'
					end As DocSeq,
					CuryID,
					DocBal,
					DiscBal
			FROM            ARDoc (nolock)
			WHERE		CustID = @CustID
					and DocType IN ('IN', 'DM', 'FI')
					and OpenDoc = 1
					and CuryDocBal > 0
			ORDER BY	DocSeq, RefNbr

		if rtrim(@ApplicMethod) = 'DD'	-- Oldest Due Date, then Document Nbr
			-- Oldest Due Date (all doctypes), then by RefNbr
		        DECLARE         Doc_Cursor CURSOR LOCAL FAST_FORWARD
            		FOR
			SELECT 		RefNbr,
					DocType,
					CuryDocBal,
					CuryDiscBal,
					DiscDate,
					case DocType
					when 'IN' then '1'
					when 'DM' then '2'
					when 'FI' then '3'
					end As DocSeq,
					CuryID,
					DocBal,
					DiscBal
			FROM            ARDoc (nolock)
			WHERE		CustID = @CustID
					and DocType IN ('IN', 'DM', 'FI')
					and OpenDoc = 1
					and CuryDocBal > 0
			ORDER BY	DueDate, RefNbr

		if rtrim(@ApplicMethod) = 'DI'	-- Oldest Due Date
			-- Oldest Due Date (IN's first, then rest), then DM, FI
		        DECLARE         Doc_Cursor CURSOR LOCAL FAST_FORWARD
            		FOR
			SELECT		RefNbr,
					DocType,
					CuryDocBal,
					CuryDiscBal,
					DiscDate,
					case DocType
					when 'IN' then '1'
					when 'DM' then '2'
					when 'FI' then '2'
					end As DocSeq,
					CuryID,
					DocBal,
					DiscBal
			FROM            ARDoc (nolock)
			WHERE		CustID = @CustID
					and DocType IN ('IN', 'DM', 'FI')
					and OpenDoc = 1
					and CuryDocBal > 0
			ORDER BY	DocSeq, DueDate, RefNbr

		if rtrim(@ApplicMethod) = 'DA'	-- Oldest Document Date
			-- Oldest Doc Date, then RefNbr
		        DECLARE         Doc_Cursor CURSOR LOCAL FAST_FORWARD
            		FOR
			SELECT		RefNbr,
					DocType,
					CuryDocBal,
					CuryDiscBal,
					DiscDate,
					case DocType
					when 'IN' then '1'
					when 'DM' then '2'
					when 'FI' then '3'
					end As DocSeq,
					CuryID,
					DocBal,
					DiscBal
			FROM            ARDoc (nolock)
			WHERE		CustID = @CustID
					and DocType IN ('IN', 'DM', 'FI')
					and OpenDoc = 1
					and CuryDocBal > 0
			ORDER BY	DocDate, RefNbr
	END
		
	if (@@error <> 0) GOTO ABORT

	-- Cycle through documents, making applications
	OPEN Doc_Cursor

	Fetch Next From Doc_Cursor into
	@RefNbr,
	@DocType,
	@CuryDocBal,
	@CuryDiscBal,
	@DiscDate,
	@DocSeq,
	@CuryID,
	@DocBal,
	@DiscBal
	
	SET	@AmtApplied = 0
	SET 	@TotalRemBal = 0			-- Remaining balances on all docs for this application
	SET	@LineNbr = -32768
	SET	@LineNbrInc = 32
	SET	@OtherApplPending = 0			-- Flag that some other applications are pending

	-- If a specific invoice, then use the specific Invoice Apply Amt
	-- Otherwise, use the full Check Amount
	if rtrim(@InvcNbr) <> ''
		SET	@ApplyAmtRem = @InvApplyAmt
	else
		SET	@ApplyAmtRem = @ChkAmt

	-- If CM, then determine the balance of the CM left to apply
	if @PmtDocType = 'CM'	
	BEGIN

		-- Check all XDDBatchARLBApplic records where this CM might have been applied
		SET	@SumApplyAmtPmtCury = 0
		EXEC XDDBatchARLBApplic_Get_Applications_CM
			@CustID, @ChkNbr, @SumApplyAmtPmtCury OUTPUT

		-- Get CM - Current Balance
		SET 	@CMCurrentBal = 0
		-- Need to convert to Pmt Currency
		SELECT  @CMCurrentBal = CuryDocBal,
			@InvCuryID = CuryID,
			@InvBal = DocBal
		FROM	ARDoc (nolock)
		WHERE	CustID = @CustID 
			and RefNbr = @ChkNbr
			and DocType = 'CM'

		-- If CM CuryID <> PmtCuryID then get CMCurrentBal in Pmt Currency
		if rtrim(@PmtCuryID) <> rtrim(@InvCuryID)
		BEGIN

			-- Translate InvBal (Base) to PmtCuryBal (Pmt Currency)
			EXEC XDDCurrency_From_To @BaseCuryID, @PmtCuryID, @PmtCuryRateType,
				@PmtCuryEffDate, @InvBal, 0, 0, '', '', @CMCurrentBal OUTPUT

		END
		
		-- Now Adjust (reduce) the CM Balance by the existing (not posted) applications
		SET @CMRemainBal = Round(@CMCurrentBal - @SumApplyAmtPmtCury, @PmtCuryPrec)

		-- The Amount to Apply is the smaller of two: ApplyAmtRem or CMRemainBal
		if @CMRemainBal < @ApplyAmtRem
			if @CMRemainBal < 0
				SET @ApplyAmtRem = 0
			else
				SET @ApplyAmtRem = @CMRemainBal

	END
	

	-- Add ALL Open documents to the table
	While (@@Fetch_Status = 0)
	BEGIN


		-- Assume that Pmt Cury = Doc Cury
		SET @InvBalPmtCury = @CuryDocBal
		SET @DiscBalPmtCury = @CuryDiscBal
	
		-- If CuryID <> PmtCuryID then get Inv/Disc Balances in Pmt Currency
		if rtrim(@PmtCuryID) <> rtrim(@CuryID)
		BEGIN

			-- Translate DocBal (Base) to InvBalPmtCury (Pmt Currency)
			EXEC XDDCurrency_From_To @BaseCuryID, @PmtCuryID, @PmtCuryRateType,
				@PmtCuryEffDate, @DocBal, 0, 0, '', '', @InvBalPmtCury OUTPUT

			-- Translate DocBal (Base) to DiscBalPmtCury (Pmt Currency)
			EXEC XDDCurrency_From_To @BaseCuryID, @PmtCuryID, @PmtCuryRateType,
				@PmtCuryEffDate, @DiscBal, 0, 0, '', '', @DiscBalPmtCury OUTPUT

		END

		-- CuryDocBal on an Invoice is the total amount of the invoice
		-- including any potential discount.
		-- Payments/CMs and/or Discount applied, reduce the CuryDocBal
		
		-- ------------------------------------------------------------
		-- CHECK OTHER APPLICATIONS
		-- Check for other applications against this very same document
		-- ------------------------------------------------------------
		-- Sum ApplyAmt, DiscApplyAmt from any XDDBatchARLBApplic
		--   records that are not in released/posted batches
		--        and not in this batch
		--   (released/posted batches will have updated CuryDocBal/CuryDiscBal)
		-- Key is CustID, DocType, RefNbr in all XDDBatchARLBApplic
		SET	@SumApplyAmtPmtCury = 0
		SET	@SumDiscApplyAmtPmtCury = 0
	
		-- Check all IN, DM, FI and sum the remaining balance to apply
		EXEC XDDBatchARLBApplic_Get_Applications
			@LBBatNbr, @CustID, @DocType, @RefNbr, @PmtRecordID, 0,
			@SumApplyAmtPmtCury OUTPUT, @SumDiscApplyAmtPmtCury OUTPUT

		if @SumApplyAmtPmtCury > 0 or @SumDiscApplyAmtPmtCury > 0 
			SET @OtherApplPending = 1		-- Flag that some other applications are pending
		
		-- Now Adjust (reduce) the InvBalPmtCury and DiscBalPmtCury by the above
		SET @InvBalPmtCury  = Round(@InvBalPmtCury  - @SumApplyAmtPmtCury, @PmtCuryPrec)
		SET @DiscBalPmtCury = Round(@DiscBalPmtCury - @SumDiscApplyAmtPmtCury, @PmtCuryPrec)

		-- @ApplyAmt - Amount to apply to this invoice
		-- @DiscApplyAmt - Amount of discount to apply
		-- The sum of these two cannot exceed the @CuryDocBal
		
		-- Only continue and apply if we have a positive balance
		if Round(@InvBalPmtCury, @PmtCuryPrec) > 0
		BEGIN	

			-- ----------------------------------------------------------
			-- DISCOUNT - Check if we can apply the Discount
			-- If Payment Date <= Discount Date
			-- With CM, only apply discount if specifically noted in the file
			-- ----------------------------------------------------------
			if (@PmtDocType = 'PA' and (@ChkDate <= @DiscDate or (@AlwaysApplyDisc = 1 and @DiscApplyAmt <> 0)))
			   or
			   (@PmtDocType = 'CM' and (@AlwaysApplyDisc = 1 and @DiscApplyAmt <> 0))
			BEGIN

				-- if the import file does have a discount amount, 
				-- then see portion we can apply
				if @DiscApplyAmt <> 0
				BEGIN

					-- If DiscApplyAmt > CuryDiscBal, then
					-- take the discount but only up to the CuryDiscBal
					if Round(@DiscApplyAmt - @DiscBalPmtCury, @PmtCuryPrec) > 0
						SET @DiscApplyAmt = @DiscBalPmtCury
					
				END
				
				else
				
				BEGIN
				-- Import file did not have a discount amount, we'll use the DiscBal

					-- Discount to apply will be the full discount balance
					SET @DiscApplyAmt = @DiscBalPmtCury
				
				END
			END
			
			else
			
			BEGIN
			-- ----------------------------------------------------------
			-- CANNOT TAKE DISCOUNT
			-- ----------------------------------------------------------

				-- Set DiscApplyAmt to Zero
				SET @DiscApplyAmt = 0
			
			END

			-- Now we have a @DiscApplyAmt
			-- @MaxToApply = Maximum of the CuryDocBal we can apply (assuming there might be some discount)
			SET @MaxToApply = Round(@InvBalPmtCury - @DiscApplyAmt, @PmtCuryPrec)

			-- If @DiscApplyAmt GT CuryDocBal, then only discount can be applied
			if @MaxToApply < 0
				SET @MaxToApply = 0
								
			-- ----------------------------------------------------------
			-- APPLY AGAINST THE BALANCE
			-- ----------------------------------------------------------
			-- If ApplyAmtRem = 1000
			if Round(@ApplyAmtRem - @MaxToApply, @PmtCuryPrec) > 0 
			BEGIN
				-- If CuryDocBal < 1000, eg 650
				-- ApplyAmt = 650, ApplyAmtRem = (1000-650 = 350)
				Set @ApplyAmt    = @MaxToApply
				Set @ApplyAmtRem = Round(@ApplyAmtRem - @MaxToApply, @PmtCuryPrec)
			END
	
			else	
	
			BEGIN
				-- Remaining Amount to Apply < Maximum that we can apply
				-- Therefore Amount to Apply = Remaining Amount
				-- If CuryDocBal >= 1000, eg 2000
				-- ApplyAmt = 1000, ApplyAmtRem = 0 (done)
				Set @ApplyAmt = @ApplyAmtRem
				Set @ApplyAmtRem = 0
				-- Remaining Balance = @MaxToApply - @ApplyAmt
			END	
			
			-- ----------------------------------------------------------
			-- ADD THE APPLICATION RECORD
			-- ----------------------------------------------------------
			-- Don't add, if already in the table
			if Not Exists(SELECT * from XDDBatchARLBApplic (nolock)
				WHERE 	LBBatNbr = @LBBatNbr
					and CustID = @CustID
					and DocType = @DocType
					and RefNbr = @RefNbr
					and PmtRecordID = @PmtRecordID)
			BEGIN
			
				-- Add XDDBatchARLBApplic record
				INSERT	INTO XDDBATCHARLBAPPLIC
				(ApplyAmount,
				Crtd_DateTime, Crtd_Prog, Crtd_User,
				CustID, DiscApplyAmount, DocType, 
				LBBatNbr, LineNbr,
				LUpd_DateTime, LUpd_Prog, LUpd_User,
				PmtRecordID, RefNbr
				)
				VALUES
				(@ApplyAmt,
				@CurrDate, @Crtd_Prog, @Crtd_User,
				@CustID, @DiscApplyAmt, @DocType,
				@LBBatNbr, @LineNbr,
				@CurrDate, @Crtd_Prog, @Crtd_User,
				@PmtRecordID, @RefNbr)
		
				SET	@LineNbr     = @LineNbr + @LineNbrInc
				SET	@AmtApplied  = Round(@AmtApplied + @ApplyAmt, @PmtCuryPrec)
				SET	@TotalRemBal = Round(@TotalRemBal + Round(@MaxToApply - @ApplyAmt, @PmtCuryPrec), @PmtCuryPrec)
			END
		END
		
		Fetch Next From Doc_Cursor into
		@RefNbr,
		@DocType,
		@CuryDocBal,
		@CuryDiscBal,
		@DiscDate,
		@DocSeq,
		@CuryID,
		@DocBal,
		@DiscBal

	END

	-- Post the total amount that was applied
	UPDATE	XDDBATCHARLB
	SET	AmountApplied = Round(AmountApplied + @AmtApplied, @PmtCuryPrec),
		TotalRemBal   = Round(TotalRemBal + @TotalRemBal, @PmtCuryPrec),
		SKFuture09    = case when @OtherApplPending = 1			-- Flag that some other applications are pending
				then convert(smallint, 1)
				else convert(smallint, 0)
				end
	WHERE	RecordID = @PmtRecordID

	Close Doc_Cursor
	Deallocate Doc_Cursor

ABORT:
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_Insert_Apply] TO [MSDSL]
    AS [dbo];

