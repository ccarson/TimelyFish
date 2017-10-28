 CREATE PROCEDURE ADG_Site_Name
	@parm1 varchar(10)
AS
	SELECT Name
	FROM Site
	WHERE SiteID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


