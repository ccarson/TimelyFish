 create procedure DMG_POAddressSelected
	@VendID		varchar(15),
	@OrdFromID	varchar(10),
	@Addr1		varchar(60) OUTPUT,
	@Addr2		varchar(60) OUTPUT,
	@Attn		varchar(30) OUTPUT,
	@City		varchar(30) OUTPUT,
	@Country	varchar(3) OUTPUT,
	@EMailAddr	varchar(80) OUTPUT,
	@Fax		varchar(30) OUTPUT,
	@Name		varchar(60) OUTPUT,
	@Phone		varchar(30) OUTPUT,
	@State		varchar(3) OUTPUT,
	@Zip		varchar(10) OUTPUT
as
	declare @POAddressCount	smallint

	select @POAddressCount = (select count(*) from POAddress (NOLOCK) where VendID = @VendID and OrdFromID = @OrdFromID)

	--if the address information should come from the Vendor record
	if @OrdFromID = '' or @POAddressCount = 0
	begin
		select	@Addr1 = ltrim(rtrim(Addr1)),
			@Addr2 = ltrim(rtrim(Addr2)),
			@Attn = ltrim(rtrim(Attn)),
			@City = ltrim(rtrim(City)),
			@Country = ltrim(rtrim(Country)),
			@EMailAddr = ltrim(rtrim(EMailAddr)),
			@Fax = ltrim(rtrim(Fax)),
			@Name = ltrim(rtrim(Name)),
			@Phone = ltrim(rtrim(Phone)),
			@State = ltrim(rtrim(State)),
			@Zip = ltrim(rtrim(Zip))
		from	Vendor (NOLOCK)
		where	VendID = @VendID
	end
	else
	begin
		select	@Addr1 = ltrim(rtrim(Addr1)),
			@Addr2 = ltrim(rtrim(Addr2)),
			@Attn = ltrim(rtrim(Attn)),
			@City = ltrim(rtrim(City)),
			@Country = ltrim(rtrim(Country)),
			@EMailAddr = (select ltrim(rtrim(EMailAddr)) from Vendor (NOLOCK) where VendID = @VendID),
			@Fax = ltrim(rtrim(Fax)),
			@Name = ltrim(rtrim(Name)),
			@Phone = ltrim(rtrim(Phone)),
			@State = ltrim(rtrim(State)),
			@Zip = ltrim(rtrim(Zip))
		from	POAddress (NOLOCK)
		where	VendID = @VendID
		and	OrdFromID = @OrdFromID
	end

	--the OrdFromID is invalid if it was passed and the corresponding POAddress record was not found
	if @OrdFromID <> '' and @POAddressCount = 0
	begin
		set @Addr1 = ''
		set @Addr2 = ''
		set @Attn = ''
		set @City = ''
		set @Country = ''
		set @EMailAddr = ''
		set @Fax = ''
		set @Name = ''
		set @Phone = ''
		set @State = ''
		set @Zip = ''
		return 0	--Failure
	end
	else
		--select @addr1,@Addr2,@Attn,@City,@Country,@Fax,@Name,@Phone,@Zip
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POAddressSelected] TO [MSDSL]
    AS [dbo];

