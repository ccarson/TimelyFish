
CREATE PROCEDURE XDDBatchARLB_Insert
	@LBBatNbr		varchar(10),		-- Lockbox Batch Number
	@CpnyID			varchar(10),		-- Company receiving Payment
	@SolAcct		varchar(10),		-- Cash Account
        @SolSub			varchar(24),		-- Cash Subaccount
        @FilePathName		varchar(255),		-- Lockbox file path/name (could be in InProcess folder)
	@FileDate		smalldatetime,		-- Lockbox file date
	@FileRecord		smallint,		-- Lockbox file record number
	@FormatID		varchar(15),		-- Lockbox file Format ID
	@CustID			varchar(15),		-- Lockbox file data: CustID
	@CashAcct		varchar(10),		--	Cash Acct
	@InvApplyAmt		float,			--	Payment Amount for an Invoice (in Pmt Currency)
	@BankTransit		varchar(30),		--	Bank Transit Nbr
	@BankAcct		varchar(30),		--	Bank Acct Nbr
	@ChkAmt			float,			--	Amount of Check (in Pmt Currency)
	@DepositDate		smalldatetime,		--	Deposit Date
	@ChkNbr			varchar(10),		--	Check Nbr/CM Number
	@CustName		varchar(30),		-- 	Customer Name
	@InvcNbr		varchar(10),		--	Invoice Nbr to apply to
	@TxnDescr		varchar(30),		--	Transaction Description
        @DocType		varchar(2),		--	Document Type - 'PA', 'CM'
        @DiscApplyAmt		float,			--	Discount Amount (in Pmt CurrencY)
	@PmtCuryEffDate	 	smalldatetime,		-- Payment Currency Parms
	@PmtCuryID	 	varchar( 4 ),		
	@PmtCuryMultDiv	 	varchar( 1 ),
	@PmtCuryRate	 	float,
	@PmtCuryRateRecip 	float,
	@PmtCuryRateType 	varchar( 6 ),		
	@Crtd_Prog		varchar(8),	
	@Crtd_User		varchar(10),
	@ComputerName		varchar(21),
	@ErrRecordID		int		-- RecordID from XDDBatchARLBErrors
						-- when populated, then remove from table
						-- (this indicates a MOVE from Errors to Payments)

AS

	Declare @AllSameCury		tinyint
	Declare @AmtApplied		float
	Declare @ApplicMethod		varchar(2)
	Declare @AREntryClass		varchar(4)
	Declare @ARRecord		varchar(1)
	Declare @BaseCuryID		varchar( 4 )
	Declare @ChgdPmtAmt		float
	Declare @ChgdPmtAmtNew		float
	Declare @ChkAmtToCompare	float
	Declare @CMCustID		varchar(15)		-- CM customer ID
	Declare @CpnyIDInv		varchar( 10 )
	DECLARE @CurrDate		smalldatetime
	DECLARE @CurrTime		smalldatetime
	Declare @CustIDParm		varchar( 15 )
	Declare @ErrLineNbr		smallint
	Declare @InvBal			float
	Declare @InvBalPmtCury		float
	Declare @InvCuryID		varchar(4)
	Declare @InvcDocType		varchar( 2 )
	Declare @InvcLeftUnappl		smallint		-- Leave Inv unapplied - not master company
	Declare @LBAddMissingCM		smallint
	Declare @LBCustID		varchar(15)
	Declare @LineNbrInc		smallint
	Declare @MasterCpnyID		varchar( 10 )
	Declare @ModFormatID		varchar( 15 )
	Declare @MultiCpnyCentCash	bit			-- Multi-Company, centrailized cash
	Declare @MultiCurrency		bit			-- Multi-Company, centrailized cash
	Declare @MultiVendAcct		varchar( 10 )
	Declare @PmtCuryBal		float
	Declare @PmtCuryPrec		smallint
	Declare @PmtLineNbr		smallint
	Declare @PmtRecordID		int
	Declare @PmtMatchInvGood	smallint
	Declare @PmtMustMatchInv	smallint
	Declare @PNStatus		varchar(1)
	Declare @SetupApplicMethod	varchar( 2 )
	Declare @SuggCustGood		smallint
	Declare @VendAcct		varchar(10)
			
	-- Errors:
	Declare @CustIDErr	varchar(1)
	Declare @CustIDSugg	varchar(15)
	Declare @InvcNbrErr	varchar(1)
	
	-- When moving an Error record to a Payment record
	-- These are the "old" values
	Declare @ErrCustIDErr	varchar(1)
	Declare @ErrCustIDSugg	varchar(15)
	Declare @ErrInvcNbrErr	varchar(1)
	Declare @CustNameLU	varchar(30)

	-- skip over any records that are all blank
	if rtrim(@CustID +  @BankTransit + @BankAcct + @ChkNbr + @InvcNbr + @DocType) = ''
		and (@InvApplyAmt + @ChkAmt + @DiscApplyAmt) = 0
		RETURN
	
	SET 	@ErrCustIDErr = ''
	SET 	@ErrCustIDSugg = ''
	SET	@ErrInvcNbrErr = ''
	SET	@CustNameLU = ''
	SET	@CpnyIDInv = ''
	SET	@MultiCpnyCentCash = 0
	SET	@MasterCpnyID = ''
	SET	@InvcLeftUnappl =  0
	
	-- -----------------------------------------------------
	-- Determine if Multi-Company w/ Central Cash
	--	and Get BaseCuryID
	-- -----------------------------------------------------
	SELECT	@MultiCpnyCentCash = case when (Mult_Cpny_DB = 1 and Central_Cash_Cntl = 1)
		then 1
		else 0
		end,
		@MasterCpnyID = CpnyID,
		@BaseCuryID = BaseCuryID
	FROM	GLSetup (nolock)	

	-- -----------------------------------------------------
	-- With Multi-Currency, CuryID comes from Cash Account
	-- -----------------------------------------------------
	-- All values passed from Import Process
	SET @MultiCurrency = 0
	if Exists(Select * from CMSetup (nolock))
		SET @MultiCurrency = 1
		
	-- -----------------------------------------------------
	-- Get Values from XDDSetup and XDDSetupEx
	-- -----------------------------------------------------
	-- Get values from XDDSetup - used when adding a XDDDepositor record
	SELECT	@SetupApplicMethod = LBApplicMethod,
		@SuggCustGood = LBSuggCustGood,
		@ModFormatID = Case when ModAREFT = 'Y'
			then ModFormatID
			else 'US-ACH'
			end,
		@AREntryClass = ARACHEntryClass,
		@ARRecord = ARACHRecord,
		@PmtMustMatchInv = LBOnlyFullApplyGood		-- Move to Good grid, only when fully applied
	FROM	XDDSetup (nolock)

	-- Get values from XDDSetupEx
	-- ***MVA
	SET	@LBAddMissingCM = 0
	SET	@MultiVendAcct = ''
	SELECT	@LBAddMissingCM = LBAddMissingCM,		-- When importing, if CM does not exist, then add it
		@MultiVendAcct = MultiVendAcct
	FROM	XDDSetupEx (nolock)

	-- If no check amount in file, then set chkamt = InvApplyAmt
	if @ChkAmt = 0 SET @ChkAmt = @InvApplyAmt
	
	-- Only allow PA/CM document types
	if @DocType <> 'PA' and @DocType <> 'CM'
		SET @DocType = 'PA'

	-- Get Customer ID on CM
	SET	@CMCustID = ''
	if @DocType = 'CM'
	BEGIN
		Select	@CMCustID = CustID,
			@ChkAmt = CuryDocBal
		FROM	ARDoc (nolock)
		WHERE	DocType = 'CM'
			and RefNbr = @ChkNbr
	END
	
	-- If Payment does not have to match InvoiceBal, then OK to create Good record
	-- PmtMatchInvGood = 1, means that the Payment Amt matching the Inv. Bal checking is OK (one way or another)
	if @PmtMustMatchInv = 0 
		SET @PmtMatchInvGood = 1
	else	
		SET @PmtMatchInvGood = 0
	
	-- Determine what Pre-Note Status to use
	-- If using Pre-Notes, then set to "N"ew, else "A"pproved
	SELECT 	@PNStatus = case when PreNote = 1 
		then 'N'
		else 'A'
		end
	FROM	XDDFileFormat (nolock)
	WHERE	FormatID = @ModFormatID


	-- Determine if Suggestions should be Good Records
	-- If LB comes from XDDSetup, then use XDDSetup value
	-- else use XDDBank value
	SELECT		@SuggCustGood = case when LBFromSetup = 1
				then @SuggCustGood
				else LBSuggCustGood
				end
	FROM		XDDBank (nolock)
	WHERE		CpnyID = @CpnyID
			and Acct = @SolAcct
			and Sub = @SolSub
	
	-- If moving from an Error record, then Suggested Customer is ALWAYS Good
	if @ErrRecordID > 0
		SET	@SuggCustGood = 1

	-- -----------------------------------------
	-- Get highest LineNbrs from Payments/Errors
	-- -----------------------------------------

	SET	@LineNbrInc = 32
	
	-- Initialize the PmtLineNbr
	SET		@PmtLineNbr = -32768
	SELECT TOP 1	@PmtLineNbr = LineNbr + @LineNbrInc
	FROM		XDDBatchARLB
	WHERE		LBBatNbr = @LBBatNbr
	ORDER BY	LineNbr DESC

	-- Initialize the ErrLineNbr
	SET		@ErrLineNbr = -32768
	SELECT TOP 1	@ErrLineNbr = LineNbr + @LineNbrInc
	FROM		XDDBatchARLBErrors
	WHERE		LBBatNbr = @LBBatNbr
	ORDER BY	LineNbr DESC
		
	-- Date only and Time only vars
	-- SELECT @CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)
	-- SELECT @CurrTime = cast(convert(varchar(10), getdate(), 108) as smalldatetime)
	-- Put Full Date/Time into the "DateTime" fields
	SET @CurrDate = GetDate()

	-- -----------------------------------------------------
	-- BEGIN TRANSACTION
	-- -----------------------------------------------------
		
	-- Check to see if this is a new BatNbr
	If Not Exists(Select * From XDDBatch (nolock)
		Where 	Module = 'AR'
			and FileType = 'L'
			and BatNbr = @LBBatNbr)
	BEGIN
		-- Add XDDBatch record
		INSERT	INTO XDDBATCH
		(Acct, BatNbr, BatSeq, ComputerName, CpnyID, 
		Crtd_DateTime, Crtd_Prog, Crtd_User, 
		CuryEffDate, CuryID, CuryMultDiv, CuryRate, CuryRateReciprocal, CuryRateType,
		EffDate, DepDate, FileType, FormatID, KeepDelete, LBPerPost,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		Module, Sub
		)
		VALUES
		(@SolAcct, @LBBatNbr, 0, @ComputerName, @CpnyID,
		@CurrDate, @Crtd_Prog, @Crtd_User, 
		@PmtCuryEffDate, @PmtCuryID, @PmtCuryMultDiv, @PmtCuryRate, @PmtCuryRateRecip, @PmtCuryRateType,
		'01/01/1900', '01/01/1900', 'L', @FormatID, 'N', '',
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'AR', @SolSub
		)

		
		-- Increment to the Next
		UPDATE	XDDSetup
		SET	LBNextBatNbr = right('000000' + rtrim(Convert(varchar(6), Convert(int, @LBBatNbr) + 1)), 6)
	END

	-- First check to see if we have any errors
	-- This will determine which file we dump the data into

	-- ...Err - error code - what type of error (blank - value is OK)
	-- ...Sugg - suggested value via various lookups
	Set @CustIDErr = ''	-- blank - CustID supplied, lookup OK
				-- E-Empty value
				-- B-Bank/transit lookup (suggestion)
				-- N-Name lookup (suggestion)
				-- I-InvcNbr lookup (no longer suggestion - good pmt)
				-- M-Manual lookup (from WB Lookup tool)
				-- X-not found (no suggestion)
	Set @CustIDSugg = ''	-- Suggested CustID (used with B, N, M)
	Set @InvcNbrErr = ''	-- blank - InvcNbr supplied, lookup OK for the customer
				-- W-found, but for Wrong customer
				-- M-Manual lookup (from WB Lookup tool)
				-- G-Inv. Apply Amt > Invoice Bal
				-- E-Inv. Apply Amt = Invoice Bal (not used?)
				-- Q-Inv. Apply Amt <> Invoice Bal
				-- A-Inv. Apply Amt > Check Amt
				-- X-not found
				-- C-CM not found, and setup says do not add
				-- I-CM - found invoice, but customer number on CM <> customer on invoice
				-- B-CM - balance on CM is less than InvAmtApply
				-- P-Pending Cury Applic
	-- Default ApplicMethod to XDDSetup value				
	SET	@ApplicMethod = @SetUpApplicMethod

	-- Initialize Invoice Doc Balance (Pmt Currency(
	SET	@InvBalPmtCury = 0
	SET	@PmtCuryBal = 0
	
	-- ------------------------------------------------------------
	-- Customer ID Checks
	-- ------------------------------------------------------------
	-- We have a customer ID, check if it is valid
	if rtrim(@CustID) <> ''
	BEGIN
		if Not Exists(Select * from Customer (nolock) 
				where CustID = @CustID)
			Set @CustIDErr = 'X'
		else
			SELECT	@ApplicMethod = X.LBApplicMethod
			FROM	XDDDepositor X (nolock) LEFT OUTER JOIN Customer C (nolock)
				ON X.VendID = C.CustID
			WHERE	X.VendCust = 'C'
				and X.VendID = @CustID
	END
	else
	BEGIN
		-- Blank CustID
		Set @CustIDErr = 'E'
	END
		
	-- One of the two errors above occurred, try to find a suggestion
	-- X CustID not found, or blank CustID
	if @CustIDErr <> ''
	BEGIN
		-- Some error, try to find it based on Transit/Acct number
		-- on Transit/Acct number in XDDDepositor
		if rtrim(@BankTransit) <> '' and rtrim(@BankAcct) <> '' 
		BEGIN
			Select 	@CustIDSugg = X.VendID
			FROM	XDDDepositor X (nolock) LEFT OUTER JOIN Customer C (nolock)
				ON X.VendID = C.CustID
			WHERE	X.VendCust = 'C'
				and (rtrim(X.LBBankTransit) = rtrim(@BankTransit) or rtrim(X.BankTransit) = rtrim(@BankTransit))
				and (rtrim(X.LBBankAcct) = rtrim(@BankAcct) or rtrim(X.BankAcct) = rtrim(@BankAcct))

			-- If we found the CustID then Set Err to 'B'ank Transit
			if @CustIDSugg <> ''
				Set @CustIDErr = 'B'
			
			-- Try to find Cust based on Name - locate within Name...
			if @CustIDSugg = '' and @CustName <> ''
			BEGIN
				Select 	@CustIDSugg = CustID
				FROM	Customer (nolock)
				WHERE	charindex(@CustName, Name) > 0

				-- If we found the CustID then Set Err to 'N'ame
				if @CustIDSugg <> '' 
					Set @CustIDErr = 'N'
				else
				BEGIN
					-- try to match on first 10 chars of name
					Select 	@CustIDSugg = CustID
					FROM	Customer (nolock)
					WHERE	charindex(substring(@CustName,1,10), Name) > 0
					if @CustIDSugg <> '' 
						Set @CustIDErr = 'N'
				END
			END	-- try lookup on CustName
			
		END	-- try lookup on Bank/Transi

	END	-- CustID found


	SET	@PmtCuryPrec = 2
	-- What if there is no record in Currncy for this CuryID?
	SELECT	@PmtCuryPrec = c.DecPl
	FROM	Currncy c (nolock)
	WHERE	c.CuryID = @PmtCuryID


	-- ------------------------------------------------------------
	-- Invoice Number Checks
	-- ------------------------------------------------------------
	-- Can match based solely on Invoice Number - even if CustID is not found
	-- We have an InvcNbr, check if it is valid
	-- blank - InvcNbr supplied, lookup OK for the customer
	-- W-found, but for Wrong customer
	-- G-Inv. Apply Amt > Invoice Bal
	-- E-Inv. Apply Amt = Invoice Bal (not used?)
	-- Q-ChkAmt & InvBal are Not Equal
	-- A-Inv. Apply Amt > Chk Amt
	-- X-not found
	-- P-Pending Cury Applic (Error if any pending Applics (A/R or LB) that don't match CuryID/CuryRate
	-- C-Document is closed

	if rtrim(@InvcNbr) <> ''
	BEGIN
		-- We have an Invoice Number AND a Customer Number
		if rtrim(@CustID) <> ''
		BEGIN
			-- Invoice Nbr and Customer Nbr
			if Not Exists(Select * from ARDoc (nolock) 
				where 	CustID = @CustID
					and RefNbr = @InvcNbr
					and DocType IN ('IN', 'DM', 'FI'))
			BEGIN	
				-- Cannot find InvcNbr/CustNbr combined
				Set @InvcNbrErr = 'X'
				-- Check if InvcNbr is for another customer
				if Exists(Select * from ARDoc (nolock) 
					where 	CustID <> @CustID
						and RefNbr = @InvcNbr
						and DocType IN ('IN', 'DM', 'FI'))
					Set @InvcNbrErr = 'W'

			END
			
			else

			BEGIN
				-- Invoice Number found for this customer
				Set @InvcNbrErr = ''
				Set @InvBal = 0
				
				SELECT	@InvBalPmtCury = CuryDocBal,
					@CpnyIDInv = CpnyID,
					@InvCuryID = CuryID,
					@InvBal = DocBal,
					@InvcDocType = DocType
				FROM	ARDoc (nolock)
				WHERE	CustID = @CustID
					and rtrim(RefNbr) = rtrim(@InvcNbr)
					and DocType IN ('IN', 'DM', 'FI')

				-- If PmtCuryID <> InvCuryID, then must translate Inv Amts to Payment Cury
				if rtrim(@PmtCuryID) <> rtrim(@InvCuryID)
				BEGIN
					-- Translate InvBal (Base) to PmtCuryBal (Pmt Currency)
					-- Using PmtEffDate, PmtRateType
					EXEC XDDCurrency_From_To @BaseCuryID, @PmtCuryID, @PmtCuryRateType,
						@PmtCuryEffDate, @InvBal, 0, 0, '', '', @InvBalPmtCury OUTPUT
				END
				
				-- If Invoice Apply Amount GT Invoice Document Balance, then warning
				if round(@InvApplyAmt - @InvBalPmtCury, @PmtCuryPrec) > 0
					SET @InvcNbrErr = 'G'

				-- If Invoice Balance must match Payment Amount - check
				if @PmtMatchInvGood = 0
				BEGIN
					-- Payment exactly matches Invoice Amount
					-- Chamge from @ChkAmt
					if round(@InvApplyAmt - @InvBalPmtCury, @PmtCuryPrec) = 0
						SET @PmtMatchInvGood = 1
					else
					BEGIN
						-- if Accepted in Error grid move, then now allow
						if @ErrRecordID <> 0 
							SET @PmtMatchInvGood = 1
						else
						BEGIN
							-- Set flag that they are NOT Equal
							SET @InvcNbrErr = 'Q'
						END
					END
				END							

				-- Don't have an InvApplyAmt
				-- If Document Balance <= Check Amount then set InvApplyAmt = Doc Balance
				If @InvApplyAmt = 0
				BEGIN
					if round(@ChkAmt - @InvBalPmtCury, @PmtCuryPrec) >= 0
						SET @InvApplyAmt = @InvBalPmtCury
				END						

			END
		END
		
		else		
		
		BEGIN
			-- Blank Customer Nbr - lookup on Invoice Nbr only
			if Exists(Select * from ARDoc (nolock) 
				where 	rtrim(RefNbr) = rtrim(@InvcNbr)
					and DocType IN ('IN', 'DM', 'FI'))
			BEGIN
				-- Found InvcNbr
				SET @InvcNbrErr = ''
				SET @CustIDErr = 'I'
				if @CustIDSugg = '' 
					SET @CustIDSugg = (Select CustID from ARDoc (nolock) 
						where 	rtrim(RefNbr) = rtrim(@InvcNbr)
							and DocType IN ('IN', 'DM', 'FI'))

				SET	@InvBal = 0
				SELECT	@InvBalPmtCury = CuryDocBal,
					@CpnyIDInv = CpnyID,
					@InvCuryID = CuryID,
					@InvBal = DocBal,
					@InvcDocType = DocType
				FROM	ARDoc (nolock)
				WHERE	rtrim(RefNbr) = rtrim(@InvcNbr)
					and DocType IN ('IN', 'DM', 'FI')


				-- If PmtCuryID <> InvCuryID, then must translate Inv Amts to Payment Cury
				if rtrim(@PmtCuryID) <> rtrim(@InvCuryID)
				BEGIN
					-- Translate InvBal (Base) to PmtCuryBal (Pmt Currency)
					EXEC XDDCurrency_From_To @BaseCuryID, @PmtCuryID, @PmtCuryRateType,
						@PmtCuryEffDate, @InvBal, 0, 0, '', '', @InvBalPmtCury OUTPUT
				END

				-- If Invoice Apply Amount GT Invoice Document Balance, then warning
				if round(@InvApplyAmt - @InvBalPmtCury, @PmtCuryPrec) > 0
					SET @InvcNbrErr = 'G'

				-- If Invoice Balance must match Payment Amount - check
				if @PmtMatchInvGood = 0
				BEGIN
					-- Payment exactly matches Invoice Amount
					-- Change from @ChkAmt
					if round(@InvApplyAmt - @InvBalPmtCury, @PmtCuryPrec) = 0
						SET @PmtMatchInvGood = 1
					else
					BEGIN
						-- if Accepted in Error grid move, then now allow
						if @ErrRecordID <> 0 
							SET @PmtMatchInvGood = 1
						else
						BEGIN
							-- Set flag that they are NOT Equal
							SET @InvcNbrErr = 'Q'
						END
					END
				END	
				
				-- Don't have an InvApplyAmt
				-- If Document Balance <= Check Amount then set InvApplyAmt = Doc Balance
				If @InvApplyAmt = 0
				BEGIN
					if round(@ChkAmt - @InvBalPmtCury, @PmtCuryPrec) >= 0
						SET @InvApplyAmt = @InvBalPmtCury
				END						

			END

			else

			BEGIN
				-- Didn't find Invoice Nbr
				SET @InvcNbrErr = 'X'
			END
		END	-- have an invoice number
		
		-- We have an invoice number
		-- No Errors yet and using MultiCurrency
		if @InvcNbrErr = '' and @MultiCurrency = 1
		BEGIN
		
			if @CustID <> '' 			  SET @CustIDParm = @CustID
			if @CustIDParm = '' and @CustIDSugg <> '' SET @CustIDParm = @CustIDSugg
			
			if @CustIDParm <> ''
			BEGIN			
				-- Check if All Pending Applications (A/R & LB) for this invoice
				--	have the same CuryID and CuryRate
				--	If not, put in errors grid
				EXEC XDDLB_Pending_Applic_Check @PmtCuryID, @PmtCuryRate,
					@CustIDParm, @InvcNbr, 0, @AllSameCury OUTPUT

				if @AllSameCury = 0 SET @InvcNbrErr = 'P'
			END
			
		END


	END

	else

	BEGIN
		-- no invoice number - then no checking if check amount matches invoice balance
		SET @PmtMatchInvGood = 1
	END

	-- No invoice errors yet, do a check on the check amt and the invoice apply amt
	if @InvcNbrErr = ''
	BEGIN

		-- Default to LB File Check Amount
		SET @ChkAmtToCompare = @ChkAmt
		
		-- Determine if we're using Changed Payment Amounts and moving from Errors grid
		if @ErrRecordID <> 0 and (Select LBErrorShowChgdPmt FROM XDDSetupEx (nolock)) = 1
		BEGIN
			-- Retrieve ChgdPmtAmts
			SELECT	@ChgdPmtAmt = SKFuture03,	-- User has changed the Pmt Amt
				@ChgdPmtAmtNew = AmountChgd	-- New field 
			FROM	XDDBatchARLBErrors (nolock)
			WHERE	RecordID = @ErrRecordID	

			if @ChgdPmtAmt <> 0 		SET @ChkAmtToCompare = @ChgdPmtAmt
			else if @ChgdPmtAmtNew <> 0	SET @ChkAmtToCompare = @ChgdPmtAmtNew
		END

		-- Now do the comparison
		-- If Invoice Apply Amount GT Chk Amount, then error
		if round(@InvApplyAmt - @ChkAmtToCompare, @PmtCuryPrec) > 0
			SET @InvcNbrErr = 'A'

	END
	
	-- Checking on CMs
	-- InvcNbrErr
	-- C-CM not found, and setup says do not add
	-- I-CM - found invoice, but customer number on CM <> customer on invoice
	-- B-CM - balance on CM is less than InvAmtApply								
	if @DocType = 'CM'
	BEGIN
		-- Error if CM does not exist, and not allowed to add
		if @CMCustID = '' and @LBAddMissingCM = 0
			SET @InvcNbrErr = 'C'
		else
		BEGIN
			-- Found CM, but CustID or CustIDSugg does not match
			if rtrim(@CustID) <> rtrim(@CMCustID) and rtrim(@CustIDSugg) <> rtrim(@CMCustID)
			BEGIN
				SET @InvcNbrErr = 'I'
				SET @CustIDSugg = ''		-- blank out so we get an error
			END

			-- Balance on CM < Invoice Amt to Apply, then error
			if round(@ChkAmt - @InvApplyAmt, @PmtCuryPrec) < 0
				SET @InvcNbrErr = 'B'
		END	
	END
						
	-- Good Records - 
	-- 1) CustIDErr blank or Invoice Nbr LU Name - OK
	-- 2) CustIDErr - Bank transit/Name/Manual
	--        and CustIDSugg non-blank
	--        and Option for Suggested Customers to be Good records
	-- 3) InvcNbrErr blank - OK
	-- 4) InvcNbrErr (G) - Amount to Apply > Invc Balance - OK
	-- 5) Payment does not have to match InvBal
	--	 or Payments does have to match and they do
	if ( (rtrim(@CustIDErr) = '' or rtrim(@CustIDErr) = 'I') 
	     OR 
	     (  (    rtrim(@CustIDErr) = 'B' 
	   	  or rtrim(@CustIDErr) = 'N'
	   	  or rtrim(@CustIDErr) = 'M'
	   	 )
   	       and rtrim(@CustIDSugg) <> ''
	       and @SuggCustGood = 1
	     )
	   )   
	   and (rtrim(@InvcNbrErr) = '' or rtrim(@InvcNbrErr) = 'G')
	   and @PmtMatchInvGood = 1

	BEGIN

		-- Lockbox file CustID
		SET @LBCustID = @CustID
		
		-- @CustIDSugg could be non-blank if SuggCustGood = 1 and CustIDErr = B/N/I
		if rtrim(@CustIDSugg) <> ''
		BEGIN
			SET @CustID = @CustIDSugg

			-- Get application method from customer
			SELECT	@ApplicMethod = LBApplicMethod
			FROM	XDDDepositor (nolock)
			WHERE	VendCust = 'C'
				and VendID = @CustID

		END
		
		-- Get Customer's name
		SELECT	@CustNameLU = Name
		FROM	Customer (nolock)
		WHERE	CustID = @CustID
		
		-- ErrRecordID <> 0 if we're moving an Error to a Payment
		-- In this case @CustID is actually the CustIDSugg,
		--	so we need to get the LB CustID
		if @ErrRecordID <> 0
		BEGIN
			SELECT	@LBCustID = CustID,
				@ErrCustIDErr = CustIDErr,
				@ErrCustIDSugg = CustIDSugg,
				@ErrInvcNbrErr = InvcNbrErr,
				@ChgdPmtAmt = SKFuture03,	-- User has changed the Pmt Amt
				@ChgdPmtAmtNew = AmountChgd	-- New field 
			FROM	XDDBatchARLBErrors (nolock)
			WHERE	RecordID = @ErrRecordID	

			-- This allows user to change Pmt Amt in Errors grid			
			-- @ChgdPmtAmt - old schema
			-- @ChgPmtAmtNew - v8 schema (setup option)
			if @ChgdPmtAmt <> 0 
				SET @ChkAmt = @ChgdPmtAmt
			else	
				if (Select LBErrorShowChgdPmt FROM XDDSetupEx (nolock)) = 1 
					and @ChgdPmtAmtNew <> 0
					SET @ChkAmt = @ChgdPmtAmtNew
				
		END
		
		-- If we have a invalid InvcNbr, then blank the InvcNbr
		-- We're here because we have a valid CustID
		if rtrim(@InvcNbrErr) = 'W' or rtrim(@InvcNbrErr) = 'X'
		BEGIN
			SET	@InvcNbr = ''
			SET	@InvcNbrErr = ''
		END
		
		-- Set to "Specific Invoice" if there is an Invoice Number
		-- At this point the invoice number is a "good" number
		if rtrim(@InvcNbr) <> ''
		BEGIN
			SET 	@ApplicMethod = 'SI'
		END

		-- Check if Centralized Cash, but invoice is not with master company
		SET @InvcLeftUnappl = 0
		if @MultiCpnyCentCash = 1
		BEGIN
			-- With Centralized Cash, if an invoice is not associated with the Master Company
			-- and we're currently in a non-master company
			-- then it will be left unapplied and noted
			if @InvcNbr <> '' 
				and (rtrim(@CpnyID) <> rtrim(@MasterCpnyID))	-- we're not in master company
				and (rtrim(@CpnyIDInv) <> rtrim(@CpnyID))	-- inv company <> current company

				SET @InvcLeftUnappl = 1
		END
				
		-- Add XDDBatchARLB record
		INSERT	INTO XDDBATCHARLB
		(Acct, Amount, ApplicMethod,  
		BankAcct, BankTransit, CpnyID, CpnyIDInv, CuryID,
		Crtd_DateTime, Crtd_Prog, Crtd_User,
		CustID, CustIDErr, CustIDSugg, 
		CustName, Descr, DocDate, DocType, 
		FilePathName, FileDate, FileRecord, FormatID,
		InvApplyAmt, InvcLeftUnappl, InvcNbr, InvcNbrErr, LBBatNbr, LBCustID, LineNbr,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		PmtApplicBatNbr, PmtApplicRefNbr, RefNbr, Sub
		)
		VALUES
		(@SolAcct, @ChkAmt, @ApplicMethod, 
		@BankAcct, @BankTransit, @CpnyID, @CpnyIDInv, @PmtCuryID,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@CustID, @ErrCustIDErr, @ErrCustIDSugg, 
		@CustNameLU, @TxnDescr, @DepositDate, @DocType,
		@FilePathName, @FileDate, @FileRecord, @FormatID,
		@InvApplyAmt, @InvcLeftUnappl, @InvcNbr, @ErrInvcNbrErr, @LBBatNbr, @LBCustID, @PmtLineNbr,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		'', '', @ChkNbr, @SolSub)
		
		-- Get the RecordID from the just added record
		SELECT 	@PmtRecordID = RecordID
		FROM	XDDBatchARLB
		WHERE	LBBatNbr = @LBBatNbr
			and CustID = @CustID
			and LineNbr = @PmtLineNbr
		-- This statement is not compatible with SQL 7
		-- SET @PmtRecordID = IDENT_CURRENT('XDDBATCHARLB')
			
		-- Test and see if we have a record in XDDDepositor
		if Not Exists(Select * 	FROM XDDDepositor (nolock)
				WHERE 	VendID = @CustID
					and VendCust = 'C')
		BEGIN
			-- Add XDDDepositor record
			-- Status = Inactive (N)
			-- Email Notification = Off (N)
			-- ***MVA
			INSERT	INTO XDDDEPOSITOR
			(AcctType, BankAcct, BankTransit, 
			Crtd_DateTime, Crtd_Prog, Crtd_User,
			EMNotification, EntryClass, FormatID, FromLBImport,
			LBApplicMethod, LBBankAcct, LBBankTransit, LBImportDate,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			PNStatus, Record, Status, VendCust, VendID, VendAcct
			)
			VALUES
			('C', '', '',
			@CurrDate, @Crtd_Prog, @Crtd_User,
			'N', @AREntryClass, @ModFormatID, 1,
			@SetupApplicMethod, @BankAcct, @BankTransit, @CurrDate,
			@CurrDate, @Crtd_Prog, @Crtd_User,
			@PNStatus, @ARRecord, 'N', 'C', @CustID, @VendAcct)
		END			

		-- Do application, unless special case (Multi-Cpny, Central Cash, Inv Cpny <> Master Cpny)
		if @InvcLeftUnappl = 0
		BEGIN								
			-- Now apply to documents
			EXEC XDDBatchARLB_Insert_Apply 
				@DocType, @ChkAmt, @LBBatNbr, @CustID, @InvcNbr, 
				@InvApplyAmt, @DiscApplyAmt, @DepositDate, @PmtCuryPrec, 
				@CurrDate, @Crtd_Prog, @Crtd_User,
				@PmtRecordID, @ApplicMethod, @ChkNbr, @BaseCuryID
		END
		
		-- If creating XDDBatchARLB from the Error file
		-- now remove the Error record
		if @ErrRecordID <> 0
		BEGIN
			DELETE FROM	XDDBatchARLBErrors
			WHERE		RecordID = @ErrRecordID
		END
	END

	else
	
	BEGIN

		-- Add XDDBatchARLBErrors record
		INSERT	INTO XDDBATCHARLBERRORS
		(Acct, Amount, ApplicMethod,  
		BankAcct, BankTransit, CpnyID, CpnyIDInv,
		Crtd_DateTime, Crtd_Prog, Crtd_User, CuryID,
		CustID, CustIDErr, CustIDSugg, CustName, Descr, DiscApplyAmt, DocDate, DocType, 
		FileDate, FilePathName, FileRecord, FormatID, 
		InvApplyAmt, InvcNbr, InvcNbrErr, LBBatNbr, LineNbr,
		LUpd_DateTime, LUpd_Prog, LUpd_User,
		RefNbr, Selected, Sub
		)
		VALUES
		(@SolAcct, @ChkAmt, @ApplicMethod, 
		@BankAcct, @BankTransit, @CpnyID, @CpnyIDInv,
		@CurrDate, @Crtd_Prog, @Crtd_User, @PmtCuryID,
		@CustID, @CustIDErr, @CustIDSugg, @CustName, @TxnDescr, @DiscApplyAmt, @DepositDate, @DocType,
		@FileDate, @FilePathName, @FileRecord, @FormatID,
		@InvApplyAmt, @InvcNbr, @InvcNbrErr, @LBBatNbr, @ErrLineNbr,
		@CurrDate, @Crtd_Prog, @Crtd_User,
		@ChkNbr, 0, @SolSub)
	
	END

	-- -----------------------------------------------------
	-- COMMIT TRANSACTION
	-- -----------------------------------------------------

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_Insert] TO [MSDSL]
    AS [dbo];

