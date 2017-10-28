



create PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP_PIGFLOWS_20140211]
AS
BEGIN

UPDATE cft_PIG_FLOW_SOURCE_FARMS
SET PigFlowID =  case
      when pg.cf08 > 0 then pg.cf08
      else ISNULL(cft_PIG_FLOW.PigFlowID,0)
  end 
FROM   dbo.cft_PIG_FLOW_SOURCE_FARMS cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
      ON cft_PIG_FLOW_FARM.ContactID = cft_PIG_FLOW_SOURCE_FARMS.SourceContactID
LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
      ON cft_PIG_FLOW.PigFlowID = cft_PIG_FLOW_FARM.PigFlowID
      AND cft_PIG_FLOW_SOURCE_FARMS.StartDate BETWEEN cft_PIG_FLOW.PigFlowFromDate AND ISNULL(cft_PIG_FLOW.PigFlowToDate,'1/1/3000')
      AND cft_PIG_FLOW.PigFlowID <> 0
left join [$(SolomonApp)].dbo.cftpiggroup pg (nolock)
      on 'PG'+pg.piggroupid = cft_PIG_FLOW_SOURCE_FARMS.piggroupid

---- get the PigFlowID for the farms that make up the PigGroupID
----update cft_pig_flow_source_farms set pigflowid = NULL
--UPDATE cft_PIG_FLOW_SOURCE_FARMS
--SET PigFlowID = ISNULL(cft_PIG_FLOW.PigFlowID,0)
--FROM	 dbo.cft_PIG_FLOW_SOURCE_FARMS cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
--LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
--	ON cft_PIG_FLOW_FARM.ContactID = cft_PIG_FLOW_SOURCE_FARMS.SourceContactID
--LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
--	ON cft_PIG_FLOW.PigFlowID = cft_PIG_FLOW_FARM.PigFlowID
--	AND cft_PIG_FLOW_SOURCE_FARMS.StartDate BETWEEN cft_PIG_FLOW.PigFlowFromDate AND ISNULL(cft_PIG_FLOW.PigFlowToDate,'1/1/3000')
--	AND cft_PIG_FLOW.PigFlowID <> 0


UPDATE cft_PIG_GROUP_ROLLUP
SET PigFlowID =  case
      when pg.cf08 > 0 then pg.cf08
      else ISNULL(flow.PigFlowID,0)
  end 
FROM  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT DISTINCT PigGroupID TaskID, PigFlowID FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)) flow
      ON flow.TaskID = cft_PIG_GROUP_ROLLUP.TaskID
join (SELECT PigGroupID, COUNT(*) cnt FROM
            (SELECT DISTINCT cft_PIG_FLOW_SOURCE_FARMS.PigGroupID, cft_PIG_FLOW_SOURCE_FARMS.PigFlowID
            FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
            WHERE SourceContactID NOT IN (4001,4002)) x
            GROUP BY PigGroupID
            HAVING COUNT(*) = 1) pigcnt
      on pigcnt.PigGroupID = cft_PIG_GROUP_ROLLUP.TaskID
left join [$(SolomonApp)].dbo.cftpiggroup pg (nolock)
      on 'PG'+pg.piggroupid = flow.TaskID
WHERE flow.PigFlowID <> 0

----update the piggroups pigflowids
----update cft_pig_group_rollup set pigflowid = NULL
--UPDATE cft_PIG_GROUP_ROLLUP
--SET PigFlowID = flow.PigFlowID
--FROM  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
--JOIN (SELECT DISTINCT PigGroupID TaskID, PigFlowID FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)) flow
--	ON flow.TaskID = cft_PIG_GROUP_ROLLUP.TaskID
--join (SELECT PigGroupID, COUNT(*) cnt FROM
--		(SELECT DISTINCT cft_PIG_FLOW_SOURCE_FARMS.PigGroupID, cft_PIG_FLOW_SOURCE_FARMS.PigFlowID
--		FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
--		WHERE SourceContactID NOT IN (4001,4002)) x
--		GROUP BY PigGroupID
--		HAVING COUNT(*) = 1) pigcnt
--	on pigcnt.PigGroupID = cft_PIG_GROUP_ROLLUP.TaskID
--WHERE flow.PigFlowID <> 0
-- 2012-05-01 smr swapped out the code because it was not working as intended.
--FROM  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
--JOIN (SELECT DISTINCT PigGroupID TaskID, PigFlowID FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)) flow
--	ON flow.TaskID = cft_PIG_GROUP_ROLLUP.TaskID
--WHERE EXISTS (SELECT PigGroupID, COUNT(*) cnt FROM
--		(SELECT DISTINCT cft_PIG_FLOW_SOURCE_FARMS.PigGroupID, cft_PIG_FLOW_SOURCE_FARMS.PigFlowID
--		FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
--		WHERE SourceContactID NOT IN (4001,4002)) x
--		GROUP BY PigGroupID
--		HAVING COUNT(*) = 1)
--AND flow.PigFlowID <> 0


--these had multiple, set them to 'other'
UPDATE cft_PIG_GROUP_ROLLUP
SET PigFlowID = 0
WHERE PigFlowID IS NULL

--update the master piggroups pigflowids
--update cft_pig_master_group_rollup set pigflowid = NULL
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET PigFlowID = flow.PigFlowID
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT DISTINCT MasterGroup, PigFlowID FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)) flow
	ON flow.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup
join (SELECT MasterGroup, COUNT(distinct PigFlowID) PigFlowIDCt FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
	  GROUP BY MasterGroup HAVING COUNT(distinct PigFlowID) = 1) pigcnt
	on pigcnt.mastergroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup
-- 2012-05-01 smr swapped out the code because it was not working as intended.
--FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
--JOIN (SELECT DISTINCT MasterGroup, PigFlowID FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)) flow
--	ON flow.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup
--WHERE EXISTS (SELECT MasterGroup, COUNT(PigFlowID) PigFlowIDCt FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--		GROUP BY MasterGroup HAVING COUNT(PigFlowID) = 1)

--these had multiple, set them to 'other'
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET PigFlowID = 0
WHERE PigFlowID IS NULL


-- reportinggroupid assignment
update cft_PIG_GROUP_ROLLUP
set reportinggroupid = flow.reportinggroupID
FROM  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT pigflowid, reportinggroupid FROM [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW (NOLOCK)) flow
	ON flow.pigflowid = cft_PIG_GROUP_ROLLUP.pigflowid
	
update cft_PIG_MASTER_GROUP_ROLLUP
set reportinggroupid = flow.reportinggroupID
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT pigflowid, reportinggroupid FROM [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW (NOLOCK)) flow
	ON flow.pigflowid = cft_PIG_MASTER_GROUP_ROLLUP.pigflowid

END





