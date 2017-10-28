
-- =============================================
-- Author:	mdawson
-- Create date: 1/15/2008
-- Description:	Returns Truckers used in Market Trucking Report
-- =============================================

CREATE PROC dbo.[cfp_TRUCKERS_FROM_TRANSPORTATION_MARKET_TRUCKING_REPORT_SELECT]
AS

SELECT	0 RecType
,	0 ContactID
,	'All' ContactName
UNION ALL
Select Distinct 
	1 RecType,
	c.ContactID, 
	rtrim(c.ShortName) as ContactName
FROM 
[$(SolomonApp)].dbo.vxt605markettrucking vxt605markettrucking
JOIN [$(SolomonApp)].dbo.cftContact c (NOLOCK) on vxt605markettrucking.TruckerContactID=c.ContactID
Order by RecType, ContactName


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRUCKERS_FROM_TRANSPORTATION_MARKET_TRUCKING_REPORT_SELECT] TO [db_sp_exec]
    AS [dbo];

