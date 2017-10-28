 create proc ADG_ProcessMgr_DeleteFixedPlansClosed
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),	-- can be wildcard
	@SchedRef	varchar(5)	-- can be wildcard
as

	select 	SOPlan.InvtID, SOPlan.SiteID, SOPlan.PlanDate,
		SOPlan.PlanType, SOPlan.PlanRef
	from 	SOPlan

	left join SOLine
	on SOLine.CpnyID = SOPlan.CpnyID
	  and SOLine.OrdNbr = SOPlan.SOOrdNbr
	  and SOLine.LineRef = SOPlan.SOLineRef
	  and SOLine.InvtID = SOPlan.InvtID

	left join SOSched
	on SOSched.CpnyID = SOPlan.CpnyID
	  and SOSched.OrdNbr = SOPlan.SOOrdNbr
	  and SOSched.LineRef = SOLine.LineRef
	  and SOSched.SchedRef = SOPlan.SOSchedRef
	  and SOSched.SiteID = SOPlan.SiteID

	where SOPlan.CpnyID = @CpnyID
	  and SOPlan.SOOrdNbr = @OrdNbr
	  and SOPlan.SOLineRef like @LineRef
	  and SOPlan.SOSchedRef like @SchedRef
	  and COALESCE(SOSched.Status,'C') = 'C'
	  and SOPlan.PlanType = '61'	-- Sales Order demand types
		order by SOPlan.InvtID, SOPlan.SiteID


