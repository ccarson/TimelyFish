 create procedure DMG_FrtTermsSelected
	@FrtTermsID	varchar(10),
	@Collect	smallint OUTPUT,
	@FOBID		varchar(15) OUTPUT
as
	select	@Collect = Collect,
		@FOBID = ltrim(rtrim(FOBID))
	from	FrtTerms (NOLOCK)
	where	FrtTermsID = @FrtTermsID

	if @@ROWCOUNT = 0 begin
		set @Collect = 0
		set @FOBID = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_FrtTermsSelected] TO [MSDSL]
    AS [dbo];

