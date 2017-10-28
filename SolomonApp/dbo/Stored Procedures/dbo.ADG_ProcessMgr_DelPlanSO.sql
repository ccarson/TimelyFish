 create proc ADG_ProcessMgr_DelPlanSO
 	@CpnyID		varchar(10),
 	@OrdNbr		varchar(15),
 	@LineRef	varchar(5),
 	@SchedRef	varchar(5)
as
	delete	SOPlan
 	where	CpnyID = @CpnyID
 	and	SOOrdNbr = @OrdNbr
 	and	SOLineRef like @LineRef
 	and	SOSchedRef like @SchedRef
 	and	SOShipperID = ''


