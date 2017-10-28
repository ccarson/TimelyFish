
CREATE  VIEW cfvGroupMedicationWithdrawal
AS
select Site = c.ContactName, SvcMgr = csm.ContactName, pg.PigProdPhaseID,  pg.PigGroupID, 
	MktgSvcMgr = cmsm.ContactName,  pg.BarnNbr, 
	Last53MedDel = Max(DateDel), FirstPossibleSaleDate = Max(DateDel) + 49 ,
	FirstSchedDate = Min(m.MovementDate)
	FROM cftPigGroup pg
	JOIN cftContact c ON pg.SiteContactID = c.ContactID
	JOIN cftFeedOrder fo ON pg.PigGroupID = fo.PigGroupID AND fo.InvtIDDel = '053M-MDX' AND fo.DateDel = (SELECT Max(DateDel) FROM cftFeedOrder WHERE PigGroupID = fo.PigGroupID and InvtIDDel='053M-MDX')
	LEFT JOIN cfvCurrentSvcMgr vsm ON pg.SiteContactID = vsm.SiteContactID
	LEFT JOIN cftContact csm ON vsm.SvcMgrContactID = csm.ContactID
	LEFT JOIN cfvCurrentMktSvcMgr vmsm ON pg.SiteContactID = vmsm.SiteContactID
	LEFT JOIN cftContact cmsm ON vmsm.MktMgrContactID = cmsm.ContactID
	LEFT JOIN cftPM m ON pg.PigGroupID = m.SourcePigGroupID 
			AND m.MarketSaleTypeID Not In('55','60','70')
			AND DestPigGroupID = ''
	WHERE pg.PGStatusID = 'A' AND pg.PigSystemID = '00'
	GROUP BY c.ContactName, csm.ContactName, pg.PigProdPhaseID, cmsm.ContactName, pg.PigGroupID, pg.BarnNbr

 


 