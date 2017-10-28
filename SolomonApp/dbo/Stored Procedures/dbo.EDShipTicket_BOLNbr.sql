 CREATE PROCEDURE EDShipTicket_BOLNbr
 @parm1 varchar( 20 )
AS
 SELECT *
 FROM EDShipTicket
 WHERE BOLNbr LIKE @parm1
 ORDER BY BOLNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTicket_BOLNbr] TO [MSDSL]
    AS [dbo];

