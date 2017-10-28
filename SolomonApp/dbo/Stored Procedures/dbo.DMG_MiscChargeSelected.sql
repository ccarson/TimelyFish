 create procedure DMG_MiscChargeSelected
	@MiscChrgID	varchar(10),
	@Descr		varchar(30) OUTPUT,
	@Service	smallint OUTPUT,
	@Taxable	smallint OUTPUT,
	@TaxCat		varchar(10) OUTPUT
as
	select	@Descr = Descr,
		@Service = Service,
		@Taxable = Taxable,
		@TaxCat = TaxCat
	from	MiscCharge (NOLOCK)
	where	MiscChrgID = @MiscChrgID

	if @@ROWCOUNT = 0 begin
		set @Descr = ''
		set @Service = 0
		set @Taxable = 0
		set @TaxCat = ''
		return 0	--Failure
	end
	else begin
		--select @Descr, @Service, @Taxable, @TaxCat
		return 1	--Success
	end


