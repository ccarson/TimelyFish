 CREATE PROCEDURE DMG_SOType_Nav
	@CpnyID varchar(10),
	@SOTypeID varchar(4)
AS
	SELECT *
	FROM SOType
	WHERE CpnyID LIKE @CpnyID
	   AND SOTypeID LIKE @SOTypeID
	ORDER BY SOTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOType_Nav] TO [MSDSL]
    AS [dbo];

