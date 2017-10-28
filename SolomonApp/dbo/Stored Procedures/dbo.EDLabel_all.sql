 CREATE PROCEDURE EDLabel_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM EDLabel
	WHERE Name LIKE @parm1
	   AND SiteID LIKE @parm2
	ORDER BY Name,
	   SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


