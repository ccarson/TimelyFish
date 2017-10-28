 create procedure DMG_PO_GLSetupSelected
	@ValidateAcctSub	smallint OUTPUT
as
	select	@ValidateAcctSub = ValidateAcctSub
	from	GLSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @ValidateAcctSub = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_GLSetupSelected] TO [MSDSL]
    AS [dbo];

