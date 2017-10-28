 CREATE PROCEDURE SOBuildLot_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 )
AS
	SELECT *
	FROM SOBuildLot
	WHERE CpnyID LIKE @parm1
	   AND ShipperID LIKE @parm2
	   AND LotSerRef LIKE @parm3
	ORDER BY CpnyID,
	   ShipperID,
	   LotSerRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


