 create procedure DMG_SOSetupSelected
	@AddDaysEarly		smallint OUTPUT,
	@AddDaysLate		smallint OUTPUT,
	@AutoInsertContacts	smallint OUTPUT,
	@CashSaleCustID		varchar(15) OUTPUT,
	@ChainDiscEnabled	smallint OUTPUT,
	@CutoffTime		smalldatetime OUTPUT,
	@DfltAltIDType		varchar(1) OUTPUT,
	@DfltDiscountID		varchar(1) OUTPUT,
	@DfltOrderType		varchar(10) OUTPUT,
	@DfltSiteIDMethod	varchar(1) OUTPUT,
	@DfltSlsperMethod	varchar(1) OUTPUT,
	@MinGPHandling		varchar(1) OUTPUT,
	@WCShipViaID		varchar(15) OUTPUT
as
	select	@AddDaysEarly = AddDaysEarly,
		@AddDaysLate = AddDaysLate,
		@AutoInsertContacts = AutoInsertContacts,
		@CashSaleCustID = ltrim(rtrim(CashSaleCustID)),
		@ChainDiscEnabled = ChainDiscEnabled,
		@CutoffTime = CutoffTime,
		@DfltAltIDType = ltrim(rtrim(DfltAltIDType)),
		@DfltDiscountID = ltrim(rtrim(DfltDiscountID)),
		@DfltOrderType = ltrim(rtrim(DfltOrderType)),
		@DfltSiteIDMethod = ltrim(rtrim(DfltSiteIDMethod)),
		@DfltSlsperMethod = ltrim(rtrim(DfltSlsperMethod)),
		@MinGPHandling = ltrim(rtrim(MinGPHandling)),
		@WCShipViaID = ltrim(rtrim(WCShipViaID))
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @AddDaysEarly = 0
		set @AddDaysLate = 0
		set @AutoInsertContacts = 0
		set @CashSaleCustID = ''
		set @ChainDiscEnabled = 0
		set @CutoffTime = getdate()
		set @DfltAltIDType = ''
		set @DfltDiscountID = ''
		set @DfltOrderType = ''
		set @DfltSiteIDMethod = ''
		set @DfltSlsperMethod = ''
		set @MinGPHandling = ''
		set @WCShipViaID = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSetupSelected] TO [MSDSL]
    AS [dbo];

