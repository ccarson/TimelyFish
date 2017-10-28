
CREATE FUNCTION
    dbo.cff_tvf_GetSiteMarketManagerData(
        @SiteContactID  int
      , @EffectiveDate  smalldatetime  )
RETURNS TABLE
    WITH SCHEMABINDING
    AS
/*
***********************************************************************************************************************************
    Function:   dbo.cff_tvf_GetSiteMarketManagerData
    Created:    2017-02-16

    Purpose:    Given a site and an EffectiveDate, return the most current data for the Site market manager

    Revisions:
    Date        Revisor         Comments
    2017-02-16  ccarson         created function


***********************************************************************************************************************************
*/
RETURN

SELECT TOP 1
    ContactID   =   contact.ContactID
  , UserID      =   ISNULL( employee.UserID, '' )
  , ContactName =   contact.ContactName
FROM
    dbo.cftMktMgrAssign AS siteMM
INNER JOIN
    dbo.cftContact AS contact
        ON contact.ContactID = siteMM.MktMgrContactID
LEFT JOIN
    dbo.cftEmployee AS employee
        ON employee.ContactID = contact.ContactID
WHERE
    siteMM.SiteContactID = @SiteContactID
        AND siteMM.EffectiveDate <= @EffectiveDate
ORDER BY
    siteMM.EffectiveDate DESC ;

