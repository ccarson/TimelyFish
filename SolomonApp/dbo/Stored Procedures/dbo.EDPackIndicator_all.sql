 CREATE PROCEDURE EDPackIndicator_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 30 ),
	@parm3 varchar( 1 )
AS
	SELECT *
	FROM EDPackIndicator
	WHERE IndicatorType BETWEEN @parm1min AND @parm1max
	   AND InvtID LIKE @parm2
	   AND PackIndicator LIKE @parm3
	ORDER BY IndicatorType,
	   InvtID,
	   PackIndicator

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


