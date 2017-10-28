/****** Object:  UserDefinedFunction [dbo].[GetSeniorSvcManagerID]    Script Date: 2/16/2017 2:57:31 PM ******/
CREATE FUNCTION
    dbo.cff_tvf_GetSiteServiceManagerData(
        @SiteContactID  int
      , @EffectiveDate  smalldatetime  )
RETURNS TABLE
    WITH SCHEMABINDING
    AS
/*
***********************************************************************************************************************************
    Function:   dbo.cff_tvf_GetSiteServiceManagerData
    Created:    2017-02-16

    Purpose:    Given a site and an EffectiveDate, return the most current data for the Site service manager

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
    dbo.cftSiteSvcMgrAsn AS siteSM
INNER JOIN
    dbo.cftContact AS contact
        ON contact.ContactID = siteSM.SvcMgrContactID
LEFT JOIN
    dbo.cftEmployee AS employee
        ON employee.ContactID = contact.ContactID
WHERE
    siteSM.SiteContactID = @SiteContactID
        AND siteSM.EffectiveDate <= @EffectiveDate
ORDER BY
    siteSM.EffectiveDate DESC ;
