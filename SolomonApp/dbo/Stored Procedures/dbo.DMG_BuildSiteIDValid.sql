 create procedure DMG_BuildSiteIDValid
	@CpnyID varchar(10),
	@SiteID	varchar(10)
as
	declare	@Count smallint

	-- If the Inventory module is not installed
	if (select count(*) from INSetup (NOLOCK) where Init = 1) = 0
	begin
		select	@Count = count(*)
		from	Site (NOLOCK)
		where	CpnyID = @CpnyID
		and	SiteID = @SiteID
	end
	else
	begin
		Select	@Count = count(distinct(Site.SiteID))
		from 	Site (NOLOCK)
		join	LocTable (NOLOCK) on LocTable.SiteID = Site.SiteID and LocTable.SalesValid <> 'N'
        	where 	Site.CpnyID = @CpnyID
		and	Site.SiteID = @SiteID
 	end

	--select @Count

	if @Count = 0
		return 0	--Failure
	else
		return 1	--Success


