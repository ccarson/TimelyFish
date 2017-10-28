 create procedure DMG_ScheduleShippingInfo
	@ShipToType	varchar(1),
	@Key1		varchar(15),
	@Key2		varchar(10),
	@Key1Valid	bit OUTPUT,
	@Key2Valid	bit OUTPUT,
	@Name		varchar(60) OUTPUT,
	@TaxID00	varchar(10) OUTPUT,
	@TaxID01	varchar(10) OUTPUT,
	@TaxID02	varchar(10) OUTPUT,
	@TaxID03	varchar(10) OUTPUT,
	@Zip		varchar(15) OUTPUT,
	@DfltOrdFromID	varchar(10) OUTPUT
as
	declare @NewKey2 varchar(10)
	declare @TaxDflt varchar(1)

	--Initialize all the output parameters
	set @Key1Valid = 0
	set @Key1Valid = 0
	set @Name = ''
	set @TaxID00 = ''
	set @TaxID01 = ''
	set @TaxID02 = ''
	set @TaxID03 = ''
	set @Zip = ''
	set @DfltOrdFromID = ''

	if @ShipToType = 'C'
	begin
		--Get the customer information
		select	@TaxDflt = ltrim(rtrim(TaxDflt)),
			@TaxId00 = ltrim(rtrim(TaxID00)),
			@TaxId01 = ltrim(rtrim(TaxID01)),
			@TaxId02 = ltrim(rtrim(TaxID02)),
			@TaxId03 = ltrim(rtrim(TaxID03))
		from	Customer (NOLOCK)
		where	CustID = @Key1
		and	Status IN ('A', 'O', 'R')

		if @@ROWCOUNT = 0
			return 0
		else
			--Flag Key1 as valid
			set @Key1Valid = 1

		--If the tax ids should come from the customer
		if @TaxDflt = 'C' begin

			--Get the information from SOAddress
			select	@Name = ltrim(rtrim(Name)),
				@Zip = ltrim(rtrim(Zip))
			from	SOAddress (NOLOCK)
			where	CustID = @Key1
			and	ShipToID = @Key2

			if @@ROWCOUNT = 0
				return 0
			else
				--Flag Key2 as valid
				set @Key2Valid = 1
		end
		else begin

			--Get the information from SOAddress
			select	@Name = ltrim(rtrim(Name)),
				@TaxId00 = ltrim(rtrim(TaxID00)),
				@TaxId01 = ltrim(rtrim(TaxID01)),
				@TaxId02 = ltrim(rtrim(TaxID02)),
				@TaxId03 = ltrim(rtrim(TaxID03)),
				@Zip = ltrim(rtrim(Zip))
			from	SOAddress (NOLOCK)
			where	CustID = @Key1
			and	ShipToID = @Key2

			if @@ROWCOUNT = 0
				return 0
			else
				--Flag Key2 as valid
				set @Key2Valid = 1
		end
	end
	else if @ShipToType = 'V'
	begin
		--Get the vendor information
		select	@Name = ltrim(rtrim(Name)),
			@TaxDflt = ltrim(rtrim(TaxDflt)),
			@TaxId00 = ltrim(rtrim(TaxID00)),
			@TaxId01 = ltrim(rtrim(TaxID01)),
			@TaxId02 = ltrim(rtrim(TaxID02)),
			@TaxId03 = ltrim(rtrim(TaxID03)),
			@Zip = ltrim(rtrim(Zip)),
			@DfltOrdFromID = ltrim(rtrim(DfltOrdFromID))
		from	Vendor (NOLOCK)
		where	VendID = @Key1

		if @@ROWCOUNT = 0
			return 0
		else
			--Flag Key1 as valid
			set @Key1Valid = 1

		--Return if all the information comes from the vendor
		if ltrim(rtrim(@DfltOrdFromID)) = ''
			return 1

		--If the vendor address id wasn't passed, use the default specified by the vendor
		if @Key2 = ''
			set @NewKey2 = @DfltOrdfromID
		else begin
			--Otherwise use the one passed and pass it back as the default vendor address id
			set @NewKey2 = @Key2
			set @DfltOrdFromID = @Key2
		end

		--If the tax ids should come from the vendor
		if @TaxDflt = 'V' begin

			--Get the information from SOAddress
			select	@Name = ltrim(rtrim(Name)),
				@Zip = ltrim(rtrim(Zip))
			from	POAddress (NOLOCK)
			where	VendID = @Key1
			and	OrdFromID = @NewKey2

			if @@ROWCOUNT = 0
				return 0
			else
				--Flag Key2 as valid
				set @Key2Valid = 1
		end
		else begin

			--Get the information from POAddress
			select	@Name = ltrim(rtrim(Name)),
				@TaxId00 = ltrim(rtrim(TaxID00)),
				@TaxId01 = ltrim(rtrim(TaxID01)),
				@TaxId02 = ltrim(rtrim(TaxID02)),
				@TaxId03 = ltrim(rtrim(TaxID03)),
				@Zip = ltrim(rtrim(Zip))
			from	POAddress (NOLOCK)
			where	VendID = @Key1
			and	OrdFromID = @NewKey2

			if @@ROWCOUNT = 0
				return 0
			else
				--Flag Key2 as valid
				set @Key2Valid = 1
		end
	end
	else if @ShipToType = 'S'
	begin
		--Get the site information
		select	@Name = ltrim(rtrim(Name)),
			@Zip = ltrim(rtrim(Zip))
		from	Site (NOLOCK)
		where	SiteID = @Key1

		if @@ROWCOUNT = 0
			return 0
		else
			--Flag Key1 as valid
			set @Key1Valid = 1
	end
	else if @ShipToType = 'O'
	begin
		--Get the other address information
		select	@Name = ltrim(rtrim(Name)),
			@TaxId00 = ltrim(rtrim(TaxID00)),
			@TaxId01 = ltrim(rtrim(TaxID01)),
			@TaxId02 = ltrim(rtrim(TaxID02)),
			@TaxId03 = ltrim(rtrim(TaxID03)),
			@Zip = ltrim(rtrim(Zip))
		from	Address (NOLOCK)
		where	AddrID = @Key1

		if @@ROWCOUNT = 0
			return 0
		else
			--Flag Key1 as valid
			set @Key1Valid = 1
	end

	--select @Key1Valid, @Key2Valid, @Name, @TaxID00, @TaxID01, @TaxID02, @TaxID03, @Zip, @DfltOrdFromID
	return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ScheduleShippingInfo] TO [MSDSL]
    AS [dbo];

