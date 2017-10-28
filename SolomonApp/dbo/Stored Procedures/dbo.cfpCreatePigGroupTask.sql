--*************************************************************
--	Purpose:Add Pig Group task to PJPENT table
--	Author: Charity Anderson
--	Date: 8/24/2004
--	Usage: Creating Tasks
--	Parms:ContactID, BarnNbr, StartDate,Company
--*************************************************************

CREATE PROC dbo.cfpCreatePigGroupTask
	@parm1 as char(6),
	@parm2 as char(6),
	@parm3 as smalldatetime,
	@parm4 as char(3)
AS
DECLARE @TaskIDVal as int
DECLARE @TaskIDChar as char(5)

Select @TaskIDChar=(Select LastTaskNbr from cftPGSetup)
Select @TaskIDVal= (@TaskIDChar)+1 
--print @TaskIDVal
Update cftPGSetup Set LastTaskNbr=replicate('0',5-len(rtrim(convert(char(5),@TaskIDVal)))) + rtrim(convert(char(5),@TaskIDVal))
Select @TaskIDChar=replicate('0',5-len(rtrim(convert(char(5),@TaskIDVal)))) + rtrim(convert(char(5),@TaskIDVal))

Insert into PJPENT (contract_type,crtd_datetime,crtd_prog,crtd_user,end_date,fips_num,lupd_datetime,
		    lupd_prog,lupd_user,manager1,MSPData,MSPInterface,MSPTask_UID,noteid,pe_id01,pe_id02,
                    pe_id03,pe_id04,pe_id05,pe_id06,pe_id07,pe_id08,pe_id09,pe_id10,pe_id31,pe_id32,pe_id33,
		    pe_id34,pe_id35,pe_id36,pe_id37,pe_id38,pe_id39,pe_id40,pjt_entity,pjt_entity_desc,project,
                    start_date,status_08,status_09,status_10,status_11,status_12,status_13,status_14,status_15,
                    status_16,status_17,status_18,status_19,status_20,status_ap,status_ar,status_gl,status_in,status_lb,
                    status_pa,status_po,user1,user2,user3,user4)
Select '',getdate(),'PAPRJ','SYSADMIN','1/1/1900','',getdate(),'PAPRJ','SYSADMIN','','','',0,0,
dbo.GetSubAcct(@parm1,@parm2) as GL,'','','',@parm4,
0,0,'1/1/1900','1/1/1900',0,'','','','','','','',0,'1/1/1900',0,
TaskID=(Select TaskPrefix from cftPGSetup) + @TaskIDChar,
TaskName=(Select ContactName from SolomonApp.dbo.cftContact where ContactID=@parm1) + ' Barn ' + @parm2,
Project=(Select ProjectPrefix from cftPGSetup) + 
	(Select s.SiteID from SolomonApp.dbo.cftSite s JOIN SolomonApp.dbo.cftContact c on s.ContactID=c.ContactID 
	where c.ContactID=@parm1),
@parm3,
'','','','','','','','','','','','','','A','A','A','A','A','A','A',@parm1,'',0,0

INSERT into cftPigGroup (ActCloseDate,BarnNbr,Comment,Crtd_DateTime,Crtd_Prog,Crtd_User,EstCloseDate,EstInventory,
	EstStartDate,EstStartWeight,EstTopDate,FeedGrouping,FeedMillContactID,FeedPlanID,LegacyGroupID,
	Lupd_DateTime,Lupd_Prog,Lupd_User,NoteID,PGStatusID,PigFlowTypeID,PigGenderTypeID,PigGroupID,PigProdPhaseID,
	ProjectID,SiteContactID,TaskID)
Select '1/1/1900',@parm2,'',getdate(),'PAPRJ','SYSADMIN','1/1/1900',0,
	@parm3,0,'1/1/1900',
	--FacilityTypeID=(Select FacilityTypeID from SolomonApp.dbo.cftBarn b join SolomonApp.dbo.cftContact c
	--		on b.ContactID=c.ContactId where c.ContactID=@parm1 and b.BarnNbr=@parm2),
	'','','','',
	getdate(),'PAPRJ','SYSADMIN',0,'A',0,'',
	PigGroupID=@TaskIDChar,'',
	Project=(Select ProjectPrefix from cftPGSetup) + 
	(Select s.SiteID from SolomonApp.dbo.cftSite s JOIN SolomonApp.dbo.cftContact c on s.ContactID=c.ContactID 
	where c.ContactID=@parm1),
	@parm1,TaskID=(Select TaskPrefix from cftPGSetup) + @TaskIDChar


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpCreatePigGroupTask] TO [MSDSL]
    AS [dbo];

