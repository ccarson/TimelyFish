

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 08/17/2010
-- Description:	Populates the Data Warehouse table.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_PROBLEM]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_REPAIRS_PROBLEM_ID_COST

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_REPAIRS_PROBLEM_ID_COST
(	Account
	,Division
	,Location
	,Capacity
	,GroupPeriod
	,RollupDescription
	,Description
	,TransactionDescription
	,FaultDescription
	,PurchaseOrderNumber
	,VendorId
	,Amount
	,ThreeMonthAmountPerSpace
	,SixMonthAmountPerSpace
	,TwelveMonthAmountPerSpace)
SELECT     
	gl.acct, 
	sd.description as 'Division',
	sa.Descr as 'Location',
	c.capacity,
	gl.PerPost AS 'GroupPeriod', 
	case when gl.acct in ('44100','44200','44210','44220','44230','44240','44250',
						  '44280','44285','44290','44300','44301','44320','44321','44322','44323','44340',
						  '44341','44350','44355','44400','44410','44420','44430','44440','44450','44470',
						  '44800','44900','47300','70600') 
	then 'Construction Costs'
	when ac.Descr is Null then 'No Value'
	else ac.Descr end as Rollup,
	case when ac.descr is Null then 'No Value' else ac.descr end descr, 
	case when gl.TranDesc is Null then 'No Value' else gl.TranDesc end TranDesc, 
	case when a.faultdesc is Null then 'No Value' else a.faultdesc end faultdesc,
	case when ap.ponbr is Null then 'No Value' else ap.ponbr end ponbr,
	case when ap.vendid is Null then 'No Value' else ap.vendid end vendid,
	sum(gl.dramt - gl.cramt) AS 'Amt',
	case when c.capacity = 0 then 0 else ((sum(gl.dramt - gl.cramt)/c.capacity)/3)*12 end as '3mon$/spc',
	case when c.capacity = 0 then 0 else ((sum(gl.dramt - gl.cramt)/c.capacity)/6)*12 end as '6mon$/spc',
	case when c.capacity = 0 then 0 else ((sum(gl.dramt - gl.cramt)/c.capacity)/12)*12 end as '12mon$/spc'
FROM         
	[$(SolomonApp)].dbo.GLTran as gl with (nolock) 
	left outer join
	(select distinct
		refnbr,
		acct,
		sub,
		curytranamt,
		trandesc,
		vendid,
		ponbr
	from [$(SolomonApp)].dbo.aptran 
	where rlsed='1') ap 
	on ap.refnbr=gl.refnbr
		and ap.acct=gl.acct
		and ap.sub=gl.sub
		and ap.curytranamt=gl.dramt
		and ap.trandesc=gl.trandesc
		and ap.ponbr=ISNULL(
			(select top 1
				a.ponbr
				from (select distinct
				refnbr,
				acct,
				sub,
				curytranamt,
				trandesc,
				vendid,
				ponbr
				from [$(SolomonApp)].dbo.aptran 
				where rlsed='1') a
				where a.refnbr=gl.refnbr
				and a.acct=gl.acct
				and a.sub=gl.sub
				and a.curytranamt=gl.dramt
				and a.trandesc=gl.trandesc), 
				0)
	left outer join [$(SolomonApp)].dbo.Account as ac with (nolock) 
		ON gl.Acct = ac.Acct 
	left outer join [$(SolomonApp)].dbo.SubAcct as sa with (nolock) 
		ON gl.Sub = sa.Sub 
	left outer join
		(select 
			b.siteid,
			sum(b.maxcap) capacity
		from [$(SolomonApp)].dbo.cftbarn b
		left join [$(SolomonApp)].dbo.cftcontact c
		on b.contactid=c.contactid
		where b.statustypeid='1'
		and c.statustypeid='1'
		group by 
		b.siteid) c
		on right(rtrim(gl.sub),4)=c.siteid
	left outer join
		(select 
			description,
			id
		from [$(SolomonApp)].dbo.segdef
		where segnumber='1') sd
		on left(rtrim(gl.sub),2)=rtrim(sd.id)
	left outer join
	(select distinct
	b.sub,
	b.trandate,
	b.description,
	scd.faultdesc
	from (select distinct
	a.sub,
	a.trandate,
	a.description,
	case when a.primaryfaultcode in ('Heatelec','Heater100','Heater150','Heater250')
	then 'HEAT'
	else case when a.primaryfaultcode in ('Mow','Tr')
	then 'GRA'
	else case when a.primaryfaultcode in ('Sl')
	then 'FLO'
	else case when a.primaryfaultcode in ('Sns')
	then 'AL'
	else case when a.primaryfaultcode in ('Water')
	then 'WS'
	else case when a.primaryfaultcode in ('Flu','Flush','Manure','Pit','Ptv','Rech','Scr')
	then 'MS'
	else a.primaryfaultcode end end end end end end primaryfaultcode
	from 
	(select distinct
	sd.sub,
	sd.trandate,
	sd.description,
	case when scl.primaryfaultcode in ('Bearing','Bin Boot','DR','Drill','FE','Feed','Feed Cntrl',
	'Feeder','Gear','Motor','Mtr')
	then 'FC'
	else case when scl.primaryfaultcode in ('Boar Cart')
	then 'BOARBOT'
	else case when scl.primaryfaultcode in ('Breaker','EL','TSTAT','WIRING')
	then 'ELEC DEVIC'
	else case when scl.primaryfaultcode in ('Ceiling','Door','Fum','Ins','Roof','Sof','Wall','Window')
	then 'BUILDING'
	else case when scl.primaryfaultcode in ('Chim','Inlets','TS')
	then 'VENT CTL'
	else case when scl.primaryfaultcode in ('Closeout')
	then 'CLOSE OUT'
	else case when scl.primaryfaultcode in ('Cmpst','Dead','Lsc','Lvstcl','Lvstr','Lvstrf','Service')
	then 'MISC'
	else case when scl.primaryfaultcode in ('Dc','Fp','Parts','Pt','Sp')
	then 'MNT'
	else case when scl.primaryfaultcode in ('Dw')
	then 'INC'
	else case when scl.primaryfaultcode in ('Fan10','Fan18','Fan20','Fan24','Fan36','Fan48','Fan51','Fan9','Fanstir')
	then 'FAN'
	else scl.primaryfaultcode end end end end end end end end end end primaryfaultcode
	from [$(SolomonApp)].dbo.smservcall scl (nolock)
	left join [$(SolomonApp)].dbo.smservdetail sd (nolock)
	on scl.servicecallid=sd.servicecallid) a) b
	left join [$(SolomonApp)].dbo.smcode scd (nolock)
	on b.primaryfaultcode=scd.fault_id) a
	on gl.sub=a.sub
	and gl.trandate=a.trandate
	and gl.trandesc=a.description
	and a.faultdesc=ISNULL(
	(select top 1
	a.faultdesc
	from (select 
	sd.sub,
	sd.trandate,
	sd.description,
	scd.faultdesc
	from [$(SolomonApp)].dbo.smservcall scl (nolock)
	left join [$(SolomonApp)].dbo.smservdetail sd (nolock)
	on scl.servicecallid=sd.servicecallid
	left join [$(SolomonApp)].dbo.smcode scd (nolock)
	on scl.primaryfaultcode=scd.fault_id) a
	where 
	a.sub=gl.sub
	and a.description=gl.trandesc
	and a.trandate=gl.trandate),
	0)
WHERE     
	(gl.Rlsed = 1) 
	and (ac.accttype in ('3I','3E'))
	AND (gl.PerPost >= '200801')
	and ac.acct in ('66100','60100','66110','70825','44100','44200','44210','44220',
	'44230','44240','44250','44280','44285','44290','44300','44301','44320','44321',
	'44322','44323','44340','44341','44350','44355','44400','44410','44420','44430',
	'44440','44450','44470','44800','44900','47300','70600')
GROUP BY 
	gl.acct,
	sd.description,
	sa.descr, 
	c.capacity,
	gl.PerPost, 
	ac.Descr, 
	gl.TranDesc,
	a.faultdesc,
	ap.ponbr,
	ap.vendid,
	ap.curytranamt
	order by
	sd.description,
	sa.descr,
	gl.perpost,
	ac.descr,
	gl.trandesc,
	a.faultdesc
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_PROBLEM] TO [db_sp_exec]
    AS [dbo];

