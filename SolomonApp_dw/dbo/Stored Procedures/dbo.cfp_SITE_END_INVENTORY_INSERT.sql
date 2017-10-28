

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 2/29/2012
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SITE_END_INVENTORY_INSERT]
AS
BEGIN
--------------------------------------------------------------------------
-- CLEAR TABLE
--------------------------------------------------------------------------
TRUNCATE TABLE dbo.cft_SITE_END_INVENTORY

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO dbo.cft_SITE_END_INVENTORY
(	FeedMill
	,SiteID
	,BarnNbr
	,RoomNbr
	,PigGroupID
	,SiteBarnRoom
	,FacilityType
	,Capacity
	,WeekEndDate
	,EndInventory)

Select 
	Cap.FeedMill,
	Cap.SiteID,
	Cap.BarnNbr,
	Cap.RoomNbr,
	Cap.PigGroupID,
	Cap.SiteBarnRoom,
	Cap.FacilityType,
	Cap.Capacity,
	Date.WeekEndDate, 
	'EndInventory' = (Select Sum(ei.EndInventory) from 
	
	(Select 
	right(rtrim(pg.ProjectID),4) as 'SiteID', 
	pg.BarnNbr,
	pg.PigGroupID, 
	dw.WeekEndDate,
	SUM(t.Qty * t.InvEffect) as 'EndInventory'
	From [$(SolomonApp)].dbo.cftPigGroup pg
	inner join [$(SolomonApp)].dbo.cftPGInvTran t 
	on pg.PigGroupID = t.PigGroupID
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
	on t.TranDate = dw.DayDate
	Where 
	t.Reversal !=1 
	and t.TranDate <= Convert(date,GetDate()-DatePart(dw,GetDate()))
	Group by 
	right(rtrim(pg.ProjectID),4),
	pg.BarnNbr,
	pg.PigGroupID,
	dw.WeekEndDate) ei
	
	Where ei.SiteID = Cap.SiteID and ei.BarnNbr = Cap.BarnNbr and ei.PigGroupID = Cap.PigGroupID and ei.WeekEndDate <= Date.WeekEndDate) 

From (

	Select
	pgrm.SiteID,
	pgrm.BarnNbr,
	Case when pgrm.RoomNbr is null then '0' else pgrm.RoomNbr end as 'RoomNbr',
	pgrm.PigGroupID,
	Case when pgrm.RoomNbr is null then rtrim(bcap.SiteBarn) else rtrim(bcap.SiteBarn)+' '+'&'+' '+'Room'+' '+rtrim(pgrm.RoomNbr) end as 'SiteBarnRoom',
	bcap.FeedMill,
	Round(bcap.Capacity * Case when pgrm.BrnCapPrct is null then 1 else pgrm.BrnCapPrct end,0) as 'Capacity',
	bcap.FacilityTypeID,
	bcap.FacilityType
	
	From (

	Select Distinct
	pgr.SiteID,
	pgr.BarnNbr,
	pgr.PigGroupID,
	 dbo.cffn_PIG_GROUP_ROOM(pgr.SiteID, pgr.PigGroupID) as 'RoomNbr',
	cp.BrnCapPrct

	
	from (
	
	Select Distinct right(rtrim(pg.ProjectID),4) as 'SiteID', pg.BarnNbr, pg.PigGroupID, pgr.RoomNbr
	from [$(SolomonApp)].dbo.cftPigGroup pg
	left join [$(SolomonApp)].dbo.cftPigGroupRoom pgr
	on pg.PigGroupID = pgr.PigGroupID) pgr
	
	left join (
	
	Select Distinct right(rtrim(pg.ProjectID),4) as 'SiteID', pg.PigGroupID, Sum(rm.BrnCapPrct) as 'BrnCapPrct'
	from [$(SolomonApp)].dbo.cftPigGroup pg
	left join [$(SolomonApp)].dbo.cftPigGroupRoom pgr
	on pg.PigGroupID = pgr.PigGroupID
	left join [$(SolomonApp)].dbo.cftRoom rm
	on pg.SiteContactID = rm.ContactID
	and pg.BarnNbr = rm.BarnNbr
	and pgr.RoomNbr = rm.RoomNbr
	Group by right(rtrim(pg.ProjectID),4), pg.PigGroupID) cp
	on pgr.SiteID = cp.SiteID
	and pgr.PigGroupID = cp.PigGroupID) pgrm
	
left join (	

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
	Where cftContact.ContactName is not null
	--and cftBarn.FacilityTypeID in ('002','005','006')
	Group by
	cftBarn.SiteID, 
	cftBarn.BarnNbr,
	rtrim(cftContact.ContactName)+' '+'&'+' '+'Barn'+' '+rtrim(cftBarn.BarnNbr),
	cftFeedMill.ContactName,
	cftBarn.FacilityTypeID,
	cftFacilityType.Description) bcap
	
	on pgrm.SiteID = bcap.SiteID 
	and pgrm.BarnNbr = bcap.BarnNbr
	
	
	) Cap
	
left join (

	Select Distinct 
	mn.SiteID,
	mn.BarnNbr,
	mn.PigGroupID,
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
	
	cross join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
	
	Where dw.daydate between mn.MinDate and mx.MaxDate) Date
	on Cap.SiteID = Date.SiteID
	and Cap.BarnNbr = Date.BarnNbr
	and Cap.PigGroupID = Date.PigGroupID 
	
	--Where Date.WeekEndDate <= '1/1/2008'
	
	Order by
	Cap.SiteBarnRoom,
	Cap.FacilityType,
	Date.WeekEndDate
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_END_INVENTORY_INSERT] TO [db_sp_exec]
    AS [dbo];

