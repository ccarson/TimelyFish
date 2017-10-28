 create procedure DMG_CustomerCustomerEDISelected
	@CustID			varchar(15),
	@BillAddr1		varchar(60) OUTPUT,
        @BillAddr2		varchar(60) OUTPUT,
        @BillAttn		varchar(30) OUTPUT,
        @BillCity		varchar(30) OUTPUT,
        @BillCountry		varchar(3) OUTPUT,
        @BillName		varchar(60) OUTPUT,
        @BillPhone		varchar(30) OUTPUT,
        @BillState		varchar(3) OUTPUT,
        @BillZip		varchar(10) OUTPUT,
        @BuyerReqd		smallint OUTPUT,
        @CertID			varchar(2) OUTPUT,
        @ClassId		varchar(6) OUTPUT,
        @CuryID			varchar(4) OUTPUT,
        @CuryRateType		varchar(6) OUTPUT,
        @CustFillPriority	smallint OUTPUT,
        @CustItemReqd		smallint OUTPUT,
        @DfltBuyerID		varchar(10) OUTPUT,
        @DfltShipToId		varchar(10) OUTPUT,
        @GLClassID		varchar(4) OUTPUT,
        @MinOrder		decimal(25,9) OUTPUT,
        @MinWt			decimal(25,9) OUTPUT,
        @POReqd			smallint OUTPUT,
        @PriceClassID		varchar(6) OUTPUT,
        @ShipCmplt		smallint OUTPUT,
        @SubstOK		smallint OUTPUT,
        @TaxDflt		varchar(1) OUTPUT,
        @TaxId00		varchar(10) OUTPUT,
        @TaxId01		varchar(10) OUTPUT,
        @TaxId02		varchar(10) OUTPUT,
        @TaxId03		varchar(10) OUTPUT,
        @TaxRegNbr		varchar(15) OUTPUT,
        @Terms			varchar(2) OUTPUT,
		@ConsolInv		smallint OUTPUT
as
	select	@BillAddr1 = ltrim(rtrim(BillAddr1)),
        	@BillAddr2 = ltrim(rtrim(BillAddr2)),
        	@BillAttn = ltrim(rtrim(BillAttn)),
        	@BillCity = ltrim(rtrim(BillCity)),
        	@BillCountry = ltrim(rtrim(BillCountry)),
        	@BillName = ltrim(rtrim(BillName)),
        	@BillPhone = ltrim(rtrim(BillPhone)),
        	@BillState = ltrim(rtrim(BillState)),
        	@BillZip = ltrim(rtrim(BillZip)),
        	@BuyerReqd = BuyerReqd,
        	@CertID = ltrim(rtrim(CertID)),
        	@ClassId = ltrim(rtrim(ClassId)),
        	@CuryID = ltrim(rtrim(CuryID)),
        	@CuryRateType = ltrim(rtrim(CuryRateType)),
        	@CustFillPriority = CustFillPriority,
        	@CustItemReqd = CustItemReqd,
        	@DfltBuyerID = ltrim(rtrim(DfltBuyerID)),
        	@DfltShipToId = ltrim(rtrim(DfltShipToId)),
        	@GLClassID = ltrim(rtrim(GLClassID)),
        	@MinOrder = MinOrder,
        	@MinWt = MinWt,
        	@POReqd = POReqd,
        	@PriceClassID = ltrim(rtrim(PriceClassID)),
        	@ShipCmplt = ShipCmplt,
        	@SubstOK = SubstOK,
        	@TaxDflt = ltrim(rtrim(TaxDflt)),
        	@TaxId00 = ltrim(rtrim(TaxId00)),
        	@TaxId01 = ltrim(rtrim(TaxId01)),
        	@TaxId02 = ltrim(rtrim(TaxId02)),
        	@TaxId03 = ltrim(rtrim(TaxId03)),
        	@TaxRegNbr = ltrim(rtrim(TaxRegNbr)),
        	@Terms = ltrim(rtrim(Terms)),
			@ConsolInv = ConsolInv
	from	Customer (NOLOCK)
	join	CustomerEDI (NOLOCK) on CustomerEDI.CustID = Customer.CustID
	where	Customer.CustID = @CustID
	and	Status in ('A', 'O', 'R')

	if @@ROWCOUNT = 0 begin
        	set @BillAddr2 = ''
        	set @BillAttn = ''
        	set @BillCity = ''
        	set @BillCountry = ''
        	set @BillName = ''
        	set @BillPhone = ''
        	set @BillState = ''
        	set @BillZip = ''
        	set @BuyerReqd = 0
        	set @CertID = ''
        	set @ClassId = ''
        	set @CuryID = ''
        	set @CuryRateType = ''
        	set @CustFillPriority = 0
        	set @CustItemReqd = 0
        	set @DfltBuyerID = ''
        	set @DfltShipToId = ''
        	set @GLClassID = ''
        	set @MinOrder = 0
        	set @MinWt = 0
        	set @POReqd = 0
        	set @PriceClassID = ''
        	set @ShipCmplt = 0
        	set @SubstOK = 0
        	set @TaxDflt = ''
        	set @TaxId00 = ''
        	set @TaxId01 = ''
        	set @TaxId02 = ''
        	set @TaxId03 = ''
        	set @TaxRegNbr = ''
        	set @Terms = ''
			set @ConsolInv = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CustomerCustomerEDISelected] TO [MSDSL]
    AS [dbo];

