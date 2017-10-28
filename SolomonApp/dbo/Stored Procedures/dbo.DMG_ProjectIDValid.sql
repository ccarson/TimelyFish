 create procedure DMG_ProjectIDValid
	@project	varchar(16)
as
	if (
	select	count(*)
	from	PJPROJ (NOLOCK)
	where	project = @project
	and	status_pa = 'A'
	and	status_ar = 'A'
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


