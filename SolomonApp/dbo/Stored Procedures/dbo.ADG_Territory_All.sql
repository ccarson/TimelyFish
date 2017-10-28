 CREATE PROCEDURE ADG_Territory_All
	@SlsPerId varchar(10)
AS
	SELECT *
	FROM Territory
	WHERE Territory LIKE @SlsPerId
	ORDER BY Territory

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Territory_All] TO [MSDSL]
    AS [dbo];

