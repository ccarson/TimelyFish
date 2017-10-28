

CREATE    VIEW cfv_Barn_Capacity (Project, SiteContactID, ContactName, CurrentInv, SolomonCapacity, CentralCapacity)
AS

SELECT	cv.Project, pg.SiteContactID, ct.ContactName, Sum(cv.CurrentInv)As CurrentInv, Sum(bn.StdCap) AS SolomonCapacity, Sum(bn2.StdCap) As CentralCap
FROM cftBarn bn2
LEFT JOIN cftContact ct1 ON bn2.ContactID=ct1.ContactId
LEFT JOIN cftPigGroup pg ON ct1.ContactID=pg.SiteContactID
LEFT JOIN cfvCurrentInv cv ON pg.TaskID=cv.TaskID
LEFT JOIN cftBarn bn ON pg.SiteContactID=bn.ContactID AND pg.BarnNbr=bn.BarnNbr
LEFT JOIN cftContact ct ON pg.SiteContactID=ct.ContactID
Where bn.StatusTypeID<>'2'
Group by cv.Project, pg.SiteCOntactID, ct.ContactName





 