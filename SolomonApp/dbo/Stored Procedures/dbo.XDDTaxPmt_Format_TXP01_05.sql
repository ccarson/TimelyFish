
CREATE procedure XDDTaxPmt_Format_TXP01_05
	@IDNbr			varchar( 15 ),
	@FedID			varchar( 12 ),
	@PmtTypeCode		varchar( 5 ),
	@InvcDate			smalldatetime,
	@SubCateg			varchar( 5 ),
	@VchCuryAmt		float,
	@PreNote			smallint,		-- 1=prenote
	@TXP01_03			varchar( 80 ) OUTPUT,
	@TXP01_04			varchar( 80 ) OUTPUT,
	@TXP01_05			varchar( 80 ) OUTPUT
AS

	Declare @Amt		varchar( 15 )
	Declare @DecPos		smallint
	Declare @TaxDate	varchar( 6 )
	
	SET	@TXP01_05 = ''
	
	-- TXP01 - Taxpayer ID Number
	--	If no IDNbr, then must be Federal Taxes
	if rtrim(@IDNbr) = ''
		SET	@TXP01_05 = @TXP01_05 + rtrim(@FedID) + '*'
	else
		SET	@TXP01_05 = @TXP01_05 + rtrim(@IDNbr) + '*'
	
	-- TXP02 - Tax Payment Type Code - 5 chars - APDoc is Voucher record
	SET	@TXP01_05 = @TXP01_05 + rtrim(@PmtTypeCode) + '*'
	
	-- TXP03 - Tax Period End Date  YYMM01 - Federal only
	if rtrim(@IDNbr) = ''
	BEGIN
		-- When ID Number is empty, then Fed Tax Payment
		-- Format date as YYMM01
		SET @TaxDate = 	right(convert(varchar(4), DatePart(yy, @InvcDate)), 2) 
				+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(mm, @InvcDate)))), 2)
				+ '01'
	END
	else
	BEGIN
		-- With an ID number, State Tax - YYMMDD
		SET @TaxDate = 	right(convert(varchar(4), DatePart(yy, @InvcDate)), 2) 
				+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(mm, @InvcDate)))), 2)
				+ right('00' + ltrim(rtrim(convert(varchar(2), DatePart(dd, @InvcDate)))), 2)

	END
	SET	@TXP01_05 = @TXP01_05 + @TaxDate + '*'

	-- --------------------------
        -- Set to return up to date
	-- --------------------------
        SET	@TXP01_03 = @TXP01_05

	-- TXP04 - Amount Type - either Subcategory or
        --             if no subcategory, then report Type code
	if rtrim(@SubCateg) = ''
		SET	@TXP01_05 = @TXP01_05 + rtrim(@PmtTypeCode) + '*'
	else
		SET	@TXP01_05 = @TXP01_05 + rtrim(@SubCateg) + '*'
            
	-- --------------------------
        -- Set to return up to amount
	-- --------------------------
        SET	@TXP01_04 = @TXP01_05
            
	-- --------------------------
	-- TXP05 - Tax Amount - $$$$$$$$cc
	-- --------------------------
	SET 	@Amt	= convert(varchar(15), convert(decimal(12,2), @VchCuryAmt))
	SET	@DecPos	= charindex('.', @Amt)
	SET 	@TXP01_05 = @TXP01_05 + left(@Amt, @DecPos-1) + right(@Amt,2)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTaxPmt_Format_TXP01_05] TO [MSDSL]
    AS [dbo];

