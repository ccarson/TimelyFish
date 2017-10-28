
-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/28/2011
-- Description:	This procedure makes the Site dataset for the Mastergroup Marketing Distribution report.
-- =============================================

CREATE PROCEDURE dbo.cfp_REPORT_MASTERGROUP_MARKETING_DISTRIBUTION_SITEDATA 
	@PigGroupID Char(6) 
AS
BEGIN

Select SiteContactName, CurrentSvcMgrName, CurrentMktMgrName
From [$(SolomonApp)].dbo.cftPigGroup pg
	Inner Join  dbo.cfv_SITE s On pg.SiteContactID = s.SiteContactID
Where pg.PigGroupID = @PigGroupID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MASTERGROUP_MARKETING_DISTRIBUTION_SITEDATA] TO [db_sp_exec]
    AS [dbo];

