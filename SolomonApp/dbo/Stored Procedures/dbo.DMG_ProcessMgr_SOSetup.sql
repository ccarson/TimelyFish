 create proc DMG_ProcessMgr_SOSetup
	@AutoCreateShippers smallint OUTPUT
as
	set @AutoCreateShippers = 0
		select	@AutoCreateShippers = AutoCreateShippers
	from	SOSetup (NOLOCK)

	--select @AutoCreateShippers


