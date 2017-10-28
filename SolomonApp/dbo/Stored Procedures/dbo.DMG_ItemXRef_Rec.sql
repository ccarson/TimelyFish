 CREATE PROCEDURE DMG_ItemXRef_Rec

	@AlternateID	varchar(30),
	@AltIDType	varchar(1),
	@EntityID	varchar(15),
	@InvtID	varchar(30)
AS
	Select	*
	From	ItemXRef
	Where	AlternateID = @AlternateID
	And	AltIDType = @AltIDType
	And	EntityID = @EntityID
	And	InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemXRef_Rec] TO [MSDSL]
    AS [dbo];

