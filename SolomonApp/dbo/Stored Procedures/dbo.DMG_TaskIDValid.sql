 create procedure DMG_TaskIDValid
	@project	varchar(16),
	@pjt_entity	varchar(32)
as
	if (
	select	count(*)
	from	PJPENT (NOLOCK)
	where	project = @project
	and	pjt_entity = @pjt_entity
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_TaskIDValid] TO [MSDSL]
    AS [dbo];

