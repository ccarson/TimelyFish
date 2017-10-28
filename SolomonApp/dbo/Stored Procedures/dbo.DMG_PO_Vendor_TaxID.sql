 create procedure DMG_PO_Vendor_TaxID
	@VendID		varchar(15),
	@OrdFromID	varchar(10),
	@TaxID00	varchar(10) OUTPUT,
	@TaxID01	varchar(10) OUTPUT,
	@TaxID02	varchar(10) OUTPUT,
	@TaxID03	varchar(10) OUTPUT
as
	declare @POAddressCount	smallint
	declare @TaxDflt varchar(1)

	select @POAddressCount = (select count(*) from POAddress (NOLOCK) where VendID = @VendID and OrdFromID = @OrdFromID)

	select @TaxDflt = (select TaxDflt from Vendor (NOLOCK) where VendID = @VendID)

	set @TaxID00 = ''
	set @TaxID01 = ''
	set @TaxID02 = ''
	set @TaxID03 = ''

	--if the tax ids should come from the Vendor record
	if @TaxDflt = 'V' or @OrdFromID = '' or @POAddressCount = 0
	begin
		select	@TaxID00 = ltrim(rtrim(TaxID00)),
			@TaxID01 = ltrim(rtrim(TaxID01)),
			@TaxID02 = ltrim(rtrim(TaxID02)),
			@TaxID03 = ltrim(rtrim(TaxID03))
		from	Vendor (NOLOCK)
		where	VendID = @VendID
	end
	else
	begin
		--The tax ids should come from the POAddress record
		select	@TaxID00 = ltrim(rtrim(TaxID00)),
			@TaxID01 = ltrim(rtrim(TaxID01)),
			@TaxID02 = ltrim(rtrim(TaxID02)),
			@TaxID03 = ltrim(rtrim(TaxID03))
		from	POAddress (NOLOCK)
		where	VendID = @VendID
		and	OrdFromID = @OrdFromID
	end

	--the OrdFromID is invalid if it was passed and the corresponding POAddress record was not found
	if @OrdFromID <> '' and @POAddressCount = 0
	begin
		set @TaxID00 = ''
		set @TaxID01 = ''
		set @TaxID02 = ''
		set @TaxID03 = ''
		return 0	--Failure
	end
	else
		--select @TaxID00,@TaxID01,@TaxID02,@TaxID03
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_Vendor_TaxID] TO [MSDSL]
    AS [dbo];

