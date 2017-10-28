 /****** Object:  Stored Procedure dbo.GetSiteName    Script Date: 01/02/08 12:19:55 PM ******/
CREATE PROCEDURE GetSiteName 
   @parm1 varchar( 10 ), @parm2 varchar(10)
AS
   SELECT Name
     FROM Site 
    WHERE SiteID = @parm1 AND cpnyID = @Parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetSiteName] TO [MSDSL]
    AS [dbo];

