



CREATE PROCEDURE [dbo].[cfp_cube_CloseOLD_eb]
				@LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: Prepare data for loading into a cube

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec [$(CFFDB)].dbo.cfp_PrintTs  'start 1'
exec 
exec [$(CFFDB)].dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-08-04  Dan Bryskin Put it in the template, performance optimizations

2015-02-23 ripley		dayson paylean changed, 55, 54 added
2015-08-14 BMD	Corrected Paylean quantity 
2015-09-02 BMD  Changed dates in  dbo.cft_ESSBASE_CLOSEOUT_DATESCAP_XREF and cft_ESSBASE_CLOSEOUT_GROUPDATA to Date data type instead of INT.  This caused the outline to change.
2015-11-05 BMD	Updated the "first use date" to ignore ration 75m feed deliveries prior to pig group start date.  (cft_ESSBASE_CLOSEOUT_CLOSEOUT_feed_ration_XREF step)
2015-12-22 BMD  Backed out changes from date data types back to INT due to issues in how cube data rolled up above level 0 data.
===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-------------------------------------------------------------------------------
-- Declare standard variables
-------------------------------------------------------------------------------
DECLARE @RowCount               INT
DECLARE @StepMsg                VARCHAR(255)
DECLARE @DatabaseName           NVARCHAR(128)
DECLARE @ProcessName            VARCHAR(50)
DECLARE @ProcessStatus          INT
DECLARE @StartDate              DATETIME
DECLARE @EndDate                DATETIME
DECLARE @RecordsProcessed       BIGINT
DECLARE @Comments               VARCHAR(2000)
DECLARE @Error                  INT
DECLARE @Criteria               VARCHAR(2000)


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
SET @DatabaseName       = db_name()
SET @ProcessName        = 'cfp_cube_Closeout_eb'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
--#####################################################################################################################
--Create temp table #pg to get the correct closed groups (FIN, NUR and WTF that are Closed and Costed) AND
--All other phases that are closed AND Close Date is 09WK01 or later.
--This is the base table for the exact number of PigGroups we will have in the Closeout cube.
--######################################################################################################################
create table #pg
(ProjectID char(16) not null
,PigGroupID char(10) not null
,TaskID char(32) not null
,CF03 char(10) not null
,CF08 int not null		-- added 20140401 sripley,  "cf08" to  fix pigflowid assignment, for multiplication farms
,ActStartDate smalldatetime not null
,ActCloseDate smalldatetime not null
,EstCloseDate smalldatetime not null
,BarnNbr char(6) not null
,CostFlag smallint not null
,PGStatusID char(2) not null
,SingleStock smallint not null
,SiteContactID char(6) not null
,Description char(30) not null
,FeedMillContactID char(6) not null
,PigGenderTypeID char(6) not null
,PigProdPhaseID char(3) not null
,PigProdPodID char(3) not null
,PigSystemID char(10) null)

INSERT INTO #pg
(ProjectID,PigGroupID,TaskID,CF03,cf08,ActStartDate,ActCloseDate,EstCloseDate,BarnNbr,CostFlag,PGStatusID,SingleStock,SiteContactID,Description,		-- added 20140401 sripley,  "cf08" to fix pigflowid assignment, for multiplication farms
FeedMillContactID,PigGenderTypeID,PigProdPhaseID,PigProdPodID,PigSystemID)
select
ProjectID,PigGroupID,TaskID,CF03,cf08,ActStartDate,ActCloseDate,EstCloseDate,BarnNbr,CostFlag,PGStatusID,SingleStock,SiteContactID,Description,		-- added 20140401 sripley,  "cf08" to  fix pigflowid assignment, for multiplication farms
FeedMillContactID,PigGenderTypeID,PigProdPhaseID,PigProdPodID,PigSystemID
from [$(SolomonApp)].dbo.cftPigGroup WITH (NOLOCK)
where
	PGStatusID='I'
	and ActCloseDate between '7/1/2004' and '12/31/2011' --This is to be used for CloseOld cube JLM 1/11/2017
	and (
		(CostFlag = 2 and PigProdPhaseID in ('FIN','NUR','WTF'))
	or
		(PigProdPhaseID not in ('FIN','NUR','WTF'))
		)

	
SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;

SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - #pg, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg	
-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load table  dbo.cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Now, we create cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF (table which stores the Attribute of GroupType for every PigGroup in the data set.
--It figures the GroupType based on the AvgTransferInWt, AvgTransferOutWt and AvgPigSaleWt for each appropriate Phase.
--#####################################################################################################################
-- Refresh the table for the GroupTypes in the Closed Groups
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF
--(TaskID char(10) not null
--,PGStatusID char(2) not null
--,Phase char(30) not null
--,Avg_TI float null
--,Avg_TO float null
--,Avg_PS float null
--,GroupType char(12) not null
--)
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF
(TaskID
,PGStatusID
,Phase
,Avg_TI
,Avg_TO
,Avg_PS
,GroupType
)

select *,
case when Phase = 'NUR'
and (Avg_TI between 7 and 25)
and (Avg_TO between 35 and 80)
and (Avg_PS is null)
then 'Typical'
when Phase = 'FIN'
and (Avg_TI between 35 and 80)
and (Avg_TO > 170 or Avg_TO is null)
and (Avg_PS between 210 and 340)
then 'Typical'
when Phase = 'WTF'
and (Avg_TI between 7 and 25)
and (Avg_TO > 170 or Avg_TO is null)
and (Avg_PS between 210 and 340)
then 'Typical'
else 'NonTypical'
end 'GroupType'
from (
select
rtrim(TaskID) 'TaskID',
PGStatusID,
Phase,
sum(TI_Wt)/sum(TI_Qty) 'Avg_TI',
sum(TO_Wt)/sum(TO_Qty) 'Avg_TO',
sum(PS_Wt)/sum(PS_Qty) 'Avg_PS'
from (
	select
	it.acct,
	it.PigGroupID,
	#pg.TaskID,
	#pg.PGStatusID,
	#pg.PigProdPhaseID 'Phase',
	case when it.TranTypeID='TI' then sum(it.TotalWgt) end 'TI_Wt',
	case when it.TranTypeID='TI' then sum(it.Qty) end 'TI_Qty',
	case when it.TranTypeID='TO' then sum(it.TotalWgt) end 'TO_Wt',
	case when it.TranTypeID='TO' then sum(it.Qty) end 'TO_Qty',
	case when it.TranTypeID='PS' then sum(it.TotalWgt) end 'PS_Wt',
	case when it.TranTypeID='PS' then sum(it.Qty) end 'PS_Qty'
	from #pg
	left join
	[$(SolomonApp)].dbo.cftPGInvTran it WITH (NOLOCK)
	on 'PG'+it.PigGroupID = #pg.TaskID
	where
	it.Reversal<>1
	and #pg.PGStatusID='I'
	and it.TranTypeID in ('TI','TO','PS')
	group by
	it.acct,
	it.PigGroupID,
	#pg.TaskID,
	#pg.PGStatusID,
	#pg.PigProdPhaseID,
	it.TranTypeID
) A
group by
TaskID,PGStatusID,Phase) B
order by
B.TaskID


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Load #NurFloor
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load #NurFloor'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create temp table #NurFloor to get all PigGroups and the FloorType of the preceding Nurseries that can be found.
--Rows of data that are FloorType 'NA' will be taken out in the cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF table, so that
--we avoid adding this attribute to PigGroups that do not have a preceding NurFloorType.
--#####################################################################################################################
create table #NurFloor
(TaskID char(32) not null,
NurFloorID char(50) null)
--drop table #NurFloor
insert into #NurFloor
select
rtrim(pg.TaskID) TaskID,rtrim([$(SolomonApp)].dbo.getFloorTypeList(pg.PigGroupID)) NurFloorID
from [$(SolomonApp)].dbo.cftPigGroup pg
where
pg.TaskID in (select TaskID from #pg)
--select * from #NurFloor


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - #NurFloor, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg



-------------------------------------------------------------------------------
-- load cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = ' load cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--We create cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF (table which stores the Attribute of NurFloorType for appropriate PigGroups.
--The CASE statement interprets the NurFloorID list into meaningful verbage, which becomes the members of the NurFloorType attribute
--dimension.  If any new NurFloorIDs are added to the system in [$(CentralData)].dbo.BarnChar, this code will need to be modified to capture
--those additions.
--#####################################################################################################################
--create table  dbo.cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF
--(TaskID char(32) not null,
--NurFloorID char(50) not null,
--NurFloorType char(80) not null)
truncate table  dbo.cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF
--drop table  dbo.cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF
insert into  dbo.cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF
(TaskID,
NurFloorID,
NurFloorType)

select
TaskID,NurFloorID,
case
when NurFloorID='1' then 'nf_Slat'
when NurFloorID='NA, 1' then 'nf_Slat'
when NurFloorID='2' then 'nf_Plastic'
when NurFloorID='NA, 2' then 'nf_Plastic'
when NurFloorID='3' then 'nf_Tribar'
when NurFloorID='NA, 3' then 'nf_Tribar'
when NurFloorID='502' then 'nf_PlasticTribar5050'
when NurFloorID='NA, 502' then 'nf_PlasticTribar5050'
when NurFloorID='1, 2' then 'nf_Slat,Plastic'
when NurFloorID='NA, 1, 2' then 'nf_Slat,Plastic'
when NurFloorID='1, 3' then 'nf_Slat,Tribar'
when NurFloorID='NA, 1, 3' then 'nf_Slat,Tribar'
when NurFloorID='1, 502' then 'nf_Slat,PlasticTribar5050'
when NurFloorID='NA, 1, 502' then 'nf_Slat,PlasticTribar5050'
when NurFloorID='2, 3' then 'nf_Plastic,Tribar'
when NurFloorID='NA, 2, 3' then 'nf_Plastic,Tribar'
when NurFloorID='3, 502' then 'nf_Tribar,PlasticTribar5050'
when NurFloorID='NA, 3, 502' then 'nf_Tribar,PlasticTribar5050'
when NurFloorID='2, 502' then 'nf_Plastic,PlasticTribar5050'
when NurFloorID='NA, 2, 502' then 'nf_Plastic,PlasticTribar5050'
when NurFloorID='1, 2, 3' then 'nf_Slat,Plastic,Tribar'
when NurFloorID='NA, 1, 2, 3' then 'nf_Slat,Plastic,Tribar'
when NurFloorID='1, 2, 3, 502' then 'nf_Slat,Plastic,Tribar,PlasticTribar5050'
when NurFloorID='NA, 1, 2, 3, 502' then 'nf_Slat,Plastic,Tribar,PlasticTribar5050'
else 'nf_NotKnown'
end NurFloorType
from #NurFloor
where NurFloorID is not null
and NurFloorID<>'NA'
--select * from  dbo.cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_PIG_GROUPS
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_PIG_GROUPS'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--We create cft_ESSBASE_CLOSEOUT_PIG_GROUPS (The main table that holds all pertinent information about PigGroups to be loaded
--into the Closeout cube. Any additions to Attributes to the "Group Number" dimension will need to be built into this table.
--This table IS used in the SQL interface load of the Closeout cube.
--#####################################################################################################################
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS
--(LocNbr char(16) not null
--,Site char(50) not null
--,TaskID char(32) not null
--,PGDescription char(60) not null
--,MasterGroup char(10) not null
--,ActCloseDate smalldatetime not null
--,ActStartDate smalldatetime not null
--,BarnNbr char(12) not null
--,PodDescription char(30) not null
--,PGStatusID char(2) not null
--,System char(30) not null
--,Gender char(30) not null
--,Phase char(30) not null
--,FeedMill char(50) not null
--,PGServManager char(50) not null
--,PGSrServManager char(50) not null
--,PigFlowDescription varchar(100) not null
--,ReportingGroupDescription varchar(100) not null
--,GroupType char(12) not null
--,NurFloorType char(80) not null
--,BarnFeederType char(50) not null)
-----------------------------------------------------
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS
(LocNbr
,Site
,TaskID
,PGDescription
,MasterGroup
,ActCloseDate
,ActStartDate
,BarnNbr
,PodDescription
,PGStatusID
,System
,Gender
,Phase
,FeedMill
,PGServManager
,PGSrServManager
,PigFlowDescription
,ReportingGroupDescription
,GroupType
,NurFloorType
,BarnFeederType
)

SELECT
	'LOC'+SUBSTRING(rtrim(#pg.ProjectID),3,4) LocNbr,
	rtrim(cs.ContactName) Site,
	#pg.TaskID TaskID,
	--#pg.Description PGDescription,
	rtrim(cs.ContactName) + ' Barn ' + RTRIM(ISNULL(#pg.BarnNbr, '')) + ' ' + RTRIM(ISNULL(pgr.RoomNbr, '')) + ' ' + CONVERT(varchar(10), ISNULL(gStart.TranDate, #pg.ActStartDate), 101) 
                      AS PGDescription,
	'MG'+rtrim(#pg.CF03) MasterGroup,
	#pg.ActCloseDate,
	#pg.ActStartDate,
	RTRIM(ISNULL(#pg.BarnNbr, '')) + ' ' +
	RTRIM(ISNULL(pgr.RoomNbr, '')) BarnNbr,
	ppp.Description PodDescription,
	#pg.PGStatusID,
	--rtrim(PS.Description) System,
	case when PS.Description IS null then 'NoSystem' else rtrim(PS.Description) end System,
	case when g.Description IS null then 'NoGender' else g.Description end Gender,
	CASE WHEN #pg.SingleStock <> 0 and FT.Description='WF'
		THEN 'SS WF '
	WHEN #pg.SingleStock = 0 and FT.Description='WF' and #pg.PigProdPhaseID='NUR'
		THEN 'WF '
	ELSE ''
	END + RTRIM(P.PhaseDesc) Phase,
	case when fm.ContactName IS null then 'NoFeedMill' else fm.ContactName end FeedMill, 
	ISNULL(CASE WHEN #pg.PGStatusID = 'I'
		THEN [$(SolomonApp)].dbo.GetSvcManagerNm(#pg.SiteContactID, #pg.ActCloseDate, '1/1/1900') 
		ELSE [$(SolomonApp)].dbo.GetSvcManagerNm(#pg.SiteContactID, #pg.EstCloseDate, '1/1/1900') 
	END, 'No Service Manager') AS PGServManager,

	'Sr_'+ISNULL(
		(SELECT TOP 1 Contact.ContactName
		FROM [$(CentralData)].dbo.ProdSvcMgrAssignment AS ProdSvcMgrAssignment WITH (NOLOCK)
		INNER JOIN [$(CentralData)].dbo.Contact AS Contact WITH (NOLOCK)
		ON Contact.ContactID = ProdSvcMgrAssignment.ProdSvcMgrContactID
		WHERE (ProdSvcMgrAssignment.SiteContactID = #pg.SiteContactID)
		AND (ProdSvcMgrAssignment.EffectiveDate BETWEEN '1/1/1900' AND
		COALESCE (CASE WHEN #pg.ActCloseDate = '1/1/1900' THEN NULL ELSE #pg.ActCloseDate END, 
		CASE WHEN #pg.EstCloseDate = '1/1/1900' THEN NULL ELSE #pg.EstCloseDate END, GETDATE()))
		ORDER BY ProdSvcMgrAssignment.EffectiveDate DESC)
	,'No Manager') AS PGSrServManager,
	------case when pf.PigFlowID IS null then 0 else pf.PigFlowID end PigFlowID,				
	------case when pf.PigFlowID IS null then 'PF_Other' else 'PF_'+rtrim(pf2.PigFlowDescription) end PigFlowDescription,		-- 20140401 sripley removed to fix pigflowid assignment
	case when isnull(pf.PigFlowID,0) = 0 and isnull(#pg.cf08,0) = 0 then  'PF_Other'
		 when pf.PigFlowID is null and #pg.cf08 is not null then  'PF_'+rtrim(pfcf08.PigFlowDescription) 
		 when pf.PigFlowID is not null						then  'PF_'+rtrim(isnull(pf2.PigFlowDescription,'Unknown'))
	end PigFlowDescription,
--  case when rg.ReportingGroupID IS null then 'RG_Other' else 'RG_'+rtrim(rg.Reporting_Group_Description) end ReportingGroupDescription,	-- 20140401 sripley removed to fix pigflowid assignment
	case when isnull(rg.ReportingGroupID,0) = 0 and isnull(rgcf08.ReportingGroupID,0) = 0	then  'RG_Other'
		 when rg.ReportingGroupID IS null and rgcf08.ReportingGroupID is not null then  'RG_'+rtrim(rgcf08.Reporting_Group_Description) 
		 when rg.ReportingGroupID is not null									  then  'RG_'+rtrim(rg.Reporting_Group_Description)
    end ReportingGroupDescription,
	case when gt.GroupType is null then 'NoGroupType' else gt.GroupType end GroupType,
	case when nft.NurFloorType is null then '' else nft.NurFloorType end NurFloorType,
	case when fdt.FeederTypeDescription is null then 'NoFeederType' else 'fdr_'+rtrim(fdt.FeederTypeDescription) end BarnFeederType

FROM #pg

LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupRoomFilter AS rf
	ON #pg.PigGroupID = rf.PigGroupID AND rf.GroupCount = 1
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroupRoom AS pgr WITH (NOLOCK)
	ON rf.PigGroupID = pgr.PigGroupID	
LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart WITH (NOLOCK)
	ON #pg.PigGroupID = gStart.PigGroupID	
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase P WITH (NOLOCK)
	ON P.PigProdPhaseID = #pg.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftBarn B WITH (NOLOCK)
	ON B.ContactID=#pg.SiteContactID and B.BarnNbr=#pg.BarnNbr
LEFT OUTER JOIN [$(CentralData)].dbo.BarnChar AS bc WITH (NOLOCK)
	ON bc.BarnID = CAST(B.BarnID AS int)
LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_BARN_FEEDER_TYPE AS fdt WITH (NOLOCK)
	ON fdt.FeederTypeID = bc.FeederType	
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftFacilityType FT WITH (NOLOCK)
	ON FT.FacilityTypeID=B.FacilityTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigSystem PS WITH (NOLOCK)
	on PS.PigSystemID = #pg.PigSystemID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGenderType AS g WITH (NOLOCK)
	ON #pg.PigGenderTypeID = g.PigGenderTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact AS fm WITH (NOLOCK)
	ON #pg.FeedMillContactID = fm.ContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact AS cs WITH (NOLOCK)
	ON #pg.SiteContactID = cs.ContactID	 
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPod ppp WITH (NOLOCK)
	ON ppp.PodID = #pg.PigProdPodID
LEFT OUTER JOIN (
	SELECT c.PigGroupID, min(c.PigFlowID) PigFlowID 
	FROM
	(
		SELECT DISTINCT PigGroupID,PigFlowID
		FROM  dbo.cft_PIG_FLOW_SOURCE_FARMS (NOLOCK)
		WHERE isnull(SourceContactID,0) NOT IN (4001,4002)
--		WHERE SourceContactID NOT IN (4001,4002)	20140401 sripley  replaced, was excluding data
		) c
		GROUP BY c.PigGroupID
		having COUNT(*) = 1
	) pf
	ON pf.PigGroupID = #pg.TaskID
LEFT OUTER JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf2 (NOLOCK)
	ON pf.PigFlowID = pf2.PigFlowID
LEFT OUTER JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP rg (NOLOCK)
	ON rg.ReportingGroupID = pf2.ReportingGroupID
LEFT OUTER JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pfcf08 (NOLOCK)
	ON #pg.cf08 = pfcf08.PigFlowID
LEFT OUTER JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP rgcf08 (NOLOCK)
	ON rgcf08.ReportingGroupID = pfcf08.ReportingGroupID
LEFT OUTER JOIN  dbo.cft_ESSBASE_CLOSEOUT_GROUPTYPE_XREF AS gt WITH (NOLOCK)
	ON #pg.TaskID = gt.TaskID
LEFT OUTER JOIN  dbo.cft_ESSBASE_CLOSEOUT_NURFLOORTYPE_XREF AS nft WITH (NOLOCK)
	ON #pg.TaskID = nft.TaskID		

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_PIG_GROUPS, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

	
-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF (table which stores the TI_Qty and TI_Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF
--(TaskID char(10) not null
--,TI_Qty int not null
--,TI_Wt float not null
--)

INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF
(TaskID
,TI_Qty
,TI_Wt
)
select
pg.TaskID,
isnull(sum(pit.Qty),0) TI_Qty,
isnull(sum(pit.TotalWgt),0) TI_Wt
--from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where pit.acct in ('PIG PURCHASE','PIG TRANSFER IN')
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_MOVEIN_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_MOVEIN_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_MOVEIN_XREF (table which stores the MI_Qty and MI_Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_MOVEIN_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_MOVEIN_XREF
--(TaskID char(10) not null
--,MI_Qty int not null
--,MI_Wt float not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_MOVEIN_XREF
(TaskID
,MI_Qty
,MI_Wt
)
select
pg.TaskID,
isnull(sum(pit.Qty),0) MI_Qty,
isnull(sum(pit.TotalWgt),0) MI_Wt
--from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where pit.acct='PIG MOVE IN'
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_MOVEIN_XREF


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_MOVEIN_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF (table which stores the MO_Qty and MO_Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF
--(TaskID char(10) not null
--,MO_Qty int not null
--,MO_Wt float not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF
(TaskID
,MO_Qty
,MO_Wt
)
select
pg.TaskID,
isnull(sum(pit.Qty),0) MO_Qty,
isnull(sum(pit.TotalWgt),0) MO_Wt
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where (pit.acct='PIG MOVE OUT'
and pit.TranSubTypeID not in ('FT'))
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_DEATH_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_DEATH_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_DEATH_XREF (table which stores the DeathQty for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_DEATH_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_DEATH_XREF
--(TaskID char(10) not null
--,DeathQty int not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_DEATH_XREF
(TaskID
,DeathQty
)
select
pg.TaskID,
sum(pit.Qty) DeathQty
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where pit.acct='PIG DEATH'
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_DEATH_XREF


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_DEATH_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF (table which stores the TO_Qty and TO_Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF
--(TaskID char(10) not null
--,TO_Qty int not null
--,TO_Wt float not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF
(TaskID
,TO_Qty
,TO_Wt
)
select
pg.TaskID,
isnull(sum(pit.Qty),0) TO_Qty,
isnull(sum(pit.TotalWgt),0) TO_Wt
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where (pit.acct = 'PIG TRANSFER OUT'
and pit.TranSubTypeID not in ('FT','WT','WC','FC'))
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_TAILENDER_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_TAILENDER_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_TAILENDER_XREF (table which stores the TE_Qty and TE_Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_TAILENDER_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_TAILENDER_XREF
--(TaskID char(10) not null
--,TE_Qty int not null
--,TE_Wt float not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_TAILENDER_XREF
(TaskID
,TE_Qty
,TE_Wt
)
select
pg.TaskID,
isnull(sum(pit.Qty),0) TE_Qty,
isnull(sum(pit.TotalWgt),0) TE_Wt
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where ((pit.acct = 'PIG TRANSFER OUT'
and pit.TranSubTypeID in ('FT','WT'))
or (pit.acct = 'PIG MOVE OUT'
and pit.TranSubTypeID in ('FT')))
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_TAILENDER_XREF


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_TAILENDER_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_PIGSALES_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_PIGSALES_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_PIGSALES_XREF (table which stores the various entities of PigSale
-- Qty and Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_PIGSALES_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_PIGSALES_XREF
--(TaskID char(10) not null
--,Closeout_Qty int null
--,Top_Qty int null
--,Cull_Qty int null
--,DP_Qty int null
--,DT_Qty int null
--,DY_Qty int null
--,CP_Qty int null
--,CD_Qty int null
--,Closeout_Wt float null
--,Top_Wt float null
--,Cull_Wt float null
--,DP_Wt float null
--,DT_Wt float null
--,DY_Wt float null
--,CP_Wt float null
--,CD_Wt float null
--)

INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_PIGSALES_XREF
(TaskID
,Closeout_Qty
,Top_Qty
,Cull_Qty
,DP_Qty
,DT_Qty
,DY_Qty
,CP_Qty
,CD_Qty
,Closeout_Wt
,Top_Wt
,Cull_Wt
,DP_Wt
,DT_Wt
,DY_Wt
,CP_Wt
,CD_Wt
)

select
	psd.TaskID,
	sum(psd.Closeout_Qty) Closeout_Qty,
	sum(psd.Top_Qty) Top_Qty,
	sum(psd.Cull_Qty) Cull_Qty,
	sum(psd.DP_Qty) DP_Qty,
	sum(psd.DT_Qty) DT_Qty,
	sum(psd.DY_Qty) DY_Qty,
	sum(psd.CP_Qty) CP_Qty,
	sum(psd.CD_Qty) CD_Qty,
	sum(psd.Closeout_Wt) Closeout_Wt,
	sum(psd.Top_Wt) Top_Wt,
	sum(psd.Cull_Wt) Cull_Wt,
	sum(psd.DP_Wt) DP_Wt,
	sum(psd.DT_Wt) DT_Wt,
	sum(psd.DY_Wt) DY_Wt,
	sum(psd.CP_Wt) CP_Wt,
	sum(psd.CD_Wt) CD_Wt	
	from
			(select
			pg.TaskID,
			case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID not in ('10')
			then psd.Qty end Closeout_Qty,
			case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID = '10'
			then psd.Qty end Top_Qty,
			case when (p.PrimaryPacker=1 and psd.DetailTypeID not in ('SS','DT','DY','CP','CD'))
			or (p.PrimaryPacker=0 and psd.DetailTypeID not in ('DT','DY','CP','CD'))
			then psd.Qty
			when (pit.acct = 'PIG TRANSFER OUT' and pit.TranSubTypeID in ('WC','FC'))
			then pit.Qty
			end Cull_Qty,
			case when (psd.DetailTypeID in ('DT','DY','CP','CD'))
			then psd.Qty end DP_Qty,
			case when psd.DetailTypeID = 'DT'
			then psd.Qty end DT_Qty,
			case when psd.DetailTypeID = 'DY'
			then psd.Qty end DY_Qty,
			case when psd.DetailTypeID = 'CP'
			then psd.Qty end CP_Qty,
			case when psd.DetailTypeID = 'CD'
			then psd.Qty end CD_Qty,
			
			case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID not in ('10')
			then psd.WgtLive end Closeout_Wt,
			case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID = '10'
			then psd.WgtLive end Top_Wt,
			case when (p.PrimaryPacker=1 and psd.DetailTypeID not in ('SS','DT','DY','CP','CD'))
			or (p.PrimaryPacker=0 and psd.DetailTypeID not in ('DT','DY','CP','CD'))
			then psd.WgtLive
			when (pit.acct = 'PIG TRANSFER OUT' and pit.TranSubTypeID in ('WC','FC'))
			then pit.TotalWgt
			end Cull_Wt,
			case when (psd.DetailTypeID in ('DT','DY','CP','CD'))
			then psd.WgtLive end DP_Wt,
			case when psd.DetailTypeID = 'DT'
			then psd.WgtLive end DT_Wt,
			case when psd.DetailTypeID = 'DY'
			then psd.WgtLive end DY_Wt,
			case when psd.DetailTypeID = 'CP'
			then psd.WgtLive end CP_Wt,
			case when psd.DetailTypeID = 'CD'
			then psd.WgtLive end CD_Wt			
			
			from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
			left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
			on 'PG'+pit.PigGroupID = pg.TaskID
			left join [$(SolomonApp)].dbo.cftPigSale as ps WITH (NOLOCK)
			on ps.BatNbr=pit.SourceBatNbr and ps.RefNbr=pit.SourceRefNbr
			left join [$(SolomonApp)].dbo.cftPM as pm WITH (NOLOCK)
			on pm.PMID=ps.PMLoadID
			left join [$(SolomonApp)].dbo.cftPacker as p WITH (NOLOCK)
			on p.ContactID=ps.PkrContactID
			left join [$(SolomonApp)].dbo.cftPSDetail as psd WITH (NOLOCK)
			on psd.BatNbr=ps.BatNbr and psd.RefNbr=ps.RefNbr
			where pit.acct in ('PIG SALE','PIG TRANSFER OUT')
			and pit.Reversal <> 1) psd
	group by psd.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_PIGSALES_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_PIGSALES_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF (table which stores the different accounts of Transport Death
--euthanized,deadb4grd and dot_td Qty Wt for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF
--(TaskID char(10) not null
--,euthanized_Qty int not null
--,deadb4grd_Qty int not null
--,dot_td_Qty int not null
--,euthanized_Wt float not null
--,deadb4grd_Wt float not null
--,dot_td_Wt float not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF
(TaskID
,euthanized_Qty
,deadb4grd_Qty
,dot_td_Qty
,euthanized_Wt
,deadb4grd_Wt
,dot_td_Wt
)

select sumit.TaskID,
isnull(sum(sumit.euthanized_Qty),0) euthanized_Qty,
isnull(sum(sumit.deadb4grd_Qty),0) deadb4grd_Qty,
isnull(sum(sumit.dot_td_Qty),0) dot_td_Qty,
isnull(sum(sumit.euthanized_Wt),0) euthanized_Wt,
isnull(sum(sumit.deadb4grd_Wt),0) deadb4grd_Wt,
isnull(sum(sumit.dot_td_Wt),0) dot_td_Wt

from
	(select
	'PG'+pit.PigGroupID TaskID,
	case when gd.piggradecattypeid = '03' THEN	sum(pit.Qty) end	euthanized_Qty,
	case when gd.piggradecattypeid = '04' THEN	sum(pit.Qty) end	deadb4grd_Qty,
	case when gd.piggradecattypeid = '05' THEN	sum(pit.Qty) end	dot_td_Qty,
	case when gd.piggradecattypeid = '03' THEN	sum(pit.TotalWgt) end	euthanized_Wt,
	case when gd.piggradecattypeid = '04' THEN	sum(pit.TotalWgt) end	deadb4grd_Wt,
	case when gd.piggradecattypeid = '05' THEN	sum(pit.TotalWgt) end	dot_td_Wt	
	
	from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	inner join [$(SolomonApp)].dbo.cftpmgradeqty gd (nolock)
		on gd.batchnbr = Pit.batnbr
		and gd.refnbr = Pit.sourcerefnbr
		and gd.linenbr = Pit.sourcelinenbr
	where pit.acct in ('transport death','PIG DEATH')
	and pit.Reversal <> 1
	group by
	pit.PigGroupID,gd.piggradecattypeid
	) sumit
	group by TaskID

--drop table  dbo.cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_INVADJ_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'cft_ESSBASE_CLOSEOUT_INVADJ_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_INVADJ_XREF (table which stores the IA_Qty "Inventory adjustment" for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_INVADJ_XREF
--create table  dbo.cft_ESSBASE_CLOSEOUT_INVADJ_XREF
--(TaskID char(10) not null
--,IA_Qty int not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_INVADJ_XREF
(TaskID
,IA_Qty
)
select
pg.TaskID,
sum(pit.Qty)*(-1) IA_Qty
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
where pit.acct='PIG INV ADJ'
and pit.Reversal <> 1
group by
pg.TaskID
--drop table  dbo.cft_ESSBASE_CLOSEOUT_INVADJ_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_INVADJ_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF (table which stores the LivePigDays for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF
--(TaskID char(10) not null
--,LivePigDays bigint not null
--,LivePayleanPigDays bigint null  --BMD:  Added Live PayLean Pig Days to support close out cube paylean days calculations
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF
(TaskID
,LivePigDays
)
select
pg.TaskID,
sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1) as LivePigDays
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
left join [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart
ON pg.TaskID = 'PG'+gStart.PigGroupID
WHERE
pit.acct <> 'pig death' and
pit.trantypeid <> 'ia' and
pit.Reversal <> 1
group by
pg.TaskID
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF (table which stores the DeadPigDays for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF
--(TaskID char(10) not null
--,DeadPigDays bigint not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF
(TaskID
,DeadPigDays
)
select
pg.TaskID,
sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1) as DeadPigDays
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
on 'PG'+pit.PigGroupID = pg.TaskID
left join [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart
ON pg.TaskID = 'PG'+gStart.PigGroupID
WHERE
pit.acct = 'pig death' and
pit.trantypeid <> 'ia' and
pit.Reversal <> 1
group by
pg.TaskID
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_CLOSEOUT_FEEDQTY_XREF (table which stores the FeedQty for every PigGroup in the data set)
--the PJPTDSUM table is the true source of this data for Closed Groups.
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF
--(TaskID char(10) not null
--,FeedQty float not null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF
(TaskID
,FeedQty
)
select
pg.TaskID,
sum(pjp.act_units) as FeedQty
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	ON pjp.pjt_entity = pg.TaskID
WHERE pjp.acct = 'PIG FEED ISSUE'
group by
pg.TaskID
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

---------------------------------------------------------------------------------
---- Load cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF    20150220 this section replaced by a combined 75/55/54 section
---------------------------------------------------------------------------------
--SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

----#####################################################################################################################
----Create cft_ESSBASE_CLOSEOUT_CLOSEOUT_PAYLEAN_XREF (table which stores the FeedQuantity_75 (Lbs of Ration 75),
----FirstPayleanDate and DaysOnPaylean for every PigGroup in the data set)
----#####################################################################################################################
--TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF
----CREATE table  dbo.cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF
----(TaskID char(10) not null
----,FeedQuantity_75 float not null
----,FirstPayleanDate int not null
----,DaysOnPaylean int not null
----)
--INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF
--(TaskID
--,FeedQuantity_75
--,FirstPayleanDate
--,DaysOnPaylean
--)

--Select pg.TaskID,
--f.FQ_75 as FeedQuantity_75,
--cast(f.FirstPLDate as Int)+2 FirstPayleanDate,
--CASE WHEN f.FirstPLDate > '1/1/1900' THEN DateDiff(d, f.FirstPLDate, 
--                      pg.ActCloseDate) ELSE 0 END AS DaysonPaylean
--from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
--left join (
--	Select
--	PigGroupID,
--	Min(DateDel) FirstPLDate,
--	Sum(QtyDel) FQ_75
--	From [$(SolomonApp)].dbo.cftFeedOrder with (nolock)
--	Where InvtIdDel like '%75%'
--	and Reversal=0
--	group by PigGroupID) f
--on 'PG'+rtrim(f.PigGroupId)=pg.TaskID
--where f.FQ_75 is not null
--order by pg.TaskID

----DROP table  dbo.cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF

--SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


--SET @RecordsProcessed = @RowCount
--SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF, '
--                + CAST(@RecordsProcessed AS VARCHAR)
--                + ' records processed'
--IF @LOG='Y' or @Error!=0
--	BEGIN
--	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
--                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
--	END               
--SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_feed_ration_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_CLOSEOUT_feed_ration_XREF (table which stores the Feed_qty (Lbs of Ration 54m & 55m & 75),
--FirstuseDate and DaysOnRation for every PigGroup in the data set)
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF
--drop table  dbo.cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF
--(TaskID char(10) not null
--,Feed_qty_75 float null
--,Feed_qty_55 float null
--,Feed_qty_54 float null
--,actclosedate datetime not null
--,FirstUseDate_75 datetime null
--,FirstUseDate_55 datetime null
--,FirstUseDate_54 datetime null
--,DaysOn75 int null
--,DaysOn55 int null
--,DaysOn54 int null
--)

Select pg.TaskID, pg.actclosedate, f.invtiddel,f.Feed_qty
,f.FirstuseDate
,CASE WHEN f.FirstuseDate > '1/1/1900' THEN DateDiff(d, f.FirstuseDate,pg.ActCloseDate) 
      ELSE 0 
 END AS DaysonRation
into #rations
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join (
	Select
	fo.PigGroupID, fo.invtiddel,
	Min(fo.DateDel) FirstuseDate,
	Sum(fo.QtyDel) feed_qty
	From [$(SolomonApp)].dbo.cftFeedOrder fo
	inner join [$(SolomonApp)].dbo.vCFPigGroupStart gs on fo.PigGroupId=gs.PigGroupID  -- BMD: Need pig group start date
	Where (fo.InvtIdDel like '%54m%' or fo.invtiddel like '%55m%' or fo.invtiddel like '%75%')
	  and fo.Reversal=0
	  and case when fo.InvtIdDel like '%75%' then fo.DateDel
	           else dateadd(d,1,gs.TranDate) End > gs.TranDate  
	           -- BMD: There were a few cases where the feed order was charged against a group - but the group wasn't even active.  
			   -- Per a conversation with Jacque H. this is a good approach to avoid that issue.  See Pig Group ID 47410 as an example of the problem.
	group by fo.PigGroupID, fo.invtiddel) f
on 'PG'+rtrim(f.PigGroupId)=pg.TaskID
where f.feed_qty is not null
order by pg.TaskID

select taskid, actclosedate
, case when invtiddel like '%75%' then feed_qty end feed_qty_75
, case when invtiddel like '%55%' then feed_qty end feed_qty_55
, case when invtiddel like '%54%' then feed_qty end feed_qty_54
, case when invtiddel like '%75%' then firstusedate end firstusedate_75
, case when invtiddel like '%55%' then firstusedate end firstusedate_55
, case when invtiddel like '%54%' then firstusedate end firstusedate_54
into #rations_bytaskdate
from #rations

insert into  dbo.cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF
select taskid, feed_qty_75, feed_qty_55, feed_qty_54
, actclosedate, firstusedate_75, firstusedate_55,firstusedate_54
, case when firstusedate_75 is not null and firstusedate_55 is not null and firstusedate_54 is not null
	     then      case when firstusedate_75 >= firstusedate_55 and firstusedate_55 >= firstusedate_54 then datediff(dd,firstusedate_75,actclosedate)
			  else case when firstusedate_75 >= firstusedate_55 and firstusedate_54 >= firstusedate_55 then datediff(dd,firstusedate_75,actclosedate) 
			  else case when firstusedate_55 >= firstusedate_54 and firstusedate_54 >= firstusedate_75 then datediff(dd,firstusedate_75,firstusedate_54)
			  else case when firstusedate_55 >= firstusedate_54 and firstusedate_75 >= firstusedate_54 then datediff(dd,firstusedate_75,firstusedate_55) 
			  else case when firstusedate_54 >= firstusedate_55 and firstusedate_55 >= firstusedate_75 then datediff(dd,firstusedate_75,firstusedate_55) 
			  else case when firstusedate_54 >= firstusedate_55 and firstusedate_75 >= firstusedate_55 then datediff(dd,firstusedate_75,firstusedate_54) 
			  end end end end end end
		when firstusedate_75 is not null and firstusedate_54 is not null and firstusedate_55 is null
			 then case when firstusedate_75 >= firstusedate_54  then datediff(dd,firstusedate_75,actclosedate)
			 else datediff(dd,firstusedate_75,firstusedate_54) end
		when firstusedate_75 is not null and firstusedate_54 is null and firstusedate_55 is not null
			 then case when firstusedate_75 >= firstusedate_55  then datediff(dd,firstusedate_75,actclosedate)
			 else datediff(dd,firstusedate_75,firstusedate_55) end
		when firstusedate_75 is not null and firstusedate_54 is null and firstusedate_55 is null
			 then datediff(dd,firstusedate_75,actclosedate) 
  end  dayson75
  
, case when firstusedate_75 is not null and firstusedate_55 is not null and firstusedate_54 is not null
	     then      case when firstusedate_75 >= firstusedate_55 and firstusedate_55 >= firstusedate_54 then datediff(dd,firstusedate_55,firstusedate_75)
			  else case when firstusedate_75 >= firstusedate_55 and firstusedate_54 >= firstusedate_55 then datediff(dd,firstusedate_55,firstusedate_54) 
			  else case when firstusedate_55 >= firstusedate_54 and firstusedate_54 >= firstusedate_75 then datediff(dd,firstusedate_55,actclosedate)
			  else case when firstusedate_55 >= firstusedate_54 and firstusedate_75 >= firstusedate_54 then datediff(dd,firstusedate_55,actclosedate) 
			  else case when firstusedate_54 >= firstusedate_55 and firstusedate_55 >= firstusedate_75 then datediff(dd,firstusedate_55,firstusedate_54) 
			  else case when firstusedate_54 >= firstusedate_55 and firstusedate_75 >= firstusedate_55 then datediff(dd,firstusedate_55,firstusedate_75) 
			  end end end end end end
	   when firstusedate_55 is not null and firstusedate_75 is null and firstusedate_54 is not null
		 then case when firstusedate_55 >= firstusedate_54  then datediff(dd,firstusedate_55,actclosedate)
		 else datediff(dd,firstusedate_55,firstusedate_54) end
	   when firstusedate_55 is not null and firstusedate_75 is not null and firstusedate_54 is null
		 then case when firstusedate_55 >= firstusedate_75  then datediff(dd,firstusedate_55,actclosedate)
		 else datediff(dd,firstusedate_55,firstusedate_75) end
	   when firstusedate_55 is not null and firstusedate_54 is null and firstusedate_75 is null
		 then datediff(dd,firstusedate_55,actclosedate) 
  end  dayson55
  
, case when firstusedate_75 is not null and firstusedate_55 is not null and firstusedate_54 is not null
	     then      case when firstusedate_75 >= firstusedate_55 and firstusedate_55 >= firstusedate_54 then datediff(dd,firstusedate_54,firstusedate_55)
			  else case when firstusedate_75 >= firstusedate_55 and firstusedate_54 >= firstusedate_55 then datediff(dd,firstusedate_54,firstusedate_75) 
			  else case when firstusedate_55 >= firstusedate_54 and firstusedate_54 >= firstusedate_75 then datediff(dd,firstusedate_54,firstusedate_55)
			  else case when firstusedate_55 >= firstusedate_54 and firstusedate_75 >= firstusedate_54 then datediff(dd,firstusedate_54,firstusedate_75) 
			  else case when firstusedate_54 >= firstusedate_55 and firstusedate_55 >= firstusedate_75 then datediff(dd,firstusedate_54,actclosedate) 
			  else case when firstusedate_54 >= firstusedate_55 and firstusedate_75 >= firstusedate_55 then datediff(dd,firstusedate_54,actclosedate) 
			  end end end end end end

	   when firstusedate_54 is not null and firstusedate_75 is not null and firstusedate_55 is null
		 then case when firstusedate_54 >= firstusedate_75  then datediff(dd,firstusedate_54,actclosedate)
		 else datediff(dd,firstusedate_54,firstusedate_75) end
	   when firstusedate_54 is not null and firstusedate_75 is   null and firstusedate_55 is not null
		 then case when firstusedate_54 >= firstusedate_55  then datediff(dd,firstusedate_54,actclosedate)
		 else datediff(dd,firstusedate_54,firstusedate_55) end
	   when firstusedate_54 is not null and firstusedate_75 is null and firstusedate_55 is null
		 then datediff(dd,firstusedate_54,actclosedate) 
  end  dayson54
from 
(select taskid, actclosedate
, min(feed_qty_75) feed_qty_75
, min(firstusedate_75) firstusedate_75
, min(feed_qty_55) feed_qty_55
, min(firstusedate_55) firstusedate_55
, min(feed_qty_54) feed_qty_54
, min(firstusedate_54) firstusedate_54
from #rations_bytaskdate
group by taskid, actclosedate) xx
where 1=1 
--and firstusedate_75 is not null and firstusedate_55 is not null and firstusedate_54 is not null-- checked	
--and firstusedate_75 is not null and firstusedate_55 is not null and firstusedate_54 is null-- checked	
--and firstusedate_75 is not null and firstusedate_55 is     null and firstusedate_54 is not null	-- checked
--and firstusedate_75 is not null and firstusedate_55 is null and firstusedate_54 is null	-- checked

--and firstusedate_75 is null and firstusedate_55 is not null and firstusedate_54 is not null	-- checked
--and firstusedate_75 is null and firstusedate_55 is not null and firstusedate_54 is null	-- checked

--and firstusedate_75 is null and firstusedate_55 is  null and firstusedate_54 is not null	-- checked

--and actclosedate < firstusedate_75  -- (28551, 29495, 50113)
--and actclosedate < firstusedate_55  -- (25991,28202)
--and actclosedate < firstusedate_54  -- none
order by taskid


--select * from  dbo.cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Update cft_ESSBASE_CLOSEOUT_LivePigDays_Xref with LivePayLeanDays
-------------------------------------------------------------------------------
SET  @StepMsg = 'Update cft_ESSBASE_CLOSEOUT_LivePigDays_Xref with LivePayLeanDays'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
-- Update  dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF with live paylean days for groups with paylean usage
--#####################################################################################################################
-- BMD -- Calculate pay lean days for each pig group that was fed paylean (ration 75) -- 
Update LP
  set LP.LivePayleanPigDays=pd.LivePayLeanDays
from  dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF LP
Inner Join (
			select
			pg.TaskID,
			sum((datediff(d, frx.FirstUseDate_75, pit.Trandate)-2)* Pit.qty * pit.InvEffect * -1) as LivePayLeanDays
			from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
			left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK) on 'PG'+pit.PigGroupID = pg.TaskID
			Inner Join  dbo.cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF frx on frx.TaskID=pg.TaskID -- We only want pig groups that were on PayLean
						and frx.FirstUseDate_75 is not null
			WHERE pit.acct <> 'pig death'
			  and pit.trantypeid <> 'ia' 
			  and pit.Reversal <> 1
			  and pit.TranDate >= dateadd(d,2,frx.FirstUseDate_75) -- Only pig group transactions after paylean was first fed
			group by pg.TaskID) PD on PD.TaskID=LP.TaskID



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Updated cft_ESSBASE_CLOSEOUT_LivePigDays_Xref with LivePayLeanDays, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_DATESCAP_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_DATESCAP_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_CLOSEOUT_DATESCAP_XREF (table which stores the FiscalStartDate, PigStartDate, PigEndDate
--and HdCapacity for every PigGroup in the data set)
-- 2015/09/02: BMD: Changed dates to date datatype instead of INT
-- 2015/12/22: BMD: Changed data types back to INT from Date
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_DATESCAP_XREF
--CREATE table  dbo.cft_ESSBASE_CLOSEOUT_DATESCAP_XREF
--(TaskID char(10) not null
--,FiscalStartDate int null
--,PigStartDate int null
--,PigEndDate int null
--,HdCapacity int null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_DATESCAP_XREF
(TaskID
,FiscalStartDate
,PigStartDate
,PigEndDate
,HdCapacity
)
select pg.TaskID,
cast(pg.ActStartDate as int)+2 FiscalStartDate,
cast(gStart.TranDate as int)+2 as PigStartDate,
cast(gEnd.TranDate as int)+2 as PigEndDate,
--pg.ActStartDate as FiscalStartDate,
--gStart.TranDate as PigStartDate,
--gEnd.TranDate as PigEndDate,
[$(SolomonApp)].dbo.PGGetMaxCapacity(pg2.PigGroupID) AS HdCapacity
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigGroup AS pg2 WITH (NOLOCK)
on pg2.TaskID=pg.TaskID
left join [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart 
ON 'PG'+rtrim(gStart.PigGroupID) = pg.TaskID 
left join [$(SolomonApp)].dbo.vCFPigGroupEnd AS gEnd
on 'PG'+rtrim(gEnd.PigGroupID) = pg.TaskID 
order by pg.TaskID
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_DATESCAP_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_DATESCAP_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_GROUPDATA
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_GROUPDATA'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_CLOSEOUT_GROUPDATA (The main data table for loading the Closeout cube)
--It joins to all of the "_XREF" tables created to quickly build one single data table.
--If new accounts are to be added to this cube, an additional _XREF table can be built, and then joined to this specific part.
--This table IS used in the SQL interface load of the Closeout cube.
-- 2015/09/02: BMD: Changed FiscalStartDate, PigStartDate, PigEndDate, FirstPayLeanDate, First55Date, and First54Date from BigInt to Date datatype
-- 2015/11/07: BMD: Added in LivePayLeanDays from the cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF table.  Added "LivePayLeanPigDays" to cube outline.
-- 2015/12/22: BMD: Changed dates back to int data type.
--#####################################################################################################################
--DROP table  dbo.cft_ESSBASE_CLOSEOUT_GROUPDATA
TRUNCATE table  dbo.cft_ESSBASE_CLOSEOUT_GROUPDATA
--create table  dbo.cft_ESSBASE_CLOSEOUT_GROUPDATA
--(GroupNumber char(32) not null
--,Phase char(30) not null
--,ServiceManager char(50) not null
--,Pod char(30) not null
--,System char(30) not null
--,FiscalYear char(12) not null
--,PICQuarter char(12) not null
--,FYPeriod char(12) not null
--,Time char(12) not null
--,Scenario char(30) not null
--,TI_Qty int null
--,MI_Qty int null
--,MO_Qty int null
--,Death_Qty int null
--,TO_Qty int null
--,TE_Qty int null
--,Closeout_Qty int null
--,Top_Qty int null
--,Cull_Qty int null
--,DP_Qty int null
--,DT_Qty int null
--,DY_Qty int null
--,CD_Qty int null
--,CP_Qty int null
--,euthanized_Qty int null
--,deadb4grd_Qty int null
--,dot_td_Qty int null
--,IA_Qty int null
--,TI_Wt numeric null
--,MI_Wt numeric null
--,MO_Wt numeric null
--,TO_Wt numeric null
--,TE_Wt numeric null
--,Closeout_Wt numeric null
--,Top_Wt numeric null
--,Cull_Wt numeric null
--,DP_Wt numeric null
--,DT_Wt numeric null
--,DY_Wt numeric null
--,CD_Wt numeric null
--,CP_Wt numeric null
--,euthanized_Wt numeric null
--,deadb4grd_Wt numeric null
--,dot_td_Wt numeric null
--,LivePigDays bigint null
--,DeadPigDays bigint null
--,FeedQty numeric null
--,FeedQuantity_75 numeric null
--,FirstPayleanDate int null
--,DaysOnPaylean bigint null
--,LivePayleanPigDays bigint null
--,FiscalStartDate int null
--,PigStartDate int null
--,PigEndDate int null
--,HdCapacity int null
--,FeedQuantity_55 numeric null
--,First55Date int null
--,DaysOn55 bigint null
--,FeedQuantity_54 numeric null
--,First54Date int null
--,DaysOn54 bigint null
--)
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_GROUPDATA
(GroupNumber
,Phase
,ServiceManager
,Pod
,System
,FiscalYear
,PICQuarter
,FYPeriod
,Time
,Scenario
,TI_Qty
,MI_Qty
,MO_Qty
,Death_Qty
,TO_Qty
,TE_Qty
,Closeout_Qty
,Top_Qty
,Cull_Qty
,DP_Qty
,DT_Qty
,DY_Qty
,CD_Qty
,CP_Qty
,euthanized_Qty
,deadb4grd_Qty
,dot_td_Qty
,IA_Qty
,TI_Wt
,MI_Wt
,MO_Wt
,TO_Wt
,TE_Wt
,Closeout_Wt
,Top_Wt 
,Cull_Wt
,DP_Wt
,DT_Wt
,DY_Wt
,CD_Wt
,CP_Wt
,euthanized_Wt
,deadb4grd_Wt
,dot_td_Wt
,LivePigDays
,DeadPigDays
,FeedQty
,FeedQuantity_75
,FirstPayleanDate
,DaysOnPaylean
,LivePayleanPigDays
,FiscalStartDate
,PigStartDate
,PigEndDate
,HdCapacity
,FeedQuantity_55
,First55Date
,DaysOn55
,FeedQuantity_54
,First54Date
,DaysOn54
)
--#####################################################################################################################
--This is the code that actually puts all of the data into the cft_ESSBASE_CLOSEOUT_GROUPDATA table
--#####################################################################################################################
select
pg.TaskID as 'Group Number',pg.Phase,pg.PGServManager as 'Service Manager',pg.PodDescription as Pod,pg.System,
'FY'+cast(dd.FiscalYear as CHAR) FiscalYear,dd.PICQuarter,dd.FYPeriod,
dd.PICYear_Week as Time,'Actual' as Scenario,
itti.TI_Qty TI_Qty,
itmi.MI_Qty MI_Qty,
itmo.MO_Qty MO_Qty,
itpd.DeathQty DeathQty,
itto.TO_Qty TO_Qty,
itte.TE_Qty TE_Qty,
ps.Closeout_Qty Closeout_Qty,
ps.Top_Qty Top_Qty,
ps.Cull_Qty Cull_Qty,
ps.DP_Qty DP_Qty,
ps.DT_Qty DT_Qty,
ps.DY_Qty DY_Qty,
ps.CD_Qty CD_Qty,
ps.CP_Qty CP_Qty,
ittd.euthanized_Qty euthanized_Qty,
ittd.deadb4grd_Qty deadb4grd_Qty,
ittd.dot_td_Qty dot_td_Qty,
itia.IA_Qty IA_Qty,
itti.TI_Wt TI_Wt,
itmi.MI_Wt MI_Wt,
itmo.MO_Wt MO_Wt,
itto.TO_Wt TO_Wt,
itte.TE_Wt TE_Wt,
ps.Closeout_Wt Closeout_Wt,
ps.Top_Wt Top_Wt,
ps.Cull_Wt Cull_Wt,
ps.DP_Wt DP_Wt,
ps.DT_Wt DT_Wt,
ps.DY_Wt DY_Wt,
ps.CD_Wt CD_Wt,
ps.CP_Wt CP_Wt,
ittd.euthanized_Wt euthanized_Wt,
ittd.deadb4grd_Wt deadb4grd_Wt,
ittd.dot_td_Wt dot_td_Wt,
lpd.LivePigDays LivePigDays,
dpd.DeadPigDays DeadPigDays,
fq.FeedQty FeedQty,
pl.Feed_qty_75 as FeedQuantity_75,
	-- JLM: Add 2 to the dates cast as integers, so that retrieval of the dates match to the dates in MS Excel (same method as FiscalStartDate,PigStartDate
	-- and PigEndDate found in cft_ESSBASE_CLOSEOUT_DATESCAP_XREF code area below.  01/04/2016
cast(pl.FirstUseDate_75 as INT)+2 as FirstPayleanDate,
pl.DaysOn75 as DaysOnPaylean,
lpd.LivePayleanPigDays as LivePayleanPigDays,
cast(dc.FiscalStartDate as INT) as FiscalStartDate,
cast(dc.PigStartDate as INT) as PigStartDate,
cast(dc.PigEndDate as INT) as PigEndDate,
dc.HdCapacity,
pl.Feed_qty_55 as FeedQuantity_55,
cast(pl.FirstUseDate_55 as INT)+2 as First55Date,
pl.dayson55 as DaysOn55,
pl.Feed_qty_54 as FeedQuantity_54,
cast(pl.FirstUseDate_54 as INT)+2 as First54Date,
pl.dayson54  as DaysOn54

from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS AS pg WITH (NOLOCK)
left join
	 dbo.cft_ESSBASE_CLOSEOUT_DEATH_XREF as itpd WITH (NOLOCK)
	on itpd.TaskID = pg.TaskID
left join
	 dbo.cft_ESSBASE_CLOSEOUT_MOVEIN_XREF as itmi WITH (NOLOCK)
	on itmi.TaskID = pg.TaskID
left join
	 dbo.cft_ESSBASE_CLOSEOUT_MOVEOUT_XREF as itmo WITH (NOLOCK)
	on itmo.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_TRANSFERIN_XREF as itti WITH (NOLOCK)
		on itti.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_TRANSFEROUT_XREF as itto WITH (NOLOCK)
		on itto.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_TAILENDER_XREF as itte WITH (NOLOCK)
		on itte.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_PIGSALES_XREF as ps WITH (NOLOCK)
		on ps.TaskID = pg.TaskID						
left join
		 dbo.cft_ESSBASE_CLOSEOUT_TRANDEATH_XREF as ittd WITH (NOLOCK)
		on ittd.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_INVADJ_XREF as itia WITH (NOLOCK) 
		on itia.TaskID = pg.TaskID
left join 		
		[$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo as dd WITH (NOLOCK)
		on dd.DayDate = pg.ActCloseDate
left join
		 dbo.cft_ESSBASE_CLOSEOUT_LIVEPIGDAYS_XREF as lpd WITH (NOLOCK) 
		on lpd.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_DEADPIGDAYS_XREF as dpd WITH (NOLOCK) 
		on dpd.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_FEEDQTY_XREF as fq WITH (NOLOCK)
		on fq.TaskID = pg.TaskID
--left join	-- replaced 20150220 with a combined 75/55/54 section
--		 dbo.cft_ESSBASE_CLOSEOUT_PAYLEAN_XREF as pl WITH (NOLOCK)
--		on pl.TaskID = pg.TaskID		
left join
		 dbo.cft_ESSBASE_CLOSEOUT_DATESCAP_XREF as dc WITH (NOLOCK)
		on dc.TaskID = pg.TaskID
left join
		 dbo.cft_ESSBASE_CLOSEOUT_FEED_RAtion_XREF as pl WITH (NOLOCK)
		on pl.TaskID = pg.TaskID 


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_GROUPDATA, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_COSTS
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_COSTS'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--We create cft_ESSBASE_CLOSEOUT_COSTS (The table that holds all of the PIG COST data for PigGroups to be loaded
--into the Closeout cube. PJPTDSUM is the true source of all PIG COST data.
--This table IS used in the SQL interface load of the Closeout cube.
--#####################################################################################################################
--drop table  dbo.cft_ESSBASE_CLOSEOUT_COSTS
truncate table  dbo.cft_ESSBASE_CLOSEOUT_COSTS
--create table  dbo.cft_ESSBASE_CLOSEOUT_COSTS
--(GroupNumber char(32) not null
--,Phase char(30) not null
--,ServiceManager char(50) not null
--,Pod char(30) not null
--,System char(30) not null
--,Time char(10) not null
--,Scenario char(20) not null
--,Account char(16) not null
--,Value float not null
--)
insert into  dbo.cft_ESSBASE_CLOSEOUT_COSTS
(GroupNumber
,Phase
,ServiceManager
,Pod
,System
,Time
,Scenario
,Account
,Value
)
select
pg.TaskID as 'Group Number',pg.Phase,pg.PGServManager as 'Service Manager',pg.PodDescription as Pod,pg.System,dd.PICYear_Week as Time,'Actual' as Scenario,
pjp.acct as Account, 
sum(pjp.act_amount) as Value
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.PJPTDSUM pjp
on pjp.pjt_entity = PG.TaskID
left join 		
		[$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo as dd WITH (NOLOCK)
		on dd.DayDate = pg.ActCloseDate
where pjp.acct is not null		
group by pg.TaskID,pg.Phase,pg.PGServManager,pg.PodDescription,pg.System,dd.PICYear_Week,
pjp.acct
order by pg.TaskID,pjp.acct
--select * from  dbo.cft_ESSBASE_CLOSEOUT_COSTS

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_COSTS, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Create cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF (table which stores Module(Source of data), BatNbr, RefNbr, TaskID, RationType and Qty
--for every PigGroup in the data set).
--This can be used to look up how the Feed Detail accounts are derived if there are any questions on the Quantities found in the cube.
--Sources are APTran, INTran, and pjchargd tables.  There is also an adjustment type of AdjToPJ which takes the sum of the Quantities
--from the APTran, INTran, and pjchargd sources and puts any remaining differences (when tying out to the PJPTD FeedQty value) into
--the Unknown_FeedQty account.
--This first INSERT part uses the APTran, INTran, and pjchargd sources.
--#####################################################################################################################
--DROP TABLE  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
--CREATE TABLE  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
--(Module char(16) not null
--,BatNbr char(10) not null 
--,RefNbr char(15) not null
--,TaskID char(32) not null
--,Account char(32) null
--,Value numeric null)
TRUNCATE TABLE  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
(Module
,BatNbr
,RefNbr
,TaskID
,Account
,Value)
SELECT     'APTran' Module,tr.BatNbr,tr.RefNbr,pg.TaskID, rtrim(i.User2) + '_FeedQty' AS Account,(tr.Qty) AS Value
FROM          dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS pg 
      join 
      (select BatNbr,RefNbr,TaskID,InvtID,Qty from [$(SolomonApp)].dbo.APTran
      where Acct='45500' and Rlsed='1' and InvtID > '' and Qty is not null)       
      tr ON tr.TaskID = pg.TaskID and tr.InvtID > ''
      left JOIN 
      (select InvtID,User2 from [$(SolomonApp)].dbo.Inventory where ClassID='RATION')      
      i ON tr.InvtID = i.InvtID
UNION ALL
SELECT     'INTran' Module,tr.BatNbr,tr.RefNbr,pg.TaskID, rtrim(i.User2) + '_FeedQty' AS Account, (tr.Qty * tr.InvtMult * - 1) AS Value
FROM          dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS pg
      join 
	(select BatNbr,RefNbr,TaskID,InvtId,Qty,InvtMult from [$(SolomonApp)].dbo.INTran
	where acct='45500' and Rlsed='1'
	and TranType IN ('II', 'RI', 'RC', 'IN')
	and Qty is not null)
	tr ON tr.TaskID = pg.TaskID
      left join
      (select InvtID,User2 from [$(SolomonApp)].dbo.Inventory where ClassID='RATION')
      i ON tr.InvtID = i.InvtID
UNION ALL
      SELECT 'PJChargd' Module,ch.Batch_Id,'NoRefNbr' RefNbr,pg.TaskID,'Unknown_FeedQty' Account,
      (ch.units) AS Value
FROM  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS pg
      join 
      (select Batch_Id,pjt_entity,units from [$(SolomonApp)].dbo.pjchargd where acct='PIG FEED ISSUE' and units is not null)
      ch ON ch.pjt_entity = pg.TaskID

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load more into cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--This temp table #df2 is created just to group the data by TaskID and Account.
--#####################################################################################################################-- 
create table #df2
(TaskID char(32) not null
,Account char(32) null
,Value numeric null)
INSERT INTO #df2
(TaskID
,Account
,Value)
select TaskID,Account,SUM(Value) as Value
from  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
group by TaskID,Account
--#####################################################################################################################
--This temp table #df3 is created just to group the data by TaskID only to get Sum of FeedQty for every group.
--#####################################################################################################################
create table #df3
(TaskID char(32) not null
,Value numeric null)
INSERT INTO #df3
(TaskID
,Value)		

select TaskID,SUM(Value) from #df2
group by TaskID
order by TaskID
--#####################################################################################################################
--This temp table #df4 is created to calculate the difference between the Total Feed in PJPTDSUM vs. the sum sources of
--APTran, INTran, and pjchargd tables.
--#####################################################################################################################
create table #df4
(TaskID char(32) not null
,ValuePJ numeric null
,ValueDetail numeric null
,AdjQty numeric null)
INSERT INTO #df4
(TaskID
,ValuePJ
,ValueDetail
,AdjQty)

select pg.TaskID,sum(pj.act_units) ValuePJ, SUM(#df3.Value) ValueDetail,sum(pj.act_units)-SUM(#df3.Value) AdjQty
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS pg
left join [$(SolomonApp)].dbo.PJPTDSUM pj
on pj.pjt_entity=pg.TaskID
left join #df3
on #df3.TaskID=pg.TaskID
where pj.acct='PIG FEED ISSUE' and LEFT(pjt_entity,2)='PG'
group by pg.TaskID
having ABS(sum(pj.act_units)-SUM(#df3.Value))>=1
order by pg.TaskID
--#####################################################################################################################
--These reconciling entry rows of data are then inserted into the cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF table.
--#####################################################################################################################
INSERT INTO  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF
(Module
,BatNbr
,RefNbr
,TaskID
,Account
,Value)
select 'AdjToPJ' Module,'NoBatNbr' BatNbr,'NoRefNbr' RefNbr,TaskID,'Unknown_FeedQty' Account,
round(AdjQty,0) AS Value from #df4

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded more into cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load cft_ESSBASE_CLOSEOUT_FEEDDETAIL
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cft_ESSBASE_CLOSEOUT_FEEDDETAIL'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


--#####################################################################################################################
--After refreshing the cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF with new data, we can now create the
--cft_ESSBASE_CLOSEOUT_FEEDDETAIL which will be used to load data into the Closeout cube.
--This table IS used in the SQL interface load of the Closeout cube.
--#####################################################################################################################
--drop table  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL
truncate table  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL
--create table  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL
--(GroupNumber char(32) not null
--,Phase char(30) not null
--,ServiceManager char(50) not null
--,Pod char(30) not null
--,System char(30) not null
--,Time char(10) not null
--,Scenario char(20) not null
--,Account char(16) not null
--,Value float not null
--)
insert into  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL
(GroupNumber
,Phase
,ServiceManager
,Pod
,System
,Time
,Scenario
,Account
,Value
)
select
pg.TaskID as 'Group Number',pg.Phase,pg.PGServManager as 'Service Manager',pg.PodDescription as Pod,pg.System,dd.PICYear_Week as Time,'Actual' as Scenario,
fd.Account as Account, 
sum(fd.Value) as Value
from  dbo.cft_ESSBASE_CLOSEOUT_PIG_GROUPS pg WITH (NOLOCK)

left join  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF fd
on fd.TaskID = PG.TaskID

left join 		
		[$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo as dd WITH (NOLOCK)
		on dd.DayDate = pg.ActCloseDate
where fd.Account is not null		
group by pg.TaskID,pg.Phase,pg.PGServManager,pg.PodDescription,pg.System,dd.PICYear_Week,
fd.Account
order by pg.TaskID,fd.Account
--select * from  dbo.cft_ESSBASE_CLOSEOUT_FEEDDETAIL

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_CLOSEOUT_FEEDDETAIL, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

----------- end of process
               
END
-------------------------------------------------------------------------------
-- If the procedure gets to here, it is a successful run
-- NOTE: Make sure to capture @RecordsProcessed from your main query
-------------------------------------------------------------------------------
SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'

-------------------------------------------------------------------------------
-- Log the end of the procedure
-------------------------------------------------------------------------------


TheEnd:
SET @EndDate = GETDATE()
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
EXEC [$(CFFDB)].dbo.cfp_PrintTs 'End'
RAISERROR (@Comments, @ProcessStatus, 1)

RETURN @ProcessStatus

-------------------------------------------------------------------------------
-- Error handling
-------------------------------------------------------------------------------
ERR_Common:
    SET @Comments         = 'Error in step: ' + @StepMsg

    SET @ProcessStatus    = 16
    SET @RecordsProcessed = 0
    GOTO TheEnd					


