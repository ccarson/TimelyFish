 create procedure DMG_PR_APSetupSelected
	@CurrPerNbr	varchar(6) OUTPUT
as
	select	@CurrPerNbr = ltrim(rtrim(CurrPerNbr))
	from	APSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CurrPerNbr = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_APSetupSelected] TO [MSDSL]
    AS [dbo];

