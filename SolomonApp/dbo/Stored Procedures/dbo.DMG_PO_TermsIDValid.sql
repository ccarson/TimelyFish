 create procedure DMG_PO_TermsIDValid
	@TermsID	varchar(2)
as
	if (
	select	count(*)
	from	Terms (NOLOCK)
	where	TermsID = @TermsID
	and	ApplyTo in ('B', 'V')
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_TermsIDValid] TO [MSDSL]
    AS [dbo];

