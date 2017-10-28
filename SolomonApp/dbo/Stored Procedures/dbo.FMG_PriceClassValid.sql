 create procedure FMG_PriceClassValid
	@PriceClassType	varchar(1),
	@PriceClassID	varchar(6)
as
	if (
	select	count(*)
	from	PriceClass (NOLOCK)
	where	PriceClassType = @PriceClassType
	and	PriceClassID = @PriceClassID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_PriceClassValid] TO [MSDSL]
    AS [dbo];

