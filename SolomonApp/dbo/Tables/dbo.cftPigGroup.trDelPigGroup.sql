


CREATE TRIGGER [dbo].[trDelPigGroup] ON [dbo].[cftPigGroup] 
FOR DELETE
AS
BEGIN TRAN
SET NOCOUNT ON

insert into cftDataAudit
([AuditEvent]      ,[Lupd_DateTime]      ,[Lupd_Prog]      ,[Lupd_User]      ,[OldValue]      ,[NewValue])
select 'cftpiggroup:  PigGroup deleted', getdate(),substring(program_name,1,50), substring(login_name,1,10), d.piggroupid, ''
from sys.dm_exec_sessions
cross join deleted  d
where session_id = @@spid

insert into solomonapp.dbo.cftpiggroup_deltlog
([ActCloseDate],[ActStartDate],[BarnNbr],[CF01],[CF02],[CF03],[CF04],[CF05],[CF06],[CF07],[CF08],[CF09],[CF10],[CF11],[CF12]
,[Comment],[CostFlag],[CpnyID],[Crtd_DateTime],[Crtd_Prog],[Crtd_User],[Description],[EstCloseDate],[EstInventory],[EstStartDate],[EstStartWeight],[EstTopDate]
,[EUCallbyUser],[EUDateInel],[EUDatePLCall],[EUDateTop],[EUFirstPLDeliv],[EUPFEUInel],[EUPLSFP],[EUTopVerified]
,[FeedGrouping],[FeedMillContactID],[FeedPlanID],[GenderConfirmedFlag],[InitialPigValue],[LegacyGroupID],[Lupd_DateTime],[Lupd_Prog],[Lupd_User]
,[MasterPigGroupID],[NoteID],[OverRideEstQty],[PGStatusID],[PigFlowTypeID],[PigGenderTypeID],[PigGroupID],[PigProdPhaseID],[PigProdPodID]
,[PigSystemID],[PriorFeedQty],[ProjectID],[PurchCountry],[PurchFlag],[SingleStock],[SplitSrcPigGroupID],[SiteContactID],[TaskID],[UseActualsFlag])
select 
[ActCloseDate],[ActStartDate],[BarnNbr],[CF01],[CF02],[CF03],[CF04],[CF05],[CF06],[CF07],[CF08],[CF09],[CF10],[CF11],[CF12]
,[Comment],[CostFlag],[CpnyID],[Crtd_DateTime],[Crtd_Prog],[Crtd_User],[Description],[EstCloseDate],[EstInventory],[EstStartDate],[EstStartWeight],[EstTopDate]
,[EUCallbyUser],[EUDateInel],[EUDatePLCall],[EUDateTop],[EUFirstPLDeliv],[EUPFEUInel],[EUPLSFP],[EUTopVerified]
,[FeedGrouping],[FeedMillContactID],[FeedPlanID],[GenderConfirmedFlag],[InitialPigValue],[LegacyGroupID],[Lupd_DateTime],[Lupd_Prog],[Lupd_User]
,[MasterPigGroupID],[NoteID],[OverRideEstQty],[PGStatusID],[PigFlowTypeID],[PigGenderTypeID],[PigGroupID],[PigProdPhaseID],[PigProdPodID]
,[PigSystemID],[PriorFeedQty],[ProjectID],[PurchCountry],[PurchFlag],[SingleStock],[SplitSrcPigGroupID],[SiteContactID],[TaskID],[UseActualsFlag]
from deleted  d



Update cftPM
set SourceContactID='',SourceBarnNbr='', SourceRoomNbr='',
SourceProject='', SourceTask='', 
SourcePigGroupID=''
from cftPM pm 
JOIN Deleted d on pm.SourcePigGroupID=d.PigGroupID
where pm.SourcePigGroupID > ''

Update cftPM
set DestContactID='',DestBarnNbr='', DestRoomNbr='',
DestProject='', DestTask='', DestPigGroupID=''
from cftPM pm 
JOIN Deleted d on pm.DestPigGroupID=d.PigGroupID
where pm.DestPigGroupID > ''

COMMIT WORK


