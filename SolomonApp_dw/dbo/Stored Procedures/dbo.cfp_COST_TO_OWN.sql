


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 8/17/2011
-- Updated 1/25/2013 by BMD - added PeriodPriorOdometer reading and renamed original odometer to EndOdometer
-- Description:	Returns Vehicle Cost and Add'l Info
-- =============================================
CREATE PROCEDURE [dbo].[cfp_COST_TO_OWN]
(
	@StartDate			datetime
,	@EndDate			datetime

)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select 

	seq.EquipID as 'Unit#',
	seq.ContactName as 'Driver',
	Case when left(rtrim(seq.gl_subacct),2) = 50 
	then sd2.Description else sd1.Description end as 'Department',
	seq.MfgYear as 'ModelYr',
	seq.EquipTypeID as 'Model',
	seq.PurchAmount as 'PurchasePrice',
	Repairs$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid)
	and pjtran.gl_acct like '66%' and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	Fuel$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid) 
	and pjtran.gl_acct = 71200 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	sr.EarlierReading as 'PeriodPriorOdometer',
	sr.EndReading as 'EndOdometer'

	from [$(SolomonApp)].dbo.cfvSvcEquiAll seq

	left join [$(SolomonApp)].dbo.SegDef sd1
	on left(rtrim(seq.gl_subacct),2) = sd1.ID
	and sd1.SegNumber = 1

	left join [$(SolomonApp)].dbo.SegDef sd2
	on right(left(rtrim(seq.gl_subacct),4),2) = sd2.ID
	and sd2.SegNumber = 2
	
	left join (Select mr1.EquipID, svr2.reading as EarlierReading, svr1.Reading as EndReading
	from (Select EquipID, MAX(ReadDate) ReadDate from [$(SolomonApp)].dbo.smSvcReadings 
	where ReadDate between @StartDate and @EndDate Group by EquipID) mr1
	left join [$(SolomonApp)].dbo.smSvcReadings svr1 on mr1.EquipId = svr1.EquipId and mr1.ReadDate = svr1.ReadDate
	left join (Select EquipID, MAX(ReadDate) ReadDate from [$(SolomonApp)].dbo.smSvcReadings 
	where ReadDate between (@StartDate - (@enddate - @startdate)-1) and (@StartDate - 1) Group by EquipID) mr2 on mr1.EquipId=mr2.EquipId
	left join [$(SolomonApp)].dbo.smSvcReadings svr2 on mr2.EquipId = svr2.EquipId and mr2.ReadDate = svr2.ReadDate) sr
	on seq.EquipID = sr.EquipID

	where seq.Status = 'A'

	order by
	seq.EquipID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_COST_TO_OWN] TO [db_sp_exec]
    AS [dbo];

