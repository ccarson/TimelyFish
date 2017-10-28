 CREATE PROCEDURE EDDataElement_Code
 @parm1 varchar( 15 )
AS
 SELECT *
 FROM EDDataElement
 WHERE Code LIKE @parm1
 ORDER BY Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Code] TO [MSDSL]
    AS [dbo];

