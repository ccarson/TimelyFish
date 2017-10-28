 CREATE PROCEDURE EDSite_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 3 )
AS
 SELECT *
 FROM EDSite
 WHERE SiteID LIKE @parm1
    AND Trans LIKE @parm2
 ORDER BY SiteID,
    Trans



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_all] TO [MSDSL]
    AS [dbo];

