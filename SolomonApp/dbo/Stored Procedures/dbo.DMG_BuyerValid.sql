 create procedure DMG_BuyerValid
	@Buyer	varchar(10)
as
	if (
	select	count(*)
	from	SIBuyer (NOLOCK)
	where	Buyer = @Buyer
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


