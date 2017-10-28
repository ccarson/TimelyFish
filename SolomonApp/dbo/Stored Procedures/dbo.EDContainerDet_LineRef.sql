 CREATE PROCEDURE EDContainerDet_LineRef
 @parm1 varchar( 5 )
AS
 SELECT *
 FROM EDContainerDet
 WHERE LineRef LIKE @parm1
 ORDER BY LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_LineRef] TO [MSDSL]
    AS [dbo];

