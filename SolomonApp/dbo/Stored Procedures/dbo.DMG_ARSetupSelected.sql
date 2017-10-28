 create procedure DMG_ARSetupSelected
	@CurrPerNbr	varchar(6) OUTPUT
as
	select	@CurrPernbr = ltrim(rtrim(CurrPerNbr))
	from 	ARSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CurrPerNbr = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ARSetupSelected] TO [MSDSL]
    AS [dbo];

