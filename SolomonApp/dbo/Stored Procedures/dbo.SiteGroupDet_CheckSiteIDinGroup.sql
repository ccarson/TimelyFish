 /****** Object:  Stored Procedure dbo.SiteGroupDet_CheckSiteIDinGroup    Script Date: 1/24/08 12:30:33 PM ******/
 Create Procedure SiteGroupDet_CheckSiteIDinGroup
   @parmSiteGroupID varchar (10), @parmSiteID varchar (10)
AS

   SELECT Count(*)
     FROM SiteGroupDet
    WHERE SiteGroupID <> @parmSiteGroupID 
      AND SiteID = @parmSiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SiteGroupDet_CheckSiteIDinGroup] TO [MSDSL]
    AS [dbo];

