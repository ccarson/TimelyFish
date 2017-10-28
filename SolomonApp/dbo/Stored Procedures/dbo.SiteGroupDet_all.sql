 /****** Object:  Stored Procedure dbo.SiteGroupDet_all    Script Date: 01/02/08 12:19:55 PM ******/
CREATE PROCEDURE SiteGroupDet_all 
   @parm1 varchar( 10 ), @parm2 varchar(10)
AS
   SELECT s.*, t.Name
     FROM SiteGroupDet s JOIN Site t
                           ON s.SiteID = t.SiteID
    WHERE s.SiteGroupID LIKE @parm1 AND s.SiteID Like @Parm2
    ORDER BY s.SiteGroupID, s.SiteID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SiteGroupDet_all] TO [MSDSL]
    AS [dbo];

