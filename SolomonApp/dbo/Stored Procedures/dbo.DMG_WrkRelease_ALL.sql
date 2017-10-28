 CREATE PROC DMG_WrkRelease_ALL
	@BatNbr		Char(10),
	@Module		Char(2),
	@UserAddress	Char(21)
AS
	SELECT * FROM WrkRelease
		WHERE WrkRelease.BatNbr = @BatNbr
			AND WrkRelease.Module Like @Module
			AND WrkRelease.UserAddress Like @UserAddress

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WrkRelease_ALL] TO [MSDSL]
    AS [dbo];

