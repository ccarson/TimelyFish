--*************************************************************
--	Purpose:Pig Group Attributes
--		
--	Author: Charity Anderson
--	Date: 7/12/2005
--	Usage: EssBase 
--	Parms: None
--*************************************************************
--
-- UPDATES:
--	Date		Author		Description
--	1/12/09		mdawson		added in PGSrSvcManager
--
--*************************************************************
CREATE VIEW 
	dbo.vCFPigGroupAttributes

AS
SELECT     
	pg.CostFlag
  , pg.PGStatusID AS Status
  , 'LOC' + SUBSTRING(pg.ProjectID, 3, 4) AS LocNbr
  , c.ContactName AS Site
  , 'MG' + pg.CF03 AS MasterGroup
  , RTRIM(ms.ContactName) + ' ' + CONVERT(varchar(10), mg.StartDate, 101) AS MGAlias
  , pg.TaskID AS GroupNumber
  , RTRIM(c.ContactName)  + ' Barn ' + RTRIM(ISNULL(pg.BarnNbr, '')) + ' ' + RTRIM(ISNULL(pgr.RoomNbr, '')) + ' ' + CONVERT(varchar(10), ISNULL(gStart.TranDate, pg.ActStartDate), 101) AS GroupAlias
  , pg.CpnyID AS PigCo
  , g.Description AS Gender
  , CASE WHEN b.FacilityTypeID = '005' THEN 'WF ' + p.PhaseDesc ELSE p.PhaseDesc END AS Phase
  , s.Description AS System
  , pp.Description AS Pod
  , ctM.ContactName AS MGServManager
  , ISNULL((SELECT     TOP 1 CASE WHEN mg.PGStatusID = 'I' THEN dbo.GetMktManagerNm(mg.SiteContactID, pg.ActCloseDate, '1/1/1900') 
									ELSE dbo.GetMktManagerNm(mg.SiteContactID, pg.EstCloseDate, '1/1/1900') END AS Expr1
            FROM         dbo.cftPigGroup AS mg WITH (NOLOCK)
            WHERE     (CF03 = pg.CF03)
            ORDER BY ActCloseDate DESC, EstCloseDate DESC), 'No Market Manager') AS MGMktManager
  , ISNULL(CASE WHEN pg.PGStatusID = 'I' THEN dbo.GetSvcManagerNm(pg.SiteContactID, pg.ActCloseDate, '1/1/1900') 
                  ELSE dbo.GetSvcManagerNm(pg.SiteContactID, pg.EstCloseDate, '1/1/1900') END, 'No Service Manager') AS PGServManager
  , ISNULL((SELECT     TOP 1 Contact.ContactName
			FROM         [$(SolomonApp)].dbo.cftProdSvcMgr AS ProdSvcMgrAssignment 
			INNER JOIN   [$(SolomonApp)].dbo.cftContact AS Contact 
				ON 			Contact.ContactID = ProdSvcMgrAssignment.ProdSvcMgrContactID
            WHERE     (ProdSvcMgrAssignment.SiteContactID = pg.SiteContactID) 
						AND (ProdSvcMgrAssignment.EffectiveDate BETWEEN '1/1/1900' AND  COALESCE (CASE WHEN pg.ActCloseDate = '1/1/1900' THEN NULL ELSE pg.ActCloseDate END, 
																									CASE WHEN pg.EstCloseDate = '1/1/1900' THEN NULL ELSE pg.EstCloseDate END, 
																										GETDATE()))
            ORDER BY ProdSvcMgrAssignment.EffectiveDate DESC), 'No Sr Svc Manager') AS PGSrServManager
  , ISNULL(CASE WHEN pg.PGStatusID = 'I' THEN dbo.GetMktManagerNm(pg.SiteContactID, pg.ActCloseDate, '1/1/1900') 
                      ELSE dbo.GetMktManagerNm(pg.SiteContactID, pg.EstCloseDate, '1/1/1900') END, 'No Market Manager') AS PGMktManager
  , CASE WHEN EUPLSFP = 0 THEN '' ELSE 'Paylean' END AS Paylean
  , CASE WHEN pl.FirstPaylean > '1/1/1900' THEN DateDiff(d, pl.FirstPaylean, pg.ActCloseDate) ELSE 0 END AS DaysonPaylean
  , fm.ContactName AS FeedMill
  , CASE WHEN ActCloseDate = '1/1/1900' THEN RIGHT(pgEstW.PICYear, 2) + 'WK' + replicate('0', 2 - len(rtrim(CONVERT(char(2), rtrim(pgEstW.PICWeek))))) + rtrim(CONVERT(char(2), rtrim(pgEstW.PICWeek))) 
         ELSE RIGHT(pgActW.PICYear, 2) + 'WK' + replicate('0', 2 - len(rtrim(CONVERT(char(2), rtrim(pgActW.PICWeek))))) + rtrim(CONVERT(char(2), rtrim(pgActW.PICWeek))) END AS GroupWeek
  ,	(SELECT     TOP 1 RIGHT(ISNULL(wda.PICYear, wde.PICYear), 2) + 'WK' + CAST(ISNULL(REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), 
                                                   RTRIM(wda.PICWeek))))) + RTRIM(CONVERT(char(2), RTRIM(wda.PICWeek))), REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), 
                                                   RTRIM(wde.PICWeek))))) + RTRIM(CONVERT(char(2), RTRIM(wde.PICWeek)))) AS varchar(2)) AS Expr1
     FROM          dbo.cftPigGroup AS mg WITH (NOLOCK) 
	 LEFT OUTER JOIN dbo.cftWeekDefinition AS wde WITH (NOLOCK) ON mg.EstCloseDate BETWEEN wde.WeekOfDate AND wde.WeekEndDate 
	 LEFT OUTER JOIN dbo.cftWeekDefinition AS wda WITH (NOLOCK) ON mg.ActCloseDate BETWEEN wda.WeekOfDate AND wda.WeekEndDate
	 WHERE      (mg.CF03 = pg.CF03)
     ORDER BY mg.ActCloseDate DESC, mg.EstCloseDate DESC) AS MGWeek
  , gStart.TranDate AS PigStartDate
  , gEnd.TranDate AS PigEndDate
  , dbo.PGGetMaxCapacity(pg.PigGroupID) AS Capacity
  , pg.ActStartDate AS FinStartDate
  , mg.MCostFlag
  , mg.MPGStatusID
  , mg.MPigGenderTypeID
  , mg.MPigProdPodID
  , fdt.FeederTypeDescription AS BarnFeederType
  , flt.FloorTypeDescription AS BarnFloorType
FROM
	dbo.cftPigGroup AS pg 
LEFT OUTER JOIN
	dbo.vCFPigGroupRoomFilter AS rf 
		ON pg.PigGroupID = rf.PigGroupID AND rf.GroupCount = 1 
LEFT OUTER JOIN
	dbo.cftPigGroupRoom AS pgr 
		ON rf.PigGroupID = pgr.PigGroupID 
LEFT OUTER JOIN
	dbo.vCFPigGroupStart AS gStart 
		ON pg.PigGroupID = gStart.PigGroupID 
LEFT OUTER JOIN
	dbo.vCFPigGroupEnd AS gEnd 
		ON pg.PigGroupID = gEnd.PigGroupID 
LEFT OUTER JOIN
	dbo.cftBarn AS b 
		ON pg.SiteContactID = b.ContactID AND pg.BarnNbr = b.BarnNbr 
LEFT OUTER JOIN
	dbo.cftContact AS c 
		ON pg.SiteContactID = c.ContactID 
LEFT OUTER JOIN
	dbo.cftPigGenderType AS g 
		ON pg.PigGenderTypeID = g.PigGenderTypeID 
LEFT OUTER JOIN
	dbo.cftPigProdPhase AS p 
		ON pg.PigProdPhaseID = p.PigProdPhaseID 
LEFT OUTER JOIN
	dbo.cftPigSystem AS s 
		ON pg.PigSystemID = s.PigSystemID 
LEFT OUTER JOIN
	dbo.cftPigProdPod AS pp 
		ON pg.PigProdPodID = pp.PodID 
LEFT OUTER JOIN
	[$(CentralData)].dbo.BarnChar AS bc 
		ON bc.BarnID=cast(b.BarnID as int) 
LEFT OUTER JOIN
	[$(CFApp_Contact)].dbo.cft_BARN_FLOOR_TYPE flt 
		ON flt.FloorTypeID=bc.FloorType 
LEFT OUTER JOIN
	[$(CFApp_Contact)].dbo.cft_BARN_FEEDER_TYPE fdt 
		ON fdt.FeederTypeID=bc.FeederType 
LEFT OUTER JOIN
	dbo.cftWeekDefinition AS pgEstW 
		ON pg.EstCloseDate BETWEEN pgEstW.WeekOfDate AND pgEstW.WeekEndDate 
LEFT OUTER JOIN
	dbo.cftWeekDefinition AS pgActW 
		ON pg.ActCloseDate BETWEEN pgActW.WeekOfDate AND pgActW.WeekEndDate 
LEFT OUTER JOIN
	dbo.cftContact AS fm 
		ON pg.FeedMillContactID = fm.ContactID 
LEFT OUTER JOIN
    dbo.cfvMasterGroupActStart AS mg 
		ON pg.CF03 = mg.MGPigGroupID 
LEFT OUTER JOIN
	dbo.cftContact AS ms 
		ON mg.SiteContactID = ms.ContactID 
LEFT OUTER JOIN
	dbo.cftContact AS ctM 
		ON mg.MSvcMgrContactID = ctM.ContactID 
LEFT OUTER JOIN
	(	SELECT
			PigGroupId
		  , MIN(DateDel) AS FirstPaylean
        FROM          
			dbo.cftFeedOrder
		WHERE   
			InvtIdDel LIKE '075M%'
		GROUP BY PigGroupId
	) AS pl 
		ON pg.PigGroupID = pl.PigGroupId
WHERE     
	pg.PGStatusID <> 'X' ;
	

