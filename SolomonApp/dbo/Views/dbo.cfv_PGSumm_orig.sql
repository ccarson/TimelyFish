
/****** Object:  View dbo.cfv_PGSumm    Script Date: 11/28/2005 2:44:28 PM *****
20120702 - Doran - Added additional join criteria "AND pg.ProjectID = fc.Project" to solve issue with XP.101.00 screen
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
CREATE VIEW [dbo].[cfv_PGSumm_orig]
AS
SELECT     pg.CpnyID AS Company, CAST(ph.PhaseDesc AS CHAR(30)) AS PhaseDesc, CAST(sd.FacilityType AS CHAR(30)) AS FacilityType, sd.SiteName, sd.SiteContactID, 
                      pst.Description AS Status, pg.PigGroupID AS GroupID, pj.pjt_entity_desc AS GroupDesc, pg.PigProdPodID AS PodID, pg.PigGenderTypeID AS Gender, st.StartDate, 
                      ROUND(st.TWgt / st.Qty, 2) AS StartWgt, st.Qty AS StartQty, iv.CurrentInv, dbo.PGGetCapacity(pg.PigGroupID) AS Capacity, fc.TotalFeed AS FeedLbs, sd.State, 
                      CAST(sd.SiteOwnershipDescription AS CHAR(30)) AS Ownership, gs.Qty AS SaleQty, gs.TWgt AS SaleWgt, gd.Qty AS DeadQty, CAST(ISNULL(fd.LastOrder, '1900-01-01') 
                      AS smallDatetime) AS LastFeed, CAST(ISNULL(gs.LastSale, '1900-01-01') AS smallDatetime) AS LastSale,
                          (SELECT     MIN(MovementDate) AS Expr1
                            FROM          dbo.vCFPigGroupPMMarkets
                            WHERE      (PigGroupID = pg.PigGroupID) AND (MovementDate >= GETDATE())
                            GROUP BY PigGroupID) AS NextMarketDate,
                          (SELECT     MIN(MovementDate) AS Expr1
                            FROM          dbo.vCFPigGroupPMMarkets AS vCFPigGroupPMMarkets_1
                            WHERE      (PigGroupID = pg.PigGroupID) AND (MarketSaleTypeID = '30')
                            GROUP BY PigGroupID, MarketSaleTypeID) AS ProjectedCloseOut, ISNULL(mg.MktMgrContactID, 'NA') AS MktMgr, ISNULL(sg.SvcMgrContactid, 'NA') AS SvcMgr, 
                      pg.tstamp
FROM         dbo.cftPigGroup AS pg INNER JOIN
                      dbo.PJPENT AS pj ON pg.TaskID = pj.pjt_entity INNER JOIN
                      dbo.cftPigProdPhase AS ph ON pg.PigProdPhaseID = ph.PigProdPhaseID LEFT OUTER JOIN
                      dbo.cfvCurrentInv AS iv ON pg.ProjectID = iv.Project AND pg.TaskID = iv.TaskID LEFT OUTER JOIN
                      dbo.cfv_GroupStart AS st ON pg.ProjectID = st.ProjectID AND pg.TaskID = st.TaskID AND st.Qty > 0 LEFT OUTER JOIN
                      dbo.cftPGStatus AS pst ON pg.PGStatusID = pst.PGStatusID LEFT OUTER JOIN
                      dbo.cfvSiteDetail AS sd ON pg.PigGroupID = sd.PigGroupID LEFT OUTER JOIN
                      dbo.cfv_GroupFeedChg AS fc ON pj.pjt_entity = fc.TaskID AND pg.ProjectID = fc.Project LEFT OUTER JOIN
                      dbo.cfv_GroupSales AS gs ON pj.pjt_entity = gs.TaskID LEFT OUTER JOIN
                      dbo.cfv_GroupDead AS gd ON pj.pjt_entity = gd.TaskID LEFT OUTER JOIN
                      dbo.cfv_GroupFeed AS fd ON pj.pjt_entity = fd.TaskID LEFT OUTER JOIN
                      dbo.cfvCurrentMktSvcMgr AS mg ON pg.SiteContactID = mg.sitecontactid LEFT OUTER JOIN
                      dbo.cfvCrtSvcMgrName AS sg ON pg.SiteContactID = sg.sitecontactid
WHERE     (iv.CurrentInv > 0) AND (pg.PGStatusID <> 'I') AND (pg.PGStatusID <> 'X') AND (pg.PGStatusID <> 'P')

