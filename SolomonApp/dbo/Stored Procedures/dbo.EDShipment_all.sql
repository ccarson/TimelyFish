 CREATE PROCEDURE EDShipment_all
	@parm1 varchar( 20 )
AS
	SELECT *
	FROM EDShipment
	WHERE BOLNbr LIKE @parm1
	ORDER BY BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_all] TO [MSDSL]
    AS [dbo];

