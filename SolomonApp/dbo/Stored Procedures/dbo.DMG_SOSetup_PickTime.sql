 create proc DMG_SOSetup_PickTime
	@PickTime	smallint OUTPUT
as
	select	@PickTime = PickTime
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @PickTime = 0
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSetup_PickTime] TO [MSDSL]
    AS [dbo];

