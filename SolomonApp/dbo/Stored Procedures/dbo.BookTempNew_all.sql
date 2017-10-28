 CREATE PROCEDURE BookTempNew_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3min smallint, @parm3max smallint,
	@parm4 varchar( 5 ),
	@parm5 varchar( 5 ),
	@parm6 varchar( 15 ),
	@parm7 varchar( 5 ),
	@parm8 varchar( 10 ),
	@parm9 varchar( 1 )
AS
	SELECT *
	FROM BookTempNew
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	   AND BookCntr BETWEEN @parm3min AND @parm3max
	   AND OrdLineRef LIKE @parm4
	   AND SchedRef LIKE @parm5
	   AND ShipperID LIKE @parm6
	   AND ShipLineRef LIKE @parm7
	   AND SlsperID LIKE @parm8
	   AND ActionFlag LIKE @parm9
	ORDER BY CpnyID,
	   OrdNbr,
	   BookCntr,
	   OrdLineRef,
	   SchedRef,
	   ShipperID,
	   ShipLineRef,
	   SlsperID,
	   ActionFlag

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BookTempNew_all] TO [MSDSL]
    AS [dbo];

