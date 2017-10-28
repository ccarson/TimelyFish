 CREATE PROCEDURE ADG_ItemXRef_Rec
	@AlternateID varchar(30),
	@AltIDType varchar(1),
	@EntityID varchar(15),
	@InvtID varchar(30)
AS
	SELECT *
	FROM ItemXRef
	WHERE AlternateID = @AlternateID AND
		AltIDType = @AltIDType AND
		EntityID = @EntityID AND
		InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


