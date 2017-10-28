 CREATE PROCEDURE EDVersion_all
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDVersion
 WHERE VersionNbr LIKE @parm1
 ORDER BY VersionNbr


