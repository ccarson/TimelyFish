 CREATE PROCEDURE EDDataElement_all
 @parm1 varchar( 5 ),
 @parm2 varchar( 2 ),
 @parm3 varchar( 15 )
AS
 SELECT *
 FROM EDDataElement
 WHERE Segment LIKE @parm1
    AND Position LIKE @parm2
    AND Code LIKE @parm3
 ORDER BY Segment,
    Position,
    Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_all] TO [MSDSL]
    AS [dbo];

