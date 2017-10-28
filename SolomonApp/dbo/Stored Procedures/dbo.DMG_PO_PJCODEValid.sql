 create procedure DMG_PO_PJCODEValid
	@code_type	varchar(4),
	@code_value	varchar(30)
as
	if (
	select	count(*)
	from	PJCODE (NOLOCK)
	where	code_type = @code_type
	and	code_value = @code_value
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_PJCODEValid] TO [MSDSL]
    AS [dbo];

