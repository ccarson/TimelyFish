 create procedure DMG_MarkForHeaderInfo
	@MarkForType	varchar(1),
	@Key1		varchar(15),
	@Key2		varchar(10),
	@Name1		varchar(60) OUTPUT,
	@Attn		varchar(30) OUTPUT,
	@Addr1		varchar(60) OUTPUT,
	@Addr2		varchar(60) OUTPUT,
	@City		varchar(30) OUTPUT,
	@State		varchar(3) OUTPUT,
	@Zip		varchar(15) OUTPUT,
	@Country	varchar(3) OUTPUT,
	@ShipViaID	varchar(15) OUTPUT,
	@DfltOrdFromID	varchar(10) OUTPUT
as
	declare @Key2Tmp	varchar(10)

	--Initialize all the output parameters
	set @Name1 = ''
	set @Attn = ''
	set @Addr1 = ''
	set @Addr2 = ''
	set @City = ''
	set @State = ''
	set @Zip = ''
	set @Country = ''
	set @ShipViaID = ''
	set @DfltOrdFromID = ''

	-- If Customer
	if @MarkForType = 'C'
	begin
		select	@Name1 = ltrim(rtrim(Name)),
			@Attn = ltrim(rtrim(Attn)),
			@Addr1 = ltrim(rtrim(Addr1)),
			@Addr2 = ltrim(rtrim(Addr2)),
			@City = ltrim(rtrim(City)),
			@State = ltrim(rtrim(State)),
			@Zip = ltrim(rtrim(Zip)),
			@Country = ltrim(rtrim(Country)),
			@ShipViaID = ltrim(rtrim(ShipViaID))
		from	SOAddress (NOLOCK)
		where	CustID = @Key1
		and	ShipToID = @Key2
	end
	-- If Vendor
	else if @MarkForType = 'V'
	begin
		-- If the ordfromid wasn't passed
		if @Key2 = '' begin

			-- Get the indicator of where the address should come from
			select	@DfltOrdFromID = ltrim(rtrim(DfltOrdFromID))
			from	Vendor (NOLOCK)
			where	VendID = @Key1

			set @Key2Tmp = @DfltOrdFromID
		end
		else begin
			set @Key2Tmp = @Key2
			set @DfltOrdFromID = @Key2
		end

		-- If the address should come from the Vendor record
		if @Key2Tmp = ''
			select	@Name1 = ltrim(rtrim(Name)),
				@Attn = ltrim(rtrim(Attn)),
				@Addr1 = ltrim(rtrim(Addr1)),
				@Addr2 = ltrim(rtrim(Addr2)),
				@City = ltrim(rtrim(City)),
				@State = ltrim(rtrim(State)),
				@Zip = ltrim(rtrim(Zip)),
				@Country = ltrim(rtrim(Country))
			from	Vendor (NOLOCK)
			where	VendID = @Key1
		else
			select	@Name1 = ltrim(rtrim(Name)),
				@Attn = ltrim(rtrim(Attn)),
				@Addr1 = ltrim(rtrim(Addr1)),
				@Addr2 = ltrim(rtrim(Addr2)),
				@City = ltrim(rtrim(City)),
				@State = ltrim(rtrim(State)),
				@Zip = ltrim(rtrim(Zip)),
				@Country = ltrim(rtrim(Country))
			from	POAddress (NOLOCK)
			where	VendID = @Key1
			and	OrdFromID = @Key2Tmp
	end
	-- If Site
	else if @MarkForType = 'S'
	begin
		select	@Name1 = ltrim(rtrim(Name)),
			@Attn = ltrim(rtrim(Attn)),
			@Addr1 = ltrim(rtrim(Addr1)),
			@Addr2 = ltrim(rtrim(Addr2)),
			@City = ltrim(rtrim(City)),
			@State = ltrim(rtrim(State)),
			@Zip = ltrim(rtrim(Zip)),
			@Country = ltrim(rtrim(Country))
		from	Site (NOLOCK)
		where	SiteID = @Key1
	end
	-- If Address
	else if @MarkForType = 'O'
	begin
		select	@Name1 = ltrim(rtrim(Name)),
			@Attn = ltrim(rtrim(Attn)),
			@Addr1 = ltrim(rtrim(Addr1)),
			@Addr2 = ltrim(rtrim(Addr2)),
			@City = ltrim(rtrim(City)),
			@State = ltrim(rtrim(State)),
			@Zip = ltrim(rtrim(Zip)),
			@Country = ltrim(rtrim(Country))
		from	Address (NOLOCK)
		where	AddrID = @Key1
	end

	--select @Name1, @Attn, @Addr1, @Addr2, @City, @State, @Country, @ShipViaID, @DfltOrdFromID


