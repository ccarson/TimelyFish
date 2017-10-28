 create proc DMG_WO_ProcStage
	@WONbr		varchar( 16 )
	AS
	Select		ProcStage
	From		WOHeader
	Where		WONbr = @WONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WO_ProcStage] TO [MSDSL]
    AS [dbo];

