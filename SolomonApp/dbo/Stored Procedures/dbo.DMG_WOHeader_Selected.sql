 create proc DMG_WOHeader_Selected
	@WONbr		varchar(16)
AS
	select		PrjWOGLIM, ProcStage, WOType
	from		WOHeader
	Where		WONbr = @WONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WOHeader_Selected] TO [MSDSL]
    AS [dbo];

