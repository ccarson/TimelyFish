 create procedure FMG_CU_GLSetupSelected
	@ValidateAcctSub	smallint OUTPUT
as
	select	@ValidateAcctSub = ValidateAcctSub
	from	GLSetup (NOLOCK)

	if @@ROWCOUNT = 0
		return 0	--Failure
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_CU_GLSetupSelected] TO [MSDSL]
    AS [dbo];

