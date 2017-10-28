 create proc ADG_ProcessMgr_DelPlanSOSchedOrphans
 	@CpnyID		varchar(10),
 	@OrdNbr		varchar(15),
 	@LineRef	varchar(5),
 	@SchedRef	varchar(5)
as
	delete	SOPlan

	from 	SOPlan

	left join SOSched
	on	SOPlan.CpnyID = SOSched.CpnyID
	and	SOPlan.SOOrdNbr = SOSched.OrdNbr
	and	SOPlan.SOLineRef = SOSched.LineRef
	and	SOPlan.SOSchedRef = SOSched.SchedRef

	where 	SOPlan.CpnyID = @CpnyID
	and	SOPlan.SOOrdNbr = @OrdNbr
	and 	SOPlan.SOLineRef like @LineRef
	and	SOPlan.SOSchedRef like @SchedRef
	and 	SOPlan.SOShipperID = ''
	and	SOPlan.SOLineRef <> ''
	and 	(SOSched.LineRef is null or SOSched.SchedRef is null)


