 CREATE PROCEDURE EDRelease_all
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDRelease
 WHERE ReleaseNbr LIKE @parm1
 ORDER BY ReleaseNbr


