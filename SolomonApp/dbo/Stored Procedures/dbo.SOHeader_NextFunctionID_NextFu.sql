 CREATE PROCEDURE SOHeader_NextFunctionID_NextFu
	@parm1 varchar( 8 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 15 )
AS
	SELECT *
	FROM SOHeader
	WHERE NextFunctionID LIKE @parm1
	   AND NextFunctionClass LIKE @parm2
	   AND CpnyID LIKE @parm3
	   AND OrdNbr LIKE @parm4
	ORDER BY NextFunctionID,
	   NextFunctionClass,
	   CpnyID,
	   OrdNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


