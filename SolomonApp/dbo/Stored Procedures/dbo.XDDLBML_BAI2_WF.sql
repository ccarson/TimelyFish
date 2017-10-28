
CREATE procedure XDDLBML_BAI2_WF
	@ChkNbr			varchar( 20 ),
	@ChkAmt			float,
	@CurrRecord		varchar( 1000 ),
	@NextRecord		varchar( 1000 )
AS

	-- Lockbox return fields
    	Declare @SkipRecord	smallint
    	Declare @RecordType     varchar( 10 )
    	Declare @BankTransit    varchar( 34 )
    	Declare @BankAcct       varchar( 34 )
    	Declare @CashAcct       varchar( 10 )
    	Declare @ChkDate        smalldatetime
    	Declare @CustId         varchar( 15 )
    	Declare @CustName       varchar( 60 )
    	Declare @InvNbr         varchar( 10 )
    	Declare @DocType        varchar( 2 )
    	Declare @InvApplyAmt    float
    	Declare @DiscAmt        float
    	Declare @TxnDescr       varchar( 100 )

	Declare @CurrRecordType	varchar( 1 )
	Declare @NextRecordType varchar( 1 )
	Declare @TextStr	varchar( 20 )
	
	-- Initialize the return vars
	SET	@SkipRecord = 1
	SET	@RecordType = ''
    	SET	@BankTransit = ''
    	SET	@BankAcct = ''
    	SET	@CashAcct = ''       
    	-- SET	@ChkNbr = ''        
    	-- SET	@ChkAmt = 0		
    	SET	@ChkDate = convert(smalldatetime, '01/01/1900')
    	SET	@CustId = ''        
    	SET	@CustName = ''      
    	SET	@InvNbr = ''
    	SET	@DocType = 'PA'
    	SET	@InvApplyAmt = 0
    	SET	@DiscAmt = 0
    	SET	@TxnDescr = ''
	
	SET	@RecordType = SubString(@CurrRecord, 1, 1)
	SET	@NextRecordType = SubString(@NextRecord, 1, 1)

	-- Check Record
	if @RecordType = '6'
	BEGIN
		SET	@ChkNbr = SubString(@CurrRecord, 37, 10) 

		-- Check Amount
		SET	@TextStr = SubString(@CurrRecord, 8, 10) 
		SET	@ChkAmt = convert(float, left(@TextStr, 8) + '.' + right(@TextStr, 2))

		-- Uncomment these two if you want lookup by Transit/Acct number
		-- SET	@BankTransit = SubString(@CurrRecord, 18, 9)
		-- SET	@BankAcct = SubString(@CurrRecord, 27, 10) 
		SET	@CashAcct = ''

		-- Check Date YYMMDD
		SET	@TextStr = SubString(@CurrRecord, 88, 6) 
		SET	@ChkDate = convert(smalldatetime, SubString(@TextStr, 3, 2) + '/' + SubString(@TextStr, 5, 2) + '/' + left(@TextStr, 2))

		SET	@CustId = SubString(@CurrRecord, 124, 30) 
		SET	@CustName = SubString(@CurrRecord, 94, 30) 

		-- if Next Record - another Check, then no invoice information, clear values
		if @NextRecordType = '6' or @NextRecordType <> '4'
		BEGIN
			-- Only one record - check only - no invoices
			-- Return the check only record
			SET 	@SkipRecord = 0
	    		SET	@InvNbr = ''
			SET	@InvApplyAmt = 0
	    		SET	@DiscAmt = 0
	    		SET	@TxnDescr = ''
				
		END

		if @NextRecordType = '4'
		BEGIN
			-- Next record is voucher, special skip - will save check info for next
			SET 	@SkipRecord = -1
		END
	END
	   
	-- Invoice Record
	if @RecordType = '4'
	BEGIN
		-- Return the Invoice record
		SET @SkipRecord = 0					
    		SET	@InvNbr = rtrim(SubString(@CurrRecord, 12, 15))

		-- Invoice Amount
		SET @TextStr = SubString(@CurrRecord, 27, 10)
		if Convert(int, (@TextStr)) < 0
		BEGIN
		   -- Negative - CM
		   -- Make number positive
		   SET @TextStr = '0' + Substring(@TextStr, 2, 9)
		   -- Make a Credit Memo Doctype
		   SET @DocType = 'CM'
		END
		else
		BEGIN
		   -- Be sure others are back to PA
		   SET @DocType = 'PA'
		END
		SET @InvApplyAmt = convert(float, left(@TextStr, 8) + '.' + right(@TextStr, 2))

		-- Discount Amount
		SET	@TextStr = SubString(@CurrRecord, 98, 11) 
    		SET	@DiscAmt = convert(float, left(@TextStr, 9) + '.' + right(@TextStr, 2))
    		SET	@TxnDescr = ''
	
	END
	
	-- ------------------------------------------
	-- Goal is to return one record per invoice
	-- ------------------------------------------
	--	SkipRecord		Meaning
	--	----------		-------
	--	0			Don't skip record, import this record as an invoice record
	--					Could be an invoice record underneath a check record
	--					or a Check record by itself, followed by another check record
	--	1			Skip the record - it's an extraneous record that LB does not need
	--	-1			Skip the record (it's a check record followed by invoices), but retain the check information

	--	Example:	File	File Header information
	--				Batch information
	--				Check		1000
	--				  Inv		 400
	--				  Inv		 600
	--				Batch Trailer information
	--				File Trailer information
	--				
	--			Return	Skip File Header (SkipRecord = 1)
	--				Skip Batch Information (SkipRecord = 1)
	--			  >>	Skip Check record, but retain check info (SkipRecord = -1)
	--			  >>	Inv 400 + Check Info (SkipRecord = 0)
	--			  >>	Inv 600 + Check Info (SkipRecord = 0)
	--				Skip Batch Trailer (SkipRecord = 1)
	--				Skip File Trailer (SkipRecord = 1)
	
	-- These values MUST be returned in this order and with these data types
	SELECT	@SkipRecord,
    		@RecordType,
    		@BankTransit,
    		@BankAcct,
    		@CashAcct,
    		@ChkNbr,
    		@ChkAmt,
    		@ChkDate,
    		@CustId,
    		@CustName,
    		@InvNbr,
    		@DocType,
    		@InvApplyAmt,
    		@DiscAmt,
    		@TxnDescr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLBML_BAI2_WF] TO [MSDSL]
    AS [dbo];

