 CREATE PROCEDURE EDUOMFP_all
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDUOMFP
 WHERE Dimension LIKE @parm1
 ORDER BY Dimension



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDUOMFP_all] TO [MSDSL]
    AS [dbo];

