



-- =============================================
-- Author:		Brian Diehl
-- Create date: 1/5/2015
-- Took original cfp_COST_TO_OWN and extended for additional information
-- Description:	Returns Vehicle Cost and Add'l Info
-- =============================================
CREATE PROCEDURE [dbo].[cfp_COST_TO_OWN_EXTENDED]
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
	then sd2.Description else sd1.Description end as 'DepartmentDesc',
	seq.gl_subacct as SubAcct,
	seq.MfgYear as 'ModelYr',
	seq.EquipTypeID as 'Model',
	seq.PurchAmount as 'PurchasePrice',
	VHMaint66600$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid)
	and pjtran.gl_acct = 66600 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	Repair66100$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid) 
	and pjtran.gl_acct = 66100 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	Tires66610$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid) 
	and pjtran.gl_acct = 66100 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	License66620$ = (Select Sum(pjtran.amount)*-1 from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid) 
	and pjtran.gl_acct = 71300 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	Fuel71200$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid) 
	and pjtran.gl_acct = 71200 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),	
	Insurance$ = (select cost.InsuranceAmount/cnt.vehicle_count as costPerVeh
			from (
				select gl.acct, gl.sub, sa.Descr, sum( gl.DrAmt) as InsuranceAmount
				from [$(SolomonApp)].dbo.gltran gl
				inner join [$(SolomonApp)].dbo.SubAcct sa on sa.Sub=gl.sub
				where gl.acct='80300' and gl.trandesc='AUTO INSURANCE' and gl.trandate between @StartDate and @EndDate
				group by gl.acct, gl.sub, sa.Descr
				) cost
			inner join (
				select pj.gl_subacct, COUNT(*) as vehicle_count
				from [$(SolomonApp)].dbo.pjproj pj
				inner join [$(SolomonApp)].dbo.cfvSvcEquiAll seqI on rtrim(pj.project) = rtrim(seqI.oldid) and seqi.Status='A'
				where left(pj.Project,2) = 'VH' and pj.status_pa = 'a'
				group by pj.gl_subacct
				) cnt on cost.Sub=cnt.gl_subacct and cost.Sub = seq.gl_subacct),
	
	Payments$ = (Select Sum(pjtran.amount) from [$(SolomonApp)].dbo.pjtran pjtran
	left join [$(SolomonApp)].dbo.pjproj pjproj on pjtran.project = pjproj.project
	where rtrim(pjproj.project) = rtrim(seq.oldid) 
	and pjtran.gl_acct = 80200 and left(rtrim(pjproj.project),2) = 'VH'
	and pjproj.status_pa = 'a' and pjtran.trans_date between @StartDate and @EndDate),
	sr.EarlierReading as 'PeriodPriorOdometer',
	sr.EndReading as 'EndOdometer',
	sr.EndReading-sr.EarlierReading as 'MilesDriven'

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


