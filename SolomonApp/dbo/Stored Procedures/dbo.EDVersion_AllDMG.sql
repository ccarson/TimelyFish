 /****** Object:  Stored Procedure dbo.EDVersion_All    Script Date: 5/28/99 1:17:46 PM ******/
CREATE PROCEDURE EDVersion_AllDMG
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDVersion
 WHERE VersionNbr LIKE @parm1
 ORDER BY VersionNbr


