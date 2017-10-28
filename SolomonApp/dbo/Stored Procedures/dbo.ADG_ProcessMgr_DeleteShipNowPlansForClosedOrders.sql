 create proc ADG_ProcessMgr_DeleteShipNowPlansForClosedOrders
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),	-- can be wildcard
	@SchedRef	varchar(5)	-- can be wildcard
as

	select 	SOPlan.InvtID, SOSched.SiteID, SOPlan.PlanDate,
		SOPlan.PlanType, SOPlan.PlanRef
	from 	SOPlan

	join SOSched
	on SOSched.CpnyID = SOPlan.CpnyID
	  and SOSched.OrdNbr = SOPlan.SOOrdNbr
	  and SOSched.LineRef = SOPlan.SOLineRef
	  and SOSched.SchedRef = SOPlan.SOSchedRef

	join Site (NOLOCK)
	on Site.SiteID = SOSched.SiteID

	where SOPlan.CpnyID = @CpnyID
	  and SOPlan.SOOrdNbr = @OrdNbr
	  and SOPlan.SOLineRef like @LineRef
	  and SOPlan.SOSchedRef like @SchedRef
	  and SOSched.Status = 'C'
	  and SOSched.AutoPO = 0	-- Don't select any Bound SO/POs. These must always wait for the PO to be received.
	  and Site.S4Future09 = 1	-- S4Future09 = Ship Regardless of Availability
	  and SOPlan.PlanType in ('50', '52', '54', '60', '62', '64', '70')	-- Sales Order demand types
		order by SOPlan.InvtID, SOSched.SiteID


