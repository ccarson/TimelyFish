 create procedure DMG_IRSetupSelected
	@IncludeDropShip	smallint OUTPUT
as
	select	@IncludeDropShip = IncludeDropShip
	from 	IRSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @IncludeDropShip = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_IRSetupSelected] TO [MSDSL]
    AS [dbo];

