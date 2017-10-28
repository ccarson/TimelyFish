 create proc ADG_SOPlan_AvailToDate
	@invtid 	varchar(30),
	@siteid 	varchar(10),
	@parm3min smalldatetime, @parm3max smalldatetime,
	@today		smalldatetime
as
	select *
	from	soplan
	where	InvtID like @invtid
	  and	SiteID like @siteid
	  and	(PlanDate BETWEEN @parm3min AND @parm3max or PlanType = '61' and PlanDate > @today)
	ORDER BY InvtID,
	   SiteID,
	   case when PlanType = '61' and PlanDate > @today then @today else PlanDate end,
	   PlanType,
	   PlanRef


