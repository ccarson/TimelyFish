 CREATE PROC ADG_Kit_Active_All
	@parm1 varchar (30)
AS
	select	Kit.ExpKitDet,
		Kit.KitId,
		Kit.KitType,
		Kit.SiteId,
		Inventory.*
	from	Kit
	join	Inventory on Inventory.InvtID = Kit.KitID
	where	Kit.KitId like @parm1
	and	Kit.Status = 'A'
	and     Kit.KitType <> 'B'
	and	Inventory.TranStatusCode in ('AC','NP','OH','NU')
	order by Kitid


