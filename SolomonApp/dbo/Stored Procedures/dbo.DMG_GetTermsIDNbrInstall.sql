 create procedure DMG_GetTermsIDNbrInstall
	@TermsID	varchar(2),
	@NbrInstall	smallint OUTPUT
as
	select	@NbrInstall = NbrInstall
	from	Terms (NOLOCK)
	where	TermsID = @TermsID

	if @@ROWCOUNT = 0 begin
		set @NbrInstall = 0
		return 0	--Failure
	end
	else begin
		--select @NbrInstall
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetTermsIDNbrInstall] TO [MSDSL]
    AS [dbo];

