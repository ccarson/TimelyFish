



/****** Sue Matter:  Used on Georges' Inventory by Date Spreadsheet    Script Date: 11/19/2004 2:10:22 PM ******/

CREATE        VIEW [dbo].[cfv_PigGroup_InvMkt] (Company, PhaseDesc, SiteName, Status, FacilityType, State, County, Ownership, GroupID, GroupDesc, Gender, PgSystem, Pod,
				   StartDate, StartWgt, StartQty, InvatRunDate, InvToday, Capacity, DeadQty, FeedDays, FeedEff, FeedInv, FeedInvDate, FeedLbs, LastFeedDelivery, 
				   LastSale, SaleQty, SaleWgt, TargerWgt, CalcCurWgt, CalcDeadWgt, CalcOutWgt, WgtToClose, TransEstClose,
				   NextMarketDate, ProjectedCloseOut, MktMgr, SvcMgr, MktSummaryDate, FirstTopDate, FirstTopWgt, ScndTopDate, ScndTopWgt, LastDelvRationID, LastOrdRationID, AcctCompany, Source)
AS
-- MODIFIED 7/7/05 (TJones) - Per George add the last feed delivered ration id
-- MODIFIED 10/12/07 (mdawson) - added source field, mantis 537
SELECT	pg.CpnyID
,	mk.PhaseDesc
,	sd.SiteName
,	pst.Description
,	mk.FacilityType
,	sd.State
,	sd.County
,	sd.SiteOwnershipDescription
,	pg.PigGroupID
,	pg.Description
,	pg.PigGenderTypeID
,	sm.Description
,	po.Description
,	CONVERT(CHAR(10),mk.StartDate,101)
,	mk.StartWgt
,	mk.StartQty
,	mk.CurrentInv
,	iv.CurrentInv
,	cp.Capacity
,	mk.DeadQty
,	mk.DaysOnFeed
,	mk.FeedEfficiency
,	mk.FeedInventory
,	CONVERT(CHAR(10),mk.FeedInvDate,101)
,	mk.FeedLbs
,	CONVERT(CHAR(10),mk.LastFeed,101)
,	CONVERT(CHAR(10),mk.LastSale,101)
,	mk.SaleQty
,	mk.SaleWgt
,	mk.TargetWgt
,	mk.CalcCurWgt
,	mk.CalcDeadWgt
,	mk.CalcOutWgt
,	mk.WgttoClose
,	CONVERT(CHAR(10),mk.TrCloseDate,101)
,	CONVERT(CHAR(10),mk.NextMarketDate,101)
,	CONVERT(CHAR(10),mk.ProjCloseOut,101)
,	mg.ContactName
,	sg.ContactName
,	CONVERT(CHAR(10),mk.Crtd_datetime,101)
,	CONVERT(CHAR(10),tp.MinTop,101)
,	tp.Wgt/tp.NoofMoves
,	CONVERT(CHAR(10),tp2.MinTop,101)
,	tp2.Wgt/tp2.NoofMoves
,	LastDelvRationID = IsNull((Select Max(InvtIdDel) 
			FROM cftFeedOrder -- using max invtid for case where more than one delivery on same day to group, since items are number sequentially it should work
			WHERE PigGroupID = mk.PigGroupID 
			AND DateDel = (Select Max(DateDel) FROM cftFeedOrder WITH (NOLOCK) WHERE PigGroupID = mk.PigGroupID AND Status<>'X')),'')
,	LastOrdRationID = IsNull((Select Max(InvtIdOrd) 
			FROM cftFeedOrder -- using max invtid for case where more than one delivery on same day to group, since items are number sequentially it should work
			WHERE PigGroupID = mk.PigGroupID 
			AND DateOrd = (Select Max(DateOrd) FROM cftFeedOrder WITH (NOLOCK) WHERE PigGroupID = mk.PigGroupID AND Status<>'X')),'')
,	act.AccountingEntityDescription
,	dbo.PGGetSource(pg.PigGroupID) AS Source
FROM  cftPigGroup pg WITH (NOLOCK)
LEFT OUTER JOIN cftPigPreMkt mk WITH (NOLOCK) ON pg.PigGroupID=mk.PigGroupID
LEFT JOIN cftPigSystem sm ON pg.PigSystemID=sm.PigSystemID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cfvSiteDetail sd ON pg.PigGroupID=sd.PigGroupID
LEFT JOIN cfv_PigGroup_Capacity cp ON pg.PigGroupID=cp.PigGroupID
LEFT JOIN cfvCurrentMktSvcMgr mg ON pg.SiteContactID=mg.sitecontactid
LEFT JOIN cfvCrtSvcMgrName sg ON pg.SiteContactID=sg.sitecontactid
LEFT JOIN cftPigProdPod po ON pg.PigProdPodID=po.PodId
LEFT JOIN cfv_PigGroup_1stTop tp WITH (NOLOCK) ON pg.PigGroupID = tp.PigGroupID
LEFT JOIN cfv_PigGroup_2ndTop tp2 WITH (NOLOCK) ON pg.PigGroupID = tp2.PigGroupID
LEFT JOIN CentralData.dbo.Site cds WITH (NOLOCK) ON sd.SiteID=cds.SiteID
LEFT JOIN CentralData.dbo.AccountingEntity act WITH (NOLOCK) ON cds.AccountingEntityID=act.AccountingEntityID
Where iv.CurrentInv>0 AND pg.PGStatusID<>'X' AND pg.PGStatusID<>'P'



 

