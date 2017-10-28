 CREATE PROCEDURE DMG_POAddress_Descr
	@VendID 	varchar(10),
	@OrdFromID	varchar(10)
AS
	select	Descr
	from	POAddress
	where	VendID = @VendID
	and	OrdFromID = @OrdFromID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POAddress_Descr] TO [MSDSL]
    AS [dbo];

