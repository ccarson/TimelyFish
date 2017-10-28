
CREATE VIEW [dbo].[cfv_CURRENT_SITE_PODS]
AS
SELECT c.ContactName, ppp.Description, sp.*
FROM dbo.cftSitePod sp
LEFT OUTER JOIN dbo.cftContact c
	ON c.ContactID = sp.ContactID
LEFT OUTER JOIN dbo.cftPigProdPod ppp
	ON ppp.PodID = sp.PodID
INNER JOIN 
(SELECT ContactID, MAX(EffectiveDate) effdate
FROM dbo.cftSitePod
GROUP BY ContactID)  ed
	ON sp.ContactID = ed.ContactID and sp.EffectiveDate=ed.effdate
