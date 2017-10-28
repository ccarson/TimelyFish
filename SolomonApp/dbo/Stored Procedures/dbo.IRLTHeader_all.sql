 CREATE PROCEDURE IRLTHeader_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM IRLTHeader
	WHERE LeadTimeID LIKE @parm1
	ORDER BY LeadTimeID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


