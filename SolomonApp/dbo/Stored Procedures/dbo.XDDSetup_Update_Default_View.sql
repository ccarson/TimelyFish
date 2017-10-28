
create procedure XDDSetup_Update_Default_View
	@SaveType		varchar( 1 ),		-- "E"rror - save to LBViewIDError, "A"pplic - save to LBViewIDApplic
	@ViewID			varchar( 10 )

AS

	if @SaveType = 'E'
		UPDATE		XDDSetup
		Set		LBViewIDError = @ViewID
	else
		UPDATE		XDDSetup
		Set		LBViewIDApplic = @ViewID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDSetup_Update_Default_View] TO [MSDSL]
    AS [dbo];

