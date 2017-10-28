 create proc ADG_ProcessMgr_DelPlanPO
	@PONbr		varchar(10),
	@LineRef	varchar(5)
as
	delete	SOPlan
	where	PONbr = @PONbr
	and	POLineRef like @LineRef


