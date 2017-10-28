 create proc DMG_ItemSite_LeadTime
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@LeadTime	decimal(25,9) OUTPUT
as
	select	@LeadTime = LeadTime
	from	ItemSite (NOLOCK)
	where	InvtID = @InvtID
	  and	SiteID = @SiteID

	if @@ROWCOUNT = 0 begin
		set @LeadTime = 0
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemSite_LeadTime] TO [MSDSL]
    AS [dbo];

