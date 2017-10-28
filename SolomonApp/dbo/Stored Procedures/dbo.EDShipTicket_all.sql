 CREATE PROCEDURE EDShipTicket_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 20 )
AS
	SELECT *
	FROM EDShipTicket
	WHERE CpnyId LIKE @parm1
	   AND ShipperId LIKE @parm2
	   AND BOLNbr LIKE @parm3
	ORDER BY CpnyId,
	   ShipperId,
	   BOLNbr


