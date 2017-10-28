 CREATE PROCEDURE EDContainerDet_CpnyID_ShipperI
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM EDContainerDet
	WHERE CpnyID LIKE @parm1
	   AND ShipperID LIKE @parm2
	ORDER BY CpnyID,
	   ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_CpnyID_ShipperI] TO [MSDSL]
    AS [dbo];

