 create proc ADG_ProcessMgr_UniqueItems
	@InvtIDParm	varchar(30),
	@SiteIDParm	varchar(10)
as

select	InvtID,
	SiteID

from	ItemSite i1 (nolock)

where	i1.InvtID like @InvtIDParm
and	i1.SiteID like @SiteIDParm
and	(

	-- ItemSite records with any quantities
	QtyAlloc <> 0 or
	QtyAvail <> 0 or
	QtyCustOrd <> 0 or
	QtyIntransit <> 0 or
	QtyNotAvail <> 0 or
	QtyOnBO <> 0 or
	QtyOnDP <> 0 or
	QtyOnHand <> 0 or
	QtyOnKitAssyOrders <> 0 or
	QtyOnPO <> 0 or
	QtyOnTransferOrders <> 0 or
	QtyShipNotInv <> 0

	or exists
		-- Plan records that are not plan type 10 or ones that are plan
		-- type 10 with a quantity
		(select	*
		from	SOPlan (nolock)
		where	SOPlan.InvtID = i1.InvtID
		and	SOPlan.SiteID = i1.SiteID
		and	(SOPlan.PlanType <> 10 or (SOPlan.PlanType = 10 and Qty <> 0)))

	or exists
		-- Open Sales Order lines with a reserving Behavior
		(select	*
		from	SOLine (nolock)
		where	SOLine.InvtID = i1.InvtID
		and	SOLine.SiteID = i1.SiteID
		and	SOLine.Status = 'O')

	or exists
		-- Open Workorders using the Kit item
		-- The main Sales Order query handles the components of the kit
		(select	*
		from	SOHeader (nolock)
		where	SOHeader.BuildInvtID = i1.InvtID
		and	SOHeader.BuildSiteID = i1.SiteID
		and	SOHeader.Status = 'O')

	or exists
		-- Open Transfers using the 'To' site
		-- The main Sales Order query handles the 'From' site
		(select	*
		from	SOLine (nolock)
		join	SOHeader (nolock)
		on	SOHeader.CpnyID = SOLine.CpnyID
		and	SOHeader.OrdNbr = SOLine.OrdNbr
		where	SOLine.InvtID = i1.InvtID
		and	SOHeader.ShipSiteID = i1.SiteID
		and	SOLine.Status = 'O'
		and	SOHeader.Status = 'O')

	or exists
		-- Open Shipper lines with a reserving Behavior
		(select	*
		from	SOShipLine (nolock)
		where	SOShipLine.InvtID = i1.InvtID
		and	SOShipLine.SiteID = i1.SiteID
		and	SOShipLine.Status = 'O')

	or exists
		-- Open (Shipper) Workorders using the Kit item
		-- The main Shipper query handles the components of the kit
		(select	*
		from	SOShipHeader (nolock)
		where	SOShipHeader.BuildInvtID = i1.InvtID
		and	SOShipHeader.SiteID = i1.SiteID
		and	SOShipHeader.Status = 'O')

	or exists
		-- Open (Shipper) Transfers using the 'To' site
		-- The main Sales Order query handles the 'From' site
		(select	*
		from	SOShipLine (nolock)
		join	SOShipHeader (nolock)
		on	SOShipHeader.CpnyID = SOShipLine.CpnyID
		and	SOShipHeader.ShipperID = SOShipLine.ShipperID
		where	SOShipLine.InvtID = i1.InvtID
		and	SOShipHeader.ShipSiteID = i1.SiteID
		and	SOShipLine.Status = 'O'
		and	SOShipHeader.Status = 'O')

	or exists
		-- Open Purchase Order lines
		(select *
		from	PurOrdDet (nolock)
		where	PurOrdDet.InvtID = i1.InvtID
		and	PurOrdDet.SiteID = i1.SiteID
		and	PurOrdDet.OpenLine = 1)
		)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_UniqueItems] TO [MSDSL]
    AS [dbo];

