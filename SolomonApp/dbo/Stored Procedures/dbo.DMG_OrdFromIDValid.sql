 create procedure DMG_OrdFromIDValid
	@VendID		varchar(15),
	@OrdFromID	varchar(10)
as
	if (
	select	count(*)
	from	POAddress (NOLOCK)
	where	VendID = @VendID
	and	OrdFromID = @OrdFromID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


