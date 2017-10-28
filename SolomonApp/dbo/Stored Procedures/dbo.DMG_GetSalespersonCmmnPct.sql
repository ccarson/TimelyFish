 create procedure DMG_GetSalespersonCmmnPct
	@SlsperID	varchar(10),
	@CmmnPct	float OUTPUT
as
	select	@CmmnPct = CmmnPct
	from	Salesperson (NOLOCK)
	where	SlsperID = @SlsperID

	if @@ROWCOUNT = 0 begin
		set @CmmnPct = 0
		return 0	--Failure
	end
	else begin
		--select @CmmnPct
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetSalespersonCmmnPct] TO [MSDSL]
    AS [dbo];

