CREATE FUNCTION 
	[dbo].[cff_tvf_GetServiceManager]( 
		@SiteContactID 	char(06)
	  , @EffectiveDate 	smalldatetime ) 

RETURNS TABLE 
AS

RETURN 

WITH cteAssignments AS ( 
SELECT  
	ContactID	=	employee.ContactID
  , UserID		=	employee.UserID
  , ContactName	=	contact.ContactName	
  , N			=	ROW_NUMBER() OVER( ORDER BY EffectiveDate DESC ) 
FROM 
	dbo.cftSiteSvcMgrAsn AS sma
INNER JOIN 
	dbo.cftContact AS contact
		ON contact.ContactID = sma.SvcMgrContactID 
LEFT JOIN 
	dbo.cftEmployee AS employee
		ON employee.ContactID = contact.ContactID 
WHERE 
	@SiteContactID	=	sma.SiteContactID
		AND @EffectiveDate >= EffectiveDate ) 
		
SELECT 
	ContactID	
  , UserID		
  , ContactName	
FROM 
	cteAssignments
WHERE N = 1 AND UserID IS NOT NULL 
; 
