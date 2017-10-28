 CREATE PROCEDURE EDProcessSelection_all
 @parm1 varchar( 20 )
AS
 SELECT *
 FROM EDProcessSelection
 WHERE EXEName LIKE @parm1
 ORDER BY EXEName


