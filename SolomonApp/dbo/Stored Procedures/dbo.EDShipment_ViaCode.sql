 CREATE PROCEDURE EDShipment_ViaCode
 @parm1 varchar( 15 )
AS
 SELECT *
 FROM EDShipment
 WHERE ViaCode LIKE @parm1
 ORDER BY ViaCode


GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_ViaCode] TO [MSDSL]
    AS [dbo];

