 CREATE PROCEDURE DMG_Component_Item
	@KitID		varchar(30),
	@CmpnentID	varchar(30)
AS
	select	*
	from	Component
     	where	KitId = @KitID
	and	CmpnentID = @CmpnentID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


