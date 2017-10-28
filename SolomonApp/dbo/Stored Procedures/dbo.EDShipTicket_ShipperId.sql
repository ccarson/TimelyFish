 CREATE PROCEDURE EDShipTicket_ShipperId
 @parm1 varchar( 15 )
AS
 SELECT *
 FROM EDShipTicket
 WHERE ShipperId LIKE @parm1
 ORDER BY ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTicket_ShipperId] TO [MSDSL]
    AS [dbo];

