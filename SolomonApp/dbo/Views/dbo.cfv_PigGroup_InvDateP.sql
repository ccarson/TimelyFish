
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
/****** Sue Matter:  Used on Georges' Inventory by Date Spreadsheet    Script Date: 11/19/2004 2:10:22 PM ******/

CREATE   VIEW cfv_PigGroup_InvDateP (Company, PhaseDesc, FacilityType, SiteName, Status, GroupID, GroupDesc, Gender,
				   StartDate, StartWgt, StartQty, CurrentInv, Capacity, FeedLbs, State, Ownership, SaleQty, SaleWgt, DeadQty, LastFeed, LastSale, NextMarketDate, ProjectedCloseOut, MktMgr, SvcMgr)
AS
SELECT	pj.pe_id05 AS Company, ph.PhaseDesc, sd.FacilityType, sd.SiteName, 
	pst.Description As Status, pg.PigGroupID As GroupID, pj.pjt_entity_desc As GroupDesc, 
	pg.PigGenderTypeID As Gender, CONVERT(CHAR(10),st.StartDate,101)As StartDate, 
	ROUND(st.TWgt/st.Qty,2) As StartWgt, st.Qty As StartQty, 
	iv.CurrentInv, cp.Capacity, fc.TotalFeed, 
	sd.State, sd.SiteOwnershipDescription As Ownership, gs.Qty As SalesHead, gs.TWgt As SaleWgt, gd.Qty As Dead, 
	fd.LastOrder, gs.LastSale,
        NextMarketDate=(Select min(MovementDate) from vCFPigGroupPMMarkets 
                        where PigGroupID=pg.PigGroupID and MovementDate>=getDate()
                        group by PigGroupID),
        ProjectedCloseoutDate=(Select min(MovementDate) from vCFPigGroupPMMarkets 
                                where PigGroupID=pg.PigGroupID and MarketSaleTypeID='30'
                                group by PigGroupID, MarketSaleTypeID),
       mg.ContactName As MarketManager,
       sg.ContactName As SvcMgr

FROM      cftPigGroup pg
JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
JOIN cftPigProdPhase ph on pg.PigProdPhaseID=ph.PigProdPhaseID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID AND st.Qty>0
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cfvSiteDetail sd ON pg.PigGroupID=sd.PigGroupID
LEFT JOIN cfv_PigGroup_Capacity cp ON pg.PigGroupID=cp.PigGroupID
LEFT JOIN cfv_GroupFeedChg fc ON pj.pjt_entity=fc.TaskID
LEFT JOIN cfv_GroupSales gs ON pj.pjt_entity=gs.TaskID
LEFT JOIN cfv_GroupDead gd ON pj.pjt_entity=gd.TaskID
LEFT JOIN cfv_GroupFeed fd ON pj.pjt_entity=fd.TaskID
LEFT JOIN cfvCurrentMktSvcMgr mg ON pg.SiteContactID=mg.sitecontactid
LEFT JOIN cfvCrtSvcMgrName sg ON pg.SiteContactID=sg.sitecontactid
Where iv.CurrentInv>0 AND pg.PGStatusID<>'I' AND pg.PGStatusID<>'X' AND pg.PGStatusID<>'P'






 