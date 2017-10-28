 create proc ADG_ProcessMgr_SOSetup
as
	select	AutoCreateShippers
	from	SOSetup (nolock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOSetup] TO [MSDSL]
    AS [dbo];

