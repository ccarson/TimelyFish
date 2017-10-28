 create proc ADG_ProcessMgr_ShipNowSites
as
	declare	@ShipNowCount	int
	declare	@ShipNowSites	smallint

	select	@ShipNowCount = count(*)
	from	Site
	where	S4Future09 = 1	-- Ship Regardless of Availability

	if (@ShipNowCount > 0)
		select @ShipNowSites = 1
	else
		select @ShipNowSites = 0

	select @ShipNowSites


