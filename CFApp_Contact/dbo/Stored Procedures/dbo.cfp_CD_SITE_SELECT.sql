-- ==================================================================
-- Author:        Brian Cesafsky
-- Create date: 09/30/2009
-- Description:   CENTRAL DATA - Returns all sites
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_SITE_SELECT]
AS
BEGIN
      SET NOCOUNT ON;

      SELECT Contact.ContactID
              ,Contact.ContactName
              ,Contact.ShortName
              ,Contact.StatusTypeID
              ,Contact.TranSchedMethodTypeID
              ,Site.SiteID
              ,Site.FacilityTypeID
              ,Site.PigSystemID
              ,Site.OwnershipID
              ,Site.AccountingEntityID
              ,Site.DefaultPigCompanyID
              ,Site.OwningCpnyID
              ,Site.ContractCpnyID
              ,Site.AutomateInterstatePigMovementReport
      FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
      LEFT JOIN [$(CentralData)].dbo.Site Site (NOLOCK)
            ON Site.ContactID=Contact.ContactID 
      WHERE ContactTypeID in (1,4) --Business and Site
      ORDER BY ContactName

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_SITE_SELECT] TO [db_sp_exec]
    AS [dbo];

