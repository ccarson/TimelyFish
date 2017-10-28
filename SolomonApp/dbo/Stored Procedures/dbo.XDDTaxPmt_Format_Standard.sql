
create procedure XDDTaxPmt_Format_Standard
	@VendID			varchar( 15 ),		-- Voucher info - VendID, DocType, RefNbr
	@VendAcct		varchar( 10 ),		-- VendAcct
	@DocType		varchar( 2 ),
	@RefNbr			varchar( 10 ),
	@VchCuryAmt		float,			-- Voucher amount being paid
	@PreNote		smallint,		-- 1=prenote
   	@ComputerName		varchar( 21 )
AS

	Declare @Amt		varchar( 15 )
	Declare @CpnyID		varchar( 10 )
	Declare @CurrMonth	smallint
	Declare @CurrYear	smallint
	Declare @DecPos		smallint
	Declare @DocDesc	varchar( 30 )
	Declare @IDNbr		varchar( 15 )
	Declare @InvcDate	smalldatetime
	Declare @FedID		varchar( 12 )
	Declare @TaxDate	varchar( 6 )
	Declare @TaxPeriods	varchar( 20 )
	Declare @TaxRecord	varchar( 80 )
	Declare @TXP01_03	varchar( 80 )
	Declare @TXP01_04	varchar( 80 )
	Declare @PmtTypeCode	varchar( 5 )
	Declare @SubCateg	varchar( 5 )
	Declare @VchInvcNbr	varchar( 15 )
	Declare @VchUser01	varchar( 30 )
	Declare @VchUser02	varchar( 30 )
	Declare @VchUser03	float
	Declare @VchUser04	float
	Declare @VchUser05	varchar( 10 )
	Declare @VchUser06	varchar( 10 )
	Declare @VchUser07	smalldatetime
	Declare @VchUser08	smalldatetime
	Declare @VendRemitName	varchar( 60 )
	
	SET	@CpnyID = ''
	SET	@InvcDate = 0
	SET	@DocDesc = ''
	SET	@VchInvcNbr = ''
	SET	@VchUser01 = ''
	SET	@VchUser02 = ''
	SET	@VchUser03 = 0
	SET	@VchUser04 = 0
	SET	@VchUser05 = ''
	SET	@VchUser06 = ''
	SET	@VchUser07 = 0
	SET	@VchUser08 = 0
	SET	@VendRemitName = ''

	if @PreNote = 1
	BEGIN
	
		-- Use EBFileNbr EffDate
	 	SELECT TOP 1	@InvcDate = E.EffDate
 		FROM		XDDFile_Wrk W (nolock) LEFT OUTER JOIN XDDEBFile E (nolock)
 				ON W.EBFileNbr = E.EBFileNbr and W.FileType = E.FileType
 		WHERE		W.ComputerName = @ComputerName
 		ORDER BY	W.Crtd_DateTime DESC

		-- Prenote Short-Descr, Vendor Remit Name
		SELECT		@VchInvcNbr = D.PNTaxPmt,
				@VendRemitName = V.RemitName
		FROM		XDDDepositor D (nolock) LEFT OUTER JOIN Vendor V (nolock)
				ON D.VendID = V.VendID
		WHERE		D.VendID = @VendID
				and D.VendAcct = @VendAcct
				and D.VendCust = 'V'	
	END
	else
	BEGIN
		-- Get Voucher Info
		SELECT	@CpnyID = A.CpnyID,
			@InvcDate = A.InvcDate,
			@DocDesc = A.DocDesc,
			@VchInvcNbr = A.InvcNbr,
			@VchUser01 = A.User1,	-- C 30
			@VchUser02 = A.User2,	-- C 30
			@VchUser03 = A.User3,	-- F 8
			@VchUser04 = A.User4,	-- F 8
			@VchUser05 = A.User5,	-- C 10
			@VchUser06 = A.User6,	-- C 10
			@VchUser07 = A.User7,	-- smalldatetime
			@VchUser08 = A.User8,	-- smalldatetime
			@VendRemitName = V.RemitName
		FROM	APDoc A (nolock) LEFT OUTER JOIN Vendor V (nolock)
			ON A.VendID = V.VendID
		WHERE	A.VendID = @VendID
			and A.DocType = @DocType
			and A.RefNbr = @RefNbr
	END
	
	SET	@PmtTypeCode = ''

	-- Get XDDTaxPmt data
	SELECT	@PmtTypeCode = Code,
		@IDNbr = IDNbr,
		@SubCateg = SubCategory,
		@TaxPeriods = Periods
	FROM	XDDTaxPmt (nolock)
	WHERE	ShortDescr = @VchInvcNbr

	SET	@TaxRecord = ''
	SET	@TXP01_03 = ''
	SET	@TXP01_04 = ''
	if @PmtTypeCode <> '' and @VchInvcNbr <> ''
	BEGIN 
		-- Get Federal Tax ID
		SET	@FedID = ''

--		SELECT	@FedID = Master_Fed_ID
--		FROM	vs_Company (nolock)
--		WHERE	CpnyID = @CpnyID

		EXEC XDD_company_Master_Fed_ID @CpnyID, @FedID OUTPUT

		
		-- If not found in Company record for voucher, get from GLSetup
		if @FedID = ''
			SELECT 	@FedID = EmplID
			FROM	GLSetup (nolock)
	
		-- ---------------------------------------------------------------------------------------
		-- ---------------------------------------------------------------------------------------
		-- Get TXP01_05 (standard) - returns TXP01_03/_04/_05 - no trailing star (*) nor forward slash (\)
		--	03/04 have trailing star (*)
		EXEC XDDTaxPmt_Format_TXP01_05 @IDNbr, @FedID, @PmtTypeCode, @InvcDate, 
			@SubCateg, @VchCuryAmt, @PreNote, @TXP01_03 OUTPUT, @TXP01_04 OUTPUT, @TaxRecord OUTPUT
		-- ---------------------------------------------------------------------------------------
		-- ---------------------------------------------------------------------------------------

		-- Hawaii             
		if left(@VchInvcNbr, 3) = 'HI-'
		BEGIN
			-- TXP*00000000*TaxType*YYMMDD*YYMMDD*Wxxxxx*xx*N\
                	--                      End    Start  HI ID  Suffix
                	--                                              Period - Y-Annual, N-Non-Annual
			-- Need to start over as TXP01-05 are not standard
			SET @TaxRecord = '00000000*'
			
			-- TXP02 - Pmt Code
			SET @TaxRecord = @TaxRecord + rtrim(@PmtTypeCode) + '*'
			
			-- TXP03 - End Date - Voucher Invoice Date - YYMMDD
			SET @TaxDate = 	right(convert(varchar(4), DatePart(yy, @InvcDate)), 2) 
					+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(mm, @InvcDate)))), 2)
					+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(dd, @InvcDate)))), 2)
			SET @TaxRecord = @TaxRecord + @TaxDate + '*'

			-- TXP04 - Start Date
			-- Tax Period Start Date - Comes from Day 01 of Starting Month
                	--   Monthly, Quarterly, Annually (or Yearly)
			if @TaxPeriods = '' or CharIndex('M', @TaxPeriods) > 0
			BEGIN
	  			-- Beginning of End Date Month - YYMMDD
				SET @TaxDate = 	right(convert(varchar(4), DatePart(yy, @InvcDate)), 2) 
						+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(mm, @InvcDate)))), 2)
						+ '01'
			END
			else
			BEGIN

				SET	@CurrMonth = DatePart(mm, @InvcDate)
				if CharIndex('Q', @TaxPeriods) > 0 		-- Quarterly
					SET	@CurrMonth = @CurrMonth - 2	-- subtract 2 months
				else
					SET	@CurrMonth = @CurrMonth - 11	-- subtract 11 months (annually)

				SET	@CurrYear = DatePart(yy, @InvcDate)
				if @CurrMonth < 1
				BEGIN
		                        -- Quarterly
		                        -- 02/xx/2007 --> 0      0 + 12  = 12
		                        -- 01/xx/2007 --> -1     -1 + 12 = 11
		                        -- Annually
		                        -- 10/xx/2007 -->        -1 + 12 = 11
		                        -- 03/xx/2007 -->        -8 + 12 = 4
					SET	@CurrMonth = @CurrMonth + 12
					SET	@CurrYear = @CurrYear - 1
				END					

				SET @TaxDate = 	right( convert(varchar(4), @CurrYear), 2)
						+ right('00' + ltrim(rtrim(convert(varchar(2), @CurrMonth))), 2)
						+ '01'
			END
			SET @TaxRecord = @TaxRecord + @TaxDate + '*'

			-- TXP05 - Start Date
			-- HI ID# + HI ID Suffix - both should be in .IDNbr field
                	-- W12345678*12 - 12 length
			SET @TaxRecord = @TaxRecord + rtrim(@IDNbr) + '*'
			
			-- TXP06 - Suffic - in SubCategory field (Period Y/N)
			SET @TaxRecord = @TaxRecord + rtrim(@SubCateg)
					
		END
		
		-- Alabama
		if left(@VchInvcNbr, 3) = 'AL-'
		BEGIN

			-- TXP01-04 standard, then Amt LZF, then Space, Confirm Nbr
			-- TXP01...............TXP05*                  *N0500202020\
			--                           18 spaces          Confirm Nbr (C 11)
			--						APDoc.User1
			
			-- Up thru SubCateg (includes trailing *)
			SET @TaxRecord = @TXP01_04
			
			-- Now Add Amount, but LZF - to 10 characters
			-- Changed 6/23/10 - per AL request
			SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchCuryAmt))
			SET	@DecPos	= charindex('.', @Amt)
			SET 	@TaxRecord = @TaxRecord + right('0000000000' + left(@Amt, @DecPos-1) + right(@Amt,2), 10) + '*'

			SET @TaxRecord = @TaxRecord + '                  *'

			if @PreNote = 0
				SET @TaxRecord = @TaxRecord + rtrim(@VchUser01)
			else
				SET @TaxRecord = @TaxRecord + 'N9999999999'
					
		END

		-- Maryland
		if left(@VchInvcNbr, 3) = 'MD-'
		BEGIN

			-- Per emails with Ron Rumschlag at DuCharme
			-- 705TXP*331169273*04100*080731*T*0005763288*T*0000123456*T*0000123456\
			--        Tax ID    Type  Date     Txbl Sales
			--			  YYMMDD   Amt (LZF)      
			--                        End Date
			--                                             	Txbl Purch   Car/Trk Rental			
			
			-- Up thru Date (includes trailing *)
			SET @TaxRecord = @TXP01_03 + 'T*'
			
			-- TXP05 - Now Add Amount (Txbl Sales), but LZF
			SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchCuryAmt))
			SET	@DecPos	= charindex('.', @Amt)
			SET 	@TaxRecord = @TaxRecord + right('0000000000' + left(@Amt, @DecPos-1) + right(@Amt,2), 10) + '*'

			-- TXP06
			SET	@TaxRecord = @TaxRecord + 'T*'
			
			-- TXP07 - Now Add Amount (Txbl Purchase - Voucher.User01), but LZF
			if @VchUser01 = '' 
				SET 	@TaxRecord = @TaxRecord + '0000000000' + '*'
			else
			BEGIN
				-- Remove any commas
				SET	@VchUser01 = Replace(@VchUser01, ',', '')
				SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchUser01))
				SET	@DecPos	= charindex('.', @Amt)
				if @DecPos = 0  -- no decimals entered
					SET 	@TaxRecord = @TaxRecord + right('0000000000' + @Amt + '00', 10) + '*'
				else
					SET 	@TaxRecord = @TaxRecord + right('0000000000' + left(@Amt, @DecPos-1) + right(@Amt,2), 10) + '*'
			END
			
			-- TXP08
			SET	@TaxRecord = @TaxRecord + 'T*'

			-- TXP09 - Now Add Amount (Car/Truck Rental), but LZF
			if @VchUser02 = '' 
				SET 	@TaxRecord = @TaxRecord + '0000000000'
			else
			BEGIN
				-- Remove any commas
				SET	@VchUser02 = Replace(@VchUser02, ',', '')
				SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchUser02))
				SET	@DecPos	= charindex('.', @Amt)
				if @DecPos = 0  -- no decimals entered
					SET 	@TaxRecord = @TaxRecord + right('0000000000' + @Amt + '00', 10)
				else
					SET 	@TaxRecord = @TaxRecord + right('0000000000' + left(@Amt, @DecPos-1) + right(@Amt,2), 10)
			END
			
		END
		
		-- Massachusetts
		if left(@VchInvcNbr, 3) = 'MA-'
		BEGIN

			-- Per conversations with Andrew Addelman at the Massachusetts DOR (617-626-3516) here�s how it needs to look
			-- 705TXP*331169273*0137M*080731*T*0005763288*****SABICI\
			--        Tax ID    Type  Date   SubCateg
			--				   Amt (LZF)      left six of vendor remit name

			-- Up thru SubCateg (includes trailing *)
			SET @TaxRecord = @TXP01_04
			
			-- Now Add Amount, but LZF
			SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchCuryAmt))
			SET	@DecPos	= charindex('.', @Amt)
			SET 	@TaxRecord = @TaxRecord + right('0000000000' + left(@Amt, @DecPos-1) + right(@Amt,2), 10) + '*'

			-- Add remaining stars(*) (4)
			SET @TaxRecord = @TaxRecord + '****'
			
			-- TXP10 - Add leftmost of vendor name
			SET @TaxRecord = @TaxRecord + upper(left(@VendRemitName, 6))

		END

		-- Puerto Rico
		if left(@VchInvcNbr, 3) = 'PR-'
		BEGIN

			-- Per email from Angie Wheeler - Ducharme
			-- 705TXP*FD3311692734*00004*080731*T*0005763288\
			--        Confirm Nbr  Type  Date   SubCateg
			--	  APDoc.User 1		      Amt (LZF)
			--	  C 12

			-- TXP01
			-- Confirmation Number
			if @PreNote = 0
				SET @TaxRecord = rtrim(@VchUser01) + '*'
			else
				SET @TaxRecord = 'FD9999999999' + '*'
			
			-- TXP02 - Tax Payment Type Code - 5 chars - APDoc is Voucher record
			SET	@TaxRecord = @TaxRecord + rtrim(@PmtTypeCode) + '*'
	
			-- With an ID number, State Tax - YYMMDD
			SET @TaxDate = 	right(convert(varchar(4), DatePart(yy, @InvcDate)), 2) 
					+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(mm, @InvcDate)))), 2)
					+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(dd, @InvcDate)))), 2)

			SET	@TaxRecord = @TaxRecord + @TaxDate + '*'

			-- TXP04 - Amount Type - either Subcategory or
		        --             if no subcategory, then report Type code
			if rtrim(@SubCateg) = ''
				SET	@TaxRecord = @TaxRecord + rtrim(@PmtTypeCode) + '*'
			else
				SET	@TaxRecord = @TaxRecord + rtrim(@SubCateg) + '*'
            
			-- TXP05 - Tax Amount - $$$$$$$$cc
			SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchCuryAmt))
			SET	@DecPos	= charindex('.', @Amt)
			SET 	@TaxRecord = @TaxRecord + left(@Amt, @DecPos-1) + right(@Amt,2)

		END
		
		-- TXP06 - TXP10 - we do not use multiple subcategories
	        --	 We assume that only one subcategory in on each voucher
	        --	 since the Tax Pmt Code is stored in the Voucher Header - Invoice Number
		
		SET	@TaxRecord = @TaxRecord + '\'
	END

	else

	BEGIN	
		if @VchInvcNbr = ''
			SET @TaxRecord = '*Voucher''s invoice number field is blank.  It should have the Short Description for the tax being paid.'
		else if @PmtTypeCode = ''
			SET @TaxRecord = '*Short Description ' + rtrim(@VchInvcNbr) + ' cannot be found in Tax Payment Codes (DD.280.00)'
		else
			SET @TaxRecord = '*Error (unknown)'
	END
	
	SELECT 	@TaxRecord

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTaxPmt_Format_Standard] TO [MSDSL]
    AS [dbo];

