


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/3/2011
-- Description:	Returns Current Inventory by Site
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CURRENT_INVENTORY]
(
	
	@WeekEndDate	smalldatetime

)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @InventoryTable table
(     SiteID char(10)
,	  BarnNbr char(10)
,	  WeekEndDate smalldatetime
,	  EndInventory int)

INSERT INTO @InventoryTable (SiteID, BarnNbr, WeekEndDate, EndInventory)

	Select 
	right(rtrim(pg.ProjectID),4) as 'SiteID',
	pg.BarnNbr,
	dw.WeekEndDate,
	SUM(t.Qty * t.InvEffect) as 'EndInventory'
	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
	on t.TranDate = dw.DayDate
	Where 
	t.Reversal !=1 
	and t.TranDate <= @WeekEndDate
	Group by 
	right(rtrim(pg.ProjectID),4),
	pg.BarnNbr,
	dw.WeekEndDate
	Order by
	right(rtrim(pg.ProjectID),4), 
	dw.WeekEndDate

	Select 
	Cap.FeedMill,
	Cap.SiteBarn,
	Cap.FacilityType,
	Cap.Capacity,
	asw.AvgPigTransferDate,
	asw.WeanWeek,
	Date.PICYear_Week,
	'EndInventory' = (Select SUM(EndInventory) from @InventoryTable
	Where SiteID = Cap.SiteID and BarnNbr = Cap.BarnNbr and WeekEndDate <= Date.WeekEndDate) 

From (

	Select
	cftBarn.SiteID,
	cftBarn.BarnNbr, 
	rtrim(cftContact.ContactName)+' '+'&'+' '+'Barn'+' '+rtrim(cftBarn.BarnNbr) as 'SiteBarn',
	cftFeedMill.ContactName as 'FeedMill',
	Sum(cftBarn.MaxCap) as 'Capacity', 
	cftBarn.FacilityTypeID,
	cftFacilityType.Description as 'FacilityType'
	From [$(SolomonApp)].dbo.cftBarn cftBarn 
	left join [$(SolomonApp)].dbo.cftContact cftContact
	on cftBarn.ContactID = cftContact.ContactID  
	left join [$(SolomonApp)].dbo.cftFacilityType cftFacilityType
	on cftBarn.FacilityTypeID = cftFacilityType.FacilityTypeID
	left join [$(SolomonApp)].dbo.cftSite cftSite
	on cftBarn.ContactID = cftSite.ContactID 
	left join [$(SolomonApp)].dbo.cftContact cftFeedMill
	on cftSite.FeedMillContactID = cftFeedMill.ContactID 
	Where cftBarn.StatusTypeID = '1'
	and cftContact.ContactName is not null
	and cftBarn.FacilityTypeID in ('002','005','006')
	Group by
	cftBarn.SiteID, 
	cftBarn.BarnNbr,
	rtrim(cftContact.ContactName)+' '+'&'+' '+'Barn'+' '+rtrim(cftBarn.BarnNbr),
	cftFeedMill.ContactName,
	cftBarn.FacilityTypeID,
	cftFacilityType.Description) Cap
	
left join (

	Select 
	CapDates.SiteID,
	CapDates.BarnNbr,
	CapDates.PigGroupID,
	CapDates.AvgPigTransferDate,
	dd.PICYear_Week as 'WeanWeek'

	From (

	Select

	PigGroupDates.SiteID, 
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
	cftPigGroup.BarnNbr,
	cftPGInvTran.Qty, 
	vCFPigGroupStart.TranDate, 
	CAST(cftPGInvTran.TranDate AS float) AS 'DateConvert'

	From [$(SolomonApp)].dbo.cftPigGroup AS cftPigGroup WITH (NOLOCK) 

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
	WHERE cftPigGroup.PigProdPhaseID IN ('NUR', 'FIN', 'WTF') AND cftPigGroup.PGStatusId in ('A','T')
	         
	GROUP BY /*cftPigGroup.Description,*/ 
	cftPigGroup.PigGroupID, 
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
	and pigsystemid='00'
	--ORDER BY PICYear_Week, Description

	) CapDates

	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
	on CapDates.WeanDay = dd.DayDate
	) ASW
	on cap.SiteID = asw.SiteID 
	and cap.BarnNbr = asw.BarnNbr
	
left join @InventoryTable it
	on Cap.SiteID = it.SiteID
	and Cap.BarnNbr = it.BarnNbr

left join (

	Select Distinct
	WeekEndDate,
	PICYear_Week
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) Date
	on it.WeekEndDate = Date.WeekEndDate
	
	Order by
	Cap.SiteBarn,
	Cap.FacilityType,
	Date.PICYear_Week
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CURRENT_INVENTORY] TO [db_sp_exec]
    AS [dbo];

