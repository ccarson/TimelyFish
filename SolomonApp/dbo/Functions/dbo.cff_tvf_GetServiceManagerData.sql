CREATE FUNCTION [dbo].[cff_tvf_GetServiceManagerData] (
    @SiteContactID  int
  , @EffectiveDate  smalldatetime  )

RETURNS TABLE
AS

RETURN

WITH
    cteMarketingManager AS(
        SELECT TOP 1
            SiteContactID       =   @SiteContactID
          , MarketManagerID     =   marketManager.MktMgrContactID
        FROM
            dbo.cftMktMgrAssign AS marketManager
        INNER JOIN
            dbo.cftEmployee AS employee
                ON employee.ContactID = marketManager.MktMgrContactID
        WHERE
            marketManager.SiteContactID = @SiteContactID
                AND marketManager.EffectiveDate <= @EffectiveDate
        ORDER BY
            marketManager.EffectiveDate DESC ) ,

    cteServiceManager AS(
        SELECT TOP 1
            SiteContactID       =   @SiteContactID
          , ServiceManagerID    =   serviceManager.SvcMgrContactID
        FROM
            dbo.cftSiteSvcMgrAsn AS serviceManager
        INNER JOIN
            dbo.cftEmployee AS employee
                ON employee.ContactID = serviceManager.SvcMgrContactID
        WHERE
            serviceManager.SiteContactID = @SiteContactID
                AND serviceManager.EffectiveDate <= @EffectiveDate
        ORDER BY
            serviceManager.EffectiveDate DESC ) ,

    cteSeniorServiceManager AS(
        SELECT TOP 1
            SiteContactID           =   @SiteContactID
          , SeniorServiceManagerID  =   seniorManager.ProdSvcMgrContactID
        FROM
            dbo.cftProdSvcMgr AS seniorManager
        WHERE
            seniorManager.SiteContactID = @SiteContactID
                AND seniorManager.EffectiveDate <= @EffectiveDate
        ORDER BY
            seniorManager.EffectiveDate DESC ),

    cteSiteContactID AS( SELECT SiteContactID = @SiteContactID )

SELECT
    MarketManagerID
  , ServiceManagerID
  , SeniorServiceManagerID
FROM
    cteSiteContactID AS a
LEFT JOIN
    cteMarketingManager AS b ON b.SiteContactID = a.SiteContactID
LEFT JOIN
    cteServiceManager AS c ON c.SiteContactID = a.SiteContactID
LEFT JOIN
    cteSeniorServiceManager AS d ON d.SiteContactID = a.SiteContactID ;


