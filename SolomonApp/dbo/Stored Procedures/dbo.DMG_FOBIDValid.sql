 create procedure DMG_FOBIDValid
	@FOBID	varchar(15)
as
	if (
	select	count(*)
	from	FOBPoint (NOLOCK)
	where	FOBID = @FOBID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_FOBIDValid] TO [MSDSL]
    AS [dbo];

