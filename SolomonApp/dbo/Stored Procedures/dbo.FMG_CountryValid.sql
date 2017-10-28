 create procedure FMG_CountryValid
	@CountryID	varchar(3)
as
	if (
	select	count(*)
	from	Country (NOLOCK)
	where	CountryID = @CountryID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


