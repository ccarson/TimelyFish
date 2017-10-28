 CREATE PROCEDURE EDConvMeth_Direction
 @parm1 varchar( 1 )
AS
 SELECT *
 FROM EDConvMeth
 WHERE Direction LIKE @parm1
 ORDER BY Direction



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConvMeth_Direction] TO [MSDSL]
    AS [dbo];

