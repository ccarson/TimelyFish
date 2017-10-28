 create proc DMG_INSetup_CPSOnOff
	@CPSOnOff	smallint OUTPUT
as
	select	@CPSOnOff = CPSOnOff
	from	INSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CPSOnOff = 0
		return 0	--Failure
	end
	else
		--select @CPSOnOff
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_INSetup_CPSOnOff] TO [MSDSL]
    AS [dbo];

