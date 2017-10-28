 /****** Object:  Stored Procedure dbo.EDSOHeader_all    Script Date: 5/28/99 1:17:45 PM ******/
CREATE PROCEDURE EDSOHeader_allDMG
 @parm1 varchar( 10 ),
 @parm2 varchar( 15 )
AS
 SELECT *
 FROM EDSOHeader
 WHERE CpnyId LIKE @parm1
    AND OrdNbr LIKE @parm2
 ORDER BY CpnyId,
    OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_allDMG] TO [MSDSL]
    AS [dbo];

