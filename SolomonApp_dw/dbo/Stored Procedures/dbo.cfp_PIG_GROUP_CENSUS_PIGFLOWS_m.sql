﻿



CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS_PIGFLOWS_m]
AS
BEGIN


--the following statement is currently taken care of as part of the pig group rollup job
--so commenting out for now
---- get the PigFlowID for the farms that make up the PigGroupID
--UPDATE cft_PIG_FLOW_SOURCE_FARMS
--SET PigFlowID = ISNULL(cft_PIG_FLOW.PigFlowID,0)
--FROM	 dbo.cft_PIG_FLOW_SOURCE_FARMS cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
--LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
--	ON cft_PIG_FLOW_FARM.ContactID = cft_PIG_FLOW_SOURCE_FARMS.SourceContactID
--LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
--	ON cft_PIG_FLOW.PigFlowID = cft_PIG_FLOW_FARM.PigFlowID
--	AND cft_PIG_FLOW_SOURCE_FARMS.StartDate BETWEEN cft_PIG_FLOW.PigFlowFromDate AND ISNULL(cft_PIG_FLOW.PigFlowToDate,'1/1/3000')
--	AND cft_PIG_FLOW.PigFlowID <> 0



--update the piggroups pigflowids
UPDATE c
SET PigFlowID = flow.PigFlowID
from dbo.cft_PIG_GROUP_CENSUS_m c
join (
	SELECT DISTINCT pg.taskID, max(case when pg.cf08 > 0 then pg.cf08 else s.PigFlowID end) PigFlowID
	FROM (select taskid,piggroupid, cf08 from [$(SolomonApp)].dbo.cftpiggroup (nolock) ) pg
	left join  dbo.cft_PIG_FLOW_SOURCE_FARMS s (NOLOCK)
		on pg.taskid = s.piggroupid and s.SourceContactID NOT IN (4001,4002) 
	group by pg.taskID
) flow
on right(rtrim(flow.taskID),5)=c.PigGroupID
where exists
	(SELECT x.taskID, COUNT(x.PigFlowID) cnt
	FROM (SELECT DISTINCT pg.taskID, case when pg.cf08 > 0 then pg.cf08 else s.PigFlowID end PigFlowID
		FROM (select taskid,piggroupid, cf08 from [$(SolomonApp)].dbo.cftpiggroup (nolock)  ) pg
		left join  dbo.cft_PIG_FLOW_SOURCE_FARMS s (NOLOCK)
		on pg.taskid = s.piggroupid and s.SourceContactID NOT IN (4001,4002) 
		) x
	where c.PigGroupID=right(rtrim(x.taskid),5)
	GROUP BY x.taskID
	HAVING COUNT(x.PigFlowID) = 1)
	
--UPDATE cft_PIG_GROUP_CENSUS
--SET PigFlowID = flow.PigFlowID
--from dbo.cft_PIG_GROUP_CENSUS c
--join (
--	SELECT DISTINCT s.PigGroupID, max(s.PigFlowID) PigFlowID
--	FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS s (NOLOCK)
--	WHERE SourceContactID NOT IN (4001,4002)
--	group by s.PigGroupID
--) flow
--on right(rtrim(flow.PigGroupID),5)=c.PigGroupID

--where exists
--	(SELECT x.PigGroupID, COUNT(x.PigFlowID) cnt
--	FROM (
--		SELECT DISTINCT s.PigGroupID, s.PigFlowID
--		FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS s (NOLOCK)
--		WHERE SourceContactID NOT IN (4001,4002)
--		) x
--	where c.PigGroupID=RIGHT(x.PigGroupID, 5)
--	GROUP BY x.PigGroupID
--	HAVING COUNT(x.PigFlowID) = 1)

--these had multiple, set them to 'other'
UPDATE cft_PIG_GROUP_CENSUS_m
SET PigFlowID = 0
WHERE PigFlowID IS NULL

-- 20131010 added update for reportinggroupid
UPDATE c
SET reportinggroupid  = flow.reportinggroupid
from dbo.cft_PIG_GROUP_CENSUS_m c
join [$(CFApp_PigManagement)].dbo.cft_pig_flow flow
	on flow.pigflowid = c.pigflowid


END





