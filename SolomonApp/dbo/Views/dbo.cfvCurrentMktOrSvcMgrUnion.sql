
CREATE VIEW cfvCurrentMktOrSvcMgrUnion
AS	
--created by sflohrs 2/22/05
--Unions the current Svc Mgr and Mkt Svc Mgr. To be used in Reports where we will group by MktOrSvcMgrName.
--This will allow reports to go to both the Svc Manager and Mkt Svc Manager with data under each grouping. That way
--Mkt Svc Mgrs do not have to "pick through" the Svc Mgrs report and vise-versa.

	SELECT     s.SiteContactID, s.SvcMgrContactID as MgrContactID, c.ContactName AS MktOrSvcMgrName, 'Svc Mgr' as MgrType
	FROM         dbo.cftSiteSvcMgrAsn s INNER JOIN
			dbo.cftContact c On s.SvcMgrContactID = c.ContactID
	WHERE     (s.SvcMgrContactID <> '') AND (s.EffectiveDate =
	                          (SELECT     MAX(effectivedate)
	                            FROM          cftSiteSvcMgrAsn
	                            WHERE      SiteContactID = s.SiteContactID AND s.EffectiveDate <= GetDate()))
	
	UNION 
	
	SELECT     mk.SiteContactID, mk.MktMgrContactID, c.ContactName, 'Mkt Svc Mgr' 
	FROM         dbo.cftMktMgrAssign mk INNER JOIN
	                      dbo.cftContact c ON mk.MktMgrContactID = c.ContactID
		     INNER JOIN dbo.cfvCurrentSvcMgr csm on
			       mk.SiteContactID = csm.SiteContactID	
	WHERE     (mk.MktMgrContactID <> '') AND (mk.EffectiveDate =
	                          (SELECT     MAX(effectivedate)
	                            FROM          cftMktMgrAssign
	                            WHERE      SiteContactID = mk.SiteContactID AND mk.EffectiveDate <= GetDate())) 		
		  AND mk.MktMgrContactID <> csm.SvcMgrContactID --don't want to see the same person as both the svc mgr and mkt svc mgr. So if in the first pass (svc mgr) don't show as mkt svc mgr.

 