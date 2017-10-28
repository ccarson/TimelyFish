 /****** Object:  Stored Procedure dbo.EDRelease_All    Script Date: 5/28/99 1:17:43 PM ******/
CREATE PROCEDURE EDRelease_AllDMG
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDRelease
 WHERE ReleaseNbr LIKE @parm1
 ORDER BY ReleaseNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDRelease_AllDMG] TO [MSDSL]
    AS [dbo];

