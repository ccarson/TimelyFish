


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 4/10/2012
-- Description:	Returns End Inventory by Site, Barn and Room
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_END_INVENTORY]
(
	
	 @WeekEndDate	datetime

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @ActSite Table
	(SiteBarnRoom Varchar(100)
	,BarnNbr Varchar(50)
	,PigGroupID Varchar(50)
	,MaxDate smalldatetime
	,WeekEndDate smalldatetime)
	
	Insert Into @ActSite

	Select Distinct ei.SiteBarnRoom, ei.BarnNbr, ei.PigGroupID, actdate.MaxDate, actdate.WeekEndDate

	From  dbo.cft_SITE_END_INVENTORY as ei

	left join (

	Select Distinct 
	mn.SiteID,
	mn.BarnNbr,
	mn.PigGroupID,
	timd.TranInMaxDate as 'MaxDate',
	dw.WeekEndDate 
	
	From (

	Select 
	right(rtrim(pg.ProjectID),4) as 'SiteID', 
	pg.BarnNbr,
	pg.PigGroupID, 
	Min(t.TranDate) as 'MinDate'
	
	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID

	Where 
	t.Reversal !=1 
	
	Group by 
	right(rtrim(pg.ProjectID),4),
	pg.BarnNbr,
	pg.PigGroupID) mn
	
	left join (
		
	Select 
	right(rtrim(pg.ProjectID),4) as 'SiteID', 
	pg.BarnNbr,
	pg.PigGroupID, 
	Max(t.TranDate) as 'MaxDate'

	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID

	Where 
	t.Reversal !=1 
	
	Group by 
	right(rtrim(pg.ProjectID),4),
	pg.BarnNbr,
	pg.PigGroupID) mx
	on mn.SiteID = mx.SiteID
	and mn.BarnNbr = mx.BarnNbr
	and mn.PigGroupID = mx.PigGroupID 
	
	left join (
	
	Select 
	right(rtrim(pg.ProjectID),4) as 'SiteID', 
	pg.BarnNbr,
	pg.PigGroupID, 
	Max(t.TranDate) as 'TranInMaxDate'

	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID

	Where 
	t.Reversal !=1 
	and t.Acct in ('Pig Transfer In','Pig Move In','Pig Purchase')
	
	Group by 
	right(rtrim(pg.ProjectID),4),
	pg.BarnNbr,
	pg.PigGroupID) timd
	on mn.SiteID = timd.SiteID
	and mn.BarnNbr = timd.BarnNbr
	and mn.PigGroupID = timd.PigGroupID 
	
	cross join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
	
	Where dw.daydate between mn.MinDate and mx.MaxDate) actdate
	
	on ei.PigGroupID = actdate.PigGroupID 
	
	Where actdate.WeekEndDate = @WeekEndDate
		
	order by ei.SiteBarnRoom, ei.PigGroupID, actdate.WeekEndDate

	Select 
	rtrim(ei.FeedMill) as 'FeedMill',
	rtrim(ei.SiteBarnRoom) as 'SiteBarnRoom',
	rtrim(ei.PigGroupID) as 'PigGroupID',
	rtrim(ei.FacilityType) as 'FacilityType',
	rtrim(ps.PigSystem) as 'PigSystem',
	rtrim(ei.Capacity) as 'Capacity',
	Convert(Date, asw.AvgPigTransferDate) as 'AvgGroupStartDate',
	asw.WeanWeek,
	Convert(Date, ei.WeekEndDate) as 'WeekEndDate',
	ei.EndInventory

	from  dbo.cft_SITE_END_INVENTORY ei
	
	left join (
	
	Select Distinct 
	right(rtrim(pg.ProjectID),4) as 'SiteID', 
	pg.BarnNbr,
	pg.PigGroupID, 
	ps.Description as 'PigSystem'
	
	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID
	left join [$(SolomonApp)].dbo.cftPigSystem ps
	on pg.PigSystemID = ps.PigSystemID 

	Where 
	t.Reversal !=1) ps
	on ei.PigGroupID = ps.PigGroupID 

	left join (

	Select 
	CapDates.SiteID,
	CapDates.SiteBarnRoom,
	CapDates.BarnNbr,
	CapDates.PigGroupID,
	CapDates.AvgPigTransferDate,
	dd.PICYear_Week as 'WeanWeek'

	From (

	Select

	PigGroupDates.SiteID, 
	PigGroupDates.SiteBarnRoom,
	PigGroupDates.BarnNbr,
	PigGroupDates.PigGroupID, 
	--StDate, 
	asw.AvgStWt,
	PigGroupDates.AvgPigTransferDate,
	DateAdd(dd,-Cast((-0.000000000007183 * power(asw.AvgStWt,6)
	+0.000000006941667 * power(asw.AvgStWt,5)
	-0.000002651573233 * power(asw.AvgStWt,4)
	+0.000509425663432 * power(asw.AvgStWt,3) 
	-0.051939340963695 * power(asw.AvgStWt,2)
	+3.172220285186420 * asw.AvgStWt
	-35.530545258570700) as int),PigGroupDates.AvgPigTransferDate) as 'WeanDay'


	--PigGroupDates.pigprodphaseid
	--PigGroupDates.Singlestock,
	--PigGroupDates.pigsystemid
			
	From (

	Select /*cftPigGroup.Description,*/ 
	cftPigGroup.PigGroupID, 
	TransferDates.SiteBarnRoom,
	cftPigGroup.BarnNbr,
	cftSite.SiteID, 
	cftPigGroup.UseActualsFlag, /*cftPigGroup.PigGenderTypeID,*/
	CAST(CONVERT(varchar, CAST(SUM(TransferDates.Qty * TransferDates.DateConvert)/ SUM(TransferDates.Qty) AS datetime), 101) AS datetime) AS 'AvgPigTransferDate', 
	TransferDates.TranDate StDate, 
	cftpiggroup.pigprodphaseid, 
	cftpiggroup.singlestock, 
	cftpiggroup.pigsystemid
	        
	From [$(SolomonApp)].dbo.cftPigGroup AS cftPigGroup 

	left join [$(SolomonApp)].dbo.cftSite as cftSite
	on cftPigGroup.SiteContactID = cftSite.ContactID

	Left Outer Join (

	Select 

	cftPigGroup.PigGroupID, 
	cftPigGroup.SiteBarnRoom,
	cftPigGroup.BarnNbr,
	cftPGInvTran.Qty, 
	vCFPigGroupStart.TranDate, 
	CAST(cftPGInvTran.TranDate AS float) AS 'DateConvert'

	From (
	
	Select 
	acts.SiteBarnRoom,
	acts.BarnNbr,
	acts.PigGroupID,
	acts.WeekEndDate
	from @ActSite acts 
	Where acts.MaxDate = (Select Max(MaxDate) from @ActSite
	where SiteBarnRoom = acts.SiteBarnRoom)) AS cftPigGroup 

	Left Outer Join [$(SolomonApp)].dbo.cftPGInvTran AS cftPGInvTran WITH (NOLOCK) 
	ON cftPGInvTran.PigGroupID = cftPigGroup.PigGroupID 
							
	Left Outer Join [$(SolomonApp)].dbo.vCFPigGroupStart AS vCFPigGroupStart 
	ON vCFPigGroupStart.PigGroupID = cftPigGroup.PigGroupID

	WHERE (cftPGInvTran.Reversal <> 1) 
	AND (cftPGInvTran.acct = 'PIG TRANSFER IN' 
	OR cftPGInvTran.acct = 'PIG PURCHASE') 
	OR (cftPGInvTran.Reversal <> 1) AND (cftPGInvTran.acct = 'PIG MOVE IN') 
	AND (cftPGInvTran.TranDate <= DATEADD(d, 7, vCFPigGroupStart.TranDate))) AS TransferDates 
	ON cftPigGroup.PigGroupID = TransferDates.PigGroupID
	WHERE cftPigGroup.PigProdPhaseID IN ('NUR', 'FIN', 'WTF') 
	         
	GROUP BY /*cftPigGroup.Description,*/ 
	cftPigGroup.PigGroupID, 
	TransferDates.SiteBarnRoom,
	cftPigGroup.BarnNbr,
	cftSite.SiteID, 
	cftPigGroup.UseActualsFlag, 
	TransferDates.TranDate, 
	cftpiggroup.pigprodphaseid, 
	cftpiggroup.singlestock, 
	cftpiggroup.pigsystemid) AS PigGroupDates 

	left join (

	Select 
	aw.DestPigGroupID,
	Sum(aw.Qty * aw.AvgWgt)/Sum(aw.Qty) as 'AvgStWt'

	from (

	Select 
	DestPigGroupID,
	Case when RecountRequired = 1 then RecountQty else DestFarmQty end as 'Qty',
	AvgWgt
	from [$(SolomonApp)].dbo.cftPMTranspRecord) aw

	Group by
	aw.DestPigGroupID) asw
	on PigGroupDates.PigGroupID = asw.DestPigGroupID 
		
	WHERE PigGroupDates.AvgPigTransferDate is not null
	and stdate>='1-1-08'
	--and pigsystemid='00'
	--ORDER BY PICYear_Week, Description

	) CapDates

	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
	on CapDates.WeanDay = dd.DayDate) ASW
	on ei.SiteBarnRoom = asw.SiteBarnRoom 
	
	Where ei.WeekEndDate between DateAdd(day, -365, @WeekEndDate) and @WeekEndDate
	
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_END_INVENTORY] TO [db_sp_exec]
    AS [dbo];

