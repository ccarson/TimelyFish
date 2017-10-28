 create procedure DMG_TermsIDValid
	@TermsID	varchar(2)
as
	if (
	select	count(*)
	from	Terms (NOLOCK)
	where	TermsID = @TermsID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_TermsIDValid] TO [MSDSL]
    AS [dbo];

