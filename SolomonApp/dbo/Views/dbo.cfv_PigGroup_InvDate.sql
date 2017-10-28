

CREATE  VIEW cfv_PigGroup_InvDate (Company, PhaseDesc, Pod, PigSystem, FacilityType, SiteName, Status, GroupID, GroupDesc, Gender,
				   StartDate, StartWgt, StartQty, CurrentInv, Capacity, TranDate, Qty, FeedLbs, State, Ownership, SaleQty, SaleWgt, DeadQty, LastFeed, LastSale, NextMarketDate, ProjectedCloseOut, MktMgr, SvcMgr)
AS
SELECT	pg.CpnyId AS Company, ph.PhaseDesc, pd.Description , ps.Description, sd.FacilityType, sd.SiteName, pst.Description As Status, pg.PigGroupID As GroupID, pj.pjt_entity_desc As GroupDesc, 
	pg.PigGenderTypeID As Gender, CONVERT(CHAR(10),st.StartDate,101)As StartDate, 
	CONVERT(NUMERIC(6,2),st.TWgt/st.Qty) As StartWgt, st.Qty As StartQty, iv.CurrentInv, cp.Capacity, it.TranDate As TranDate, it.Qty, fc.TotalFeed, sd.State, sd.SiteOwnershipDescription As Ownership, gs.Qty As SalesHead, gs.TWgt As SaleWgt, gd.Qty As Dead, 
fd.LastOrder, gs.LastSale,
            --added by Charity 3/17/2005
        NextMarketDate=(Select min(MovementDate) from vCFPigGroupPMMarkets 
                        where PigGroupID=pg.PigGroupID and MovementDate>=getDate()
                        group by PigGroupID),
        ProjectedCloseoutDate=(Select min(MovementDate) from vCFPigGroupPMMarkets 
                                where PigGroupID=pg.PigGroupID and MarketSaleTypeID='30'
                                group by PigGroupID, MarketSaleTypeID),
       mg.ContactName As MarketManager,
       sg.ContactName As SvcMgr
        -- end changes by Charity

FROM      cftPigGroup pg
JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
JOIN cftPigProdPhase ph on pg.PigProdPhaseID=ph.PigProdPhaseID
LEFT JOIN cftPigSystem ps ON pg.PigSystemID=ps.PigSystemID
LEFT JOIN cftPigProdPod pd ON pg.PigProdPodID=pd.PodID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID AND st.Qty>0
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cfvSiteDetail sd ON pg.PigGroupID=sd.PigGroupID
LEFT JOIN cfvPigGroupInv_Tran it ON pg.PigGroupID=it.PigGroupID
LEFT JOIN cfv_PigGroup_Capacity cp ON pg.PigGroupID=cp.PigGroupID
LEFT JOIN cfv_GroupFeedChg fc ON pj.pjt_entity=fc.TaskID
LEFT JOIN cfv_GroupSales gs ON pj.pjt_entity=gs.TaskID
LEFT JOIN cfv_GroupDead gd ON pj.pjt_entity=gd.TaskID
LEFT JOIN cfv_GroupFeed fd ON pj.pjt_entity=fd.TaskID
LEFT JOIN cfvCurrentMktSvcMgr mg ON pg.SiteContactID=mg.sitecontactid
LEFT JOIN cfvCrtSvcMgrName sg ON pg.SiteContactID=sg.sitecontactid
Where pg.PGStatusID<>'X'




 


