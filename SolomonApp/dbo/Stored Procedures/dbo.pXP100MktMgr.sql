

CREATE        Proc dbo.pXP100MktMgr
	as
select ct.ContactName, MktMgrContactID
	FROM cftPigPreMkt pm
	JOIN cftMktMgrAssign mk ON pm.MktMgrID=mk.MktMgrContactID
	JOIN cftContact ct ON mk.MktMgrContactID=ct.ContactID
	WHERE mk.EffectiveDate = (Select max(effectivedate) 
			FROM cftMktMgrAssign 
			WHERE mk.SiteContactID = SiteContactID 
			AND effectivedate <=getDate())
Group by MktMgrContactID, ct.ContactName









