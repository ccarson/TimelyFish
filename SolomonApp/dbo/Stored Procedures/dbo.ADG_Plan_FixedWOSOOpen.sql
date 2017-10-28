 create proc ADG_Plan_FixedWOSOOpen
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	WOBuildTo.QtyRemaining,
		'SOQtyOpen' = (SOLine.QtyOrd - SOLine.QtyShip),
		SOLine.CnvFact,
		SOLine.UnitMultDiv

	from	WOBuildTo

	join	WOHeader
	on	WOHeader.WONbr = WOBuildTo.WONbr

	join	SOLine
	on	SOLine.CpnyID = WOBuildTo.CpnyID
	and	SOLine.OrdNbr = WOBuildTo.OrdNbr
	and	SOLine.LineRef = WOBuildTo.BuildToLineRef

	where	SOLine.InvtID = @InvtID
	and	SOLine.SiteID = @SiteID
	and	SOLine.BoundToWO = 1		-- Bound to WO only
	and	WOHeader.Status in ('A', 'H')	-- Active, Hold
	and	WOHeader.ProcStage <> 'P'	-- Not Planned Stage WOs
	and	WOBuildTo.Status = 'P'		-- Planned targets only
	and	SOLine.Status = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_FixedWOSOOpen] TO [MSDSL]
    AS [dbo];

