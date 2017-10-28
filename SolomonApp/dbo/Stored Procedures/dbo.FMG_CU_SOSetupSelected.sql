 create procedure FMG_CU_SOSetupSelected
	@ConsolInv	smallint OUTPUT
as
	select	@ConsolInv = ConsolInv
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0
		return 0	--Failure
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_CU_SOSetupSelected] TO [MSDSL]
    AS [dbo];

