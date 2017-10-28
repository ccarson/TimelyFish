 /****** Object:  Stored Procedure dbo.SiteGroupDet_CheckSiteIDDelete    Script Date: 1/24/08 12:30:33 PM ******/
 Create Procedure SiteGroupDet_CheckSiteIDDelete
   @parmSiteID varchar (10)
AS

   SELECT Count(*)
     FROM SiteGroupDet
    WHERE SiteID = @parmSiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SiteGroupDet_CheckSiteIDDelete] TO [MSDSL]
    AS [dbo];

