 CREATE PROCEDURE VendItem_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 4 ),
	@parm4 varchar( 10 ),
	@parm5 varchar( 30 )
AS
	SELECT *
	FROM VendItem
	WHERE InvtID LIKE @parm1
	   AND VendID LIKE @parm2
	   AND FiscYr LIKE @parm3
	   AND SiteID LIKE @parm4
	   AND AlternateID LIKE @parm5
	ORDER BY InvtID,
	   VendID,
	   FiscYr,
	   SiteID,
	   AlternateID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


