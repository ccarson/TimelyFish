 create procedure FMG_SiteValid
	@SiteID	varchar(10)
as
	if (
	select	count(*)
	from	Site (NOLOCK)
	where	SiteID = @SiteID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_SiteValid] TO [MSDSL]
    AS [dbo];

