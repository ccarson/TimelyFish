 CREATE PROCEDURE EDSOShipHeader_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 20 )
AS
	SELECT *
	FROM EDSOShipHeader
	WHERE CpnyId LIKE @parm1
	   AND ShipperId LIKE @parm2
	   AND BOL LIKE @parm3
	ORDER BY CpnyId,
	   ShipperId,
	   BOL


