 CREATE PROCEDURE DMG_ItemXref_NoCust

	@AlternateID	varchar(30)
AS
	Select	*
	From	ItemXref
	Where	AlternateID = @AlternateID
	And	AltIDType in ('G','S','M','K','U','E','I','D','P','B')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemXref_NoCust] TO [MSDSL]
    AS [dbo];

