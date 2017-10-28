 create procedure DMG_FrtTerms_Collect
	@FrtTermsID	varchar(10),
	@Collect	bit OUTPUT
as
	select	@Collect = Collect
	from	FrtTerms (NOLOCK)
	where	FrtTermsID = @FrtTermsID

	if @@ROWCOUNT = 0 begin
		set @Collect = 0
		return 0	--Failure
	end
	else
		--select @Collect
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_FrtTerms_Collect] TO [MSDSL]
    AS [dbo];

