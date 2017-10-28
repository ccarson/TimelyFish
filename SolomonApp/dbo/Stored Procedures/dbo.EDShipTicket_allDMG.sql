 /****** Object:  Stored Procedure dbo.EDShipTicket_all    Script Date: 5/28/99 1:17:44 PM ******/
CREATE PROCEDURE EDShipTicket_allDMG
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



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTicket_allDMG] TO [MSDSL]
    AS [dbo];

