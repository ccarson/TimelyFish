 CREATE PROCEDURE EDDataElement_Position
 @parm1 varchar( 2 )
AS
 SELECT *
 FROM EDDataElement
 WHERE Position LIKE @parm1
 ORDER BY Position



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Position] TO [MSDSL]
    AS [dbo];

