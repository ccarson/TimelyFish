 create proc ADG_ProcessMgr_SOSetup_PM
as
--	select	convert(smallint, S4Future11)	-- PlanScheds
	select	convert(smallint, '1')		-- PlanScheds
	from	SOSetup (nolock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOSetup_PM] TO [MSDSL]
    AS [dbo];

