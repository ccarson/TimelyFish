 create procedure DMG_POShippingAddressInfo
	@ShipToType	varchar(1),
	@Key1		varchar(15),
	@Key2		varchar(10),
	@ShipAddr1	varchar(60) OUTPUT,
	@ShipAddr2	varchar(60) OUTPUT,
	@ShipAttn	varchar(30) OUTPUT,
	@ShipCity	varchar(30) OUTPUT,
	@ShipCountry	varchar(3) OUTPUT,
	@ShipEmail	varchar(80) OUTPUT,
	@ShipFax	varchar(30) OUTPUT,
	@ShipName	varchar(60) OUTPUT,
	@ShipPhone	varchar(30) OUTPUT,
	@ShipState	varchar(3) OUTPUT,
	@ShipZip	varchar(15) OUTPUT,
	@DfltOrdFromID	varchar(10) OUTPUT
as
	declare @Key2Tmp	varchar(10)

	--Initialize all the output parameters
	set @ShipAddr1 = ''
	set @ShipAddr2 = ''
	set @ShipAttn = ''
	set @ShipCity = ''
	set @ShipCountry = ''
	set @ShipEmail = ''
	set @ShipFax = ''
	set @ShipName = ''
	set @ShipPhone = ''
	set @ShipState = ''
	set @ShipZip = ''
	set @DfltOrdFromID = ''

	-- If Customer
	if @ShipToType = 'C'
	begin
		select	@ShipAddr1 = ltrim(rtrim(Addr1)),
			@ShipAddr2 = ltrim(rtrim(Addr2)),
			@ShipAttn = ltrim(rtrim(Attn)),
			@ShipCity = ltrim(rtrim(City)),
			@ShipCountry = ltrim(rtrim(Country)),
			@ShipEmail = ltrim(rtrim(EMailAddr)),
			@ShipFax = ltrim(rtrim(Fax)),
			@ShipName = ltrim(rtrim(Name)),
			@ShipPhone = ltrim(rtrim(Phone)),
			@ShipState = ltrim(rtrim(State)),
			@ShipZip = ltrim(rtrim(Zip))
		from	SOAddress (NOLOCK)
		where	CustID = @Key1
		and	ShipToID = @Key2
	end
	-- If Vendor
	else if @ShipToType = 'V'
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

		-- If the address and tax ids should come from the Vendor record
		if @Key2Tmp = ''
			select	@ShipAddr1 = ltrim(rtrim(Addr1)),
				@ShipAddr2 = ltrim(rtrim(Addr2)),
				@ShipAttn = ltrim(rtrim(Attn)),
				@ShipCity = ltrim(rtrim(City)),
				@ShipCountry = ltrim(rtrim(Country)),
				@ShipEmail = ltrim(rtrim(EMailAddr)),
				@ShipFax = ltrim(rtrim(Fax)),
				@ShipName = ltrim(rtrim(Name)),
				@ShipPhone = ltrim(rtrim(Phone)),
				@ShipState = ltrim(rtrim(State)),
				@ShipZip = ltrim(rtrim(Zip))
			from	Vendor (NOLOCK)
			where	VendID = @Key1
		else
		begin
			select	@ShipAddr1 = ltrim(rtrim(Addr1)),
				@ShipAddr2 = ltrim(rtrim(Addr2)),
				@ShipAttn = ltrim(rtrim(Attn)),
				@ShipCity = ltrim(rtrim(City)),
				@ShipCountry = ltrim(rtrim(Country)),
				@ShipEmail = (select ltrim(rtrim(EMailAddr)) from Vendor (NOLOCK) where VendID = @Key1),
				@ShipFax = ltrim(rtrim(Fax)),
				@ShipName = ltrim(rtrim(Name)),
				@ShipPhone = ltrim(rtrim(Phone)),
				@ShipState = ltrim(rtrim(State)),
				@ShipZip = ltrim(rtrim(Zip))
			from	POAddress (NOLOCK)
			where	VendID = @Key1
			and	OrdFromID = @Key2Tmp
		end
	end
	-- If Site
	else if @ShipToType = 'S'
	begin
		select	@ShipAddr1 = ltrim(rtrim(Addr1)),
			@ShipAddr2 = ltrim(rtrim(Addr2)),
			@ShipAttn = ltrim(rtrim(Attn)),
			@ShipCity = ltrim(rtrim(City)),
			@ShipCountry = ltrim(rtrim(Country)),
			@ShipEmail = '',
			@ShipFax = ltrim(rtrim(Fax)),
			@ShipName = ltrim(rtrim(Name)),
			@ShipPhone = ltrim(rtrim(Phone)),
			@ShipState = ltrim(rtrim(State)),
			@ShipZip = ltrim(rtrim(Zip))
		from	Site (NOLOCK)
		where	SiteID = @Key1
	end
	-- If Address
	else if @ShipToType = 'O'
	begin
		select	@ShipAddr1 = ltrim(rtrim(Addr1)),
			@ShipAddr2 = ltrim(rtrim(Addr2)),
			@ShipAttn = ltrim(rtrim(Attn)),
			@ShipCity = ltrim(rtrim(City)),
			@ShipCountry = ltrim(rtrim(Country)),
			@ShipEmail = '',
			@ShipFax = ltrim(rtrim(Fax)),
			@ShipName = ltrim(rtrim(Name)),
			@ShipPhone = ltrim(rtrim(Phone)),
			@ShipState = ltrim(rtrim(State)),
			@ShipZip = ltrim(rtrim(Zip))
		from	Address (NOLOCK)
		where	AddrID = @Key1
	end
	-- if PO Setup
	else if @ShipToType = 'P'
	begin
		select	@ShipAddr1 = ltrim(rtrim(ShipAddr1)),
			@ShipAddr2 = ltrim(rtrim(ShipAddr2)),
			@ShipAttn = ltrim(rtrim(ShipAttn)),
			@ShipCity = ltrim(rtrim(ShipCity)),
			@ShipCountry = ltrim(rtrim(ShipCountry)),
			@ShipEmail = ltrim(rtrim(ShipEmail)),
			@ShipFax = ltrim(rtrim(ShipFax)),
			@ShipName = ltrim(rtrim(ShipName)),
			@ShipPhone = ltrim(rtrim(ShipPhone)),
			@ShipState = ltrim(rtrim(ShipState)),
			@ShipZip = ltrim(rtrim(ShipZip))
		from	POSetup (NOLOCK)
	end

	--select @ShipName, @ShipAttn, @ShipAddr1, @ShipAddr2, @ShipCity, @ShipState, @ShipCountry,
	--	@ShipPhone, @ShipViaID, @FrtTermsID, @TaxID00, @TaxID01, @TaxID02, @TaxID03, @DfltOrdFromID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POShippingAddressInfo] TO [MSDSL]
    AS [dbo];

