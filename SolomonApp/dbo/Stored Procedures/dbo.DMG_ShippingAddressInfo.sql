 create procedure DMG_ShippingAddressInfo
	@ShipToType	varchar(1),
	@Key1		varchar(15),
	@Key2		varchar(10),
	@ShipName	varchar(60) OUTPUT,
	@ShipAttn	varchar(30) OUTPUT,
	@ShipAddr1	varchar(60) OUTPUT,
	@ShipAddr2	varchar(60) OUTPUT,
	@ShipCity	varchar(30) OUTPUT,
	@ShipState	varchar(3) OUTPUT,
	@ShipZip	varchar(15) OUTPUT,
	@ShipCountry	varchar(3) OUTPUT,
	@ShipPhone	varchar(30) OUTPUT,
	@ShipViaID	varchar(15) OUTPUT,
	@FrtTermsID	varchar(10) OUTPUT,
	@TaxID00	varchar(10) OUTPUT,
	@TaxID01	varchar(10) OUTPUT,
	@TaxID02	varchar(10) OUTPUT,
	@TaxID03	varchar(10) OUTPUT,
	@DfltOrdFromID	varchar(10) OUTPUT
as
	declare @Key2Tmp	varchar(10)

	--Initialize all the output parameters
	set @ShipName = ''
	set @ShipAttn = ''
	set @ShipAddr1 = ''
	set @ShipAddr2 = ''
	set @ShipCity = ''
	set @ShipState = ''
	set @ShipZip = ''
	set @ShipCountry = ''
	set @ShipPhone = ''
	set @ShipViaID = ''
	set @FrtTermsID = ''
	set @TaxID00 = ''
	set @TaxID01 = ''
	set @TaxID02 = ''
	set @TaxID03 = ''
	set @DfltOrdFromID = ''

	-- If Customer
	if @ShipToType = 'C'
	begin
		select	@ShipName = ltrim(rtrim(Name)),
			@ShipAttn = ltrim(rtrim(Attn)),
			@ShipAddr1 = ltrim(rtrim(Addr1)),
			@ShipAddr2 = ltrim(rtrim(Addr2)),
			@ShipCity = ltrim(rtrim(City)),
			@ShipState = ltrim(rtrim(State)),
			@ShipZip = ltrim(rtrim(Zip)),
			@ShipCountry = ltrim(rtrim(Country)),
			@ShipPhone = ltrim(rtrim(Phone)),
			@ShipViaID = ltrim(rtrim(ShipViaID)),
			@FrtTermsID = ltrim(rtrim(FrtTermsID)),
			@TaxID00 = ltrim(rtrim(TaxID00)),
			@TaxID01 = ltrim(rtrim(TaxID01)),
			@TaxID02 = ltrim(rtrim(TaxID02)),
			@TaxID03 = ltrim(rtrim(TaxID03))
		from	SOAddress (NOLOCK)
		where	CustID = @Key1
		and	ShipToID = @Key2

		-- If the tax ids should come from the customer record
		if (select ltrim(rtrim(TaxDflt)) from Customer (NOLOCK) where CustID = @Key1) <> 'A'
		begin
			select	@TaxID00 = ltrim(rtrim(TaxID00)),
				@TaxID01 = ltrim(rtrim(TaxID01)),
				@TaxID02 = ltrim(rtrim(TaxID02)),
				@TaxID03 = ltrim(rtrim(TaxID03))
			from	Customer (NOLOCK)
			where	CustID = @Key1
		end
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
			select	@ShipName = ltrim(rtrim(Name)),
				@ShipAttn = ltrim(rtrim(Attn)),
				@ShipAddr1 = ltrim(rtrim(Addr1)),
				@ShipAddr2 = ltrim(rtrim(Addr2)),
				@ShipCity = ltrim(rtrim(City)),
				@ShipState = ltrim(rtrim(State)),
				@ShipZip = ltrim(rtrim(Zip)),
				@ShipCountry = ltrim(rtrim(Country)),
				@ShipPhone = ltrim(rtrim(Phone)),
				@TaxID00 = ltrim(rtrim(TaxID00)),
				@TaxID01 = ltrim(rtrim(TaxID01)),
				@TaxID02 = ltrim(rtrim(TaxID02)),
				@TaxID03 = ltrim(rtrim(TaxID03))
			from	Vendor (NOLOCK)
			where	VendID = @Key1
		else
		begin
			select	@ShipName = ltrim(rtrim(Name)),
				@ShipAttn = ltrim(rtrim(Attn)),
				@ShipAddr1 = ltrim(rtrim(Addr1)),
				@ShipAddr2 = ltrim(rtrim(Addr2)),
				@ShipCity = ltrim(rtrim(City)),
				@ShipState = ltrim(rtrim(State)),
				@ShipZip = ltrim(rtrim(Zip)),
				@ShipCountry = ltrim(rtrim(Country)),
				@ShipPhone = ltrim(rtrim(Phone)),
				@TaxID00 = ltrim(rtrim(TaxID00)),
				@TaxID01 = ltrim(rtrim(TaxID01)),
				@TaxID02 = ltrim(rtrim(TaxID02)),
				@TaxID03 = ltrim(rtrim(TaxID03))
			from	POAddress (NOLOCK)
			where	VendID = @Key1
			and	OrdFromID = @Key2Tmp

			-- If the tax ids should come from the vendor
			if (select ltrim(rtrim(TaxDflt)) from Vendor where VendID = @Key1) = 'V'
			begin
				select	@TaxID00 = ltrim(rtrim(TaxID00)),
					@TaxID01 = ltrim(rtrim(TaxID01)),
					@TaxID02 = ltrim(rtrim(TaxID02)),
					@TaxID03 = ltrim(rtrim(TaxID03))
				from	Vendor (NOLOCK)
				where	VendID = @Key1
			end
		end
	end
	-- If Site
	else if @ShipToType = 'S'
	begin
		select	@ShipName = ltrim(rtrim(Name)),
			@ShipAttn = ltrim(rtrim(Attn)),
			@ShipAddr1 = ltrim(rtrim(Addr1)),
			@ShipAddr2 = ltrim(rtrim(Addr2)),
			@ShipCity = ltrim(rtrim(City)),
			@ShipState = ltrim(rtrim(State)),
			@ShipZip = ltrim(rtrim(Zip)),
			@ShipCountry = ltrim(rtrim(Country)),
			@ShipPhone = ltrim(rtrim(Phone))
		from	Site (NOLOCK)
		where	SiteID = @Key1
	end
	-- If Address
	else if @ShipToType = 'O'
	begin
		select	@ShipName = ltrim(rtrim(Name)),
			@ShipAttn = ltrim(rtrim(Attn)),
			@ShipAddr1 = ltrim(rtrim(Addr1)),
			@ShipAddr2 = ltrim(rtrim(Addr2)),
			@ShipCity = ltrim(rtrim(City)),
			@ShipState = ltrim(rtrim(State)),
			@ShipZip = ltrim(rtrim(Zip)),
			@ShipCountry = ltrim(rtrim(Country)),
			@ShipPhone = ltrim(rtrim(Phone)),
			@TaxID00 = ltrim(rtrim(TaxID00)),
			@TaxID01 = ltrim(rtrim(TaxID01)),
			@TaxID02 = ltrim(rtrim(TaxID02)),
			@TaxID03 = ltrim(rtrim(TaxID03))
		from	Address (NOLOCK)
		where	AddrID = @Key1
	end

	--select @ShipName, @ShipAttn, @ShipAddr1, @ShipAddr2, @ShipCity, @ShipState, @ShipCountry,
	--	@ShipPhone, @ShipViaID, @FrtTermsID, @TaxID00, @TaxID01, @TaxID02, @TaxID03, @DfltOrdFromID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ShippingAddressInfo] TO [MSDSL]
    AS [dbo];

