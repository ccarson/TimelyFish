 CREATE PROCEDURE DMG_ItemXref_Cust

	@AlternateID	varchar(30),
	@EntityID	varchar(15)
AS
	Select	*
	From	ItemXref
	Where	AlternateID = @AlternateID
	And	(AltIDType = 'C' And EntityID = @EntityID)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemXref_Cust] TO [MSDSL]
    AS [dbo];

