 create procedure FMG_FrtTermsValid
	@FrtTermsID	varchar(10)
as
	if (
	select	count(*)
	from	FrtTerms (NOLOCK)
	where	FrtTermsID = @FrtTermsID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_FrtTermsValid] TO [MSDSL]
    AS [dbo];

