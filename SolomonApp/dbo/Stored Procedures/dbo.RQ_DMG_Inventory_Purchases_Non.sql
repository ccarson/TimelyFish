 /****** Object:  Stored Procedure dbo.RQ_DMG_Inventory_Purchases_Non    Script Date: 9/4/2003 6:21:41 PM ******/

/****** Object:  Stored Procedure dbo.RQ_DMG_Inventory_Purchases_Non    Script Date: 7/5/2002 2:44:36 PM ******/

/****** Object:  Stored Procedure dbo.RQ_DMG_Inventory_Purchases_Non    Script Date: 6/26/2002 3:28:46 PM ******/

create proc RQ_DMG_Inventory_Purchases_Non
	@InvtID	varchar(30)
as
	select	*
	from	Inventory
	where	InvtID like @InvtID
	and	TranStatusCode in ('AC','NU')
	and	StkItem = 0
	order by InvtID


