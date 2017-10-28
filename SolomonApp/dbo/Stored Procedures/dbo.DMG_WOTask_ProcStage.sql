 create proc DMG_WOTask_ProcStage
	@WONbr		varchar( 16 ),
	@Task		varchar( 32 )
	AS
	Select	ProcStage
	From		WOTask
	Where		WONbr = @WONbr and
			Task = @Task



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WOTask_ProcStage] TO [MSDSL]
    AS [dbo];

