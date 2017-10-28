

-- =============================================
-- Author:		SRipley, dbo.cfp_SLF_Flow_build
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- 20150303 sripley, implementing changes for John Maas (work around for inaccuracy of the facilitytype and barn cap values)
-- 20151019 tthomsen: Brian and I resolved divide by zero errors
-- 2016-02-29 BMD  Updated to exclude CF-SBF sale stub groups.  We don't want these in the cube.
--				   INSERT INTO #pgs statement updated at line 516
-- 2016-03-01 John Maas - Add reversal exclusions to lines 2966,2977,3028 and 3039
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SLF_FLOW_Build]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- 01 Create Insert Circular Pig Groups	
create table #pg
(GEN1_PigGroup char(10) null,
GEN2_PigGroup char(10) null,
GEN3_PigGroup char(10) not null)

INSERT INTO #pg
(GEN1_PigGroup,
GEN2_PigGroup,
GEN3_PigGroup)
select distinct 
i2.SourcePigGroupID as GEN1_PigGroup,i2.PigGroupID as GEN2_PigGroup,
i.PigGroupID as GEN3_PigGroup
from [$(SolomonApp)].dbo.cftPGInvTran i
left join [$(SolomonApp)].dbo.cftPGInvTran i2
on i2.PigGroupID=i.SourcePigGroupID and i2.acct in ('PIG TRANSFER IN') and i.Reversal<>1
where i.acct in ('PIG TRANSFER IN') and i.Reversal<>1 and i.SourcePigGroupID<>''


TRUNCATE table  dbo.cft_SLF_CIRCULAR_PIG_GROUPS

INSERT INTO  dbo.cft_SLF_CIRCULAR_PIG_GROUPS
(PigGroupID)
select distinct GEN1_PigGroup as PigGroupID from #pg
where GEN1_PigGroup=GEN3_PigGroup
order by GEN1_PigGroup

drop table #pg
-- 01 Create Insert Circular Pig Groups	

-- 02 Create Insert SLF 3 month date table
TRUNCATE table  dbo.cft_SLF_3MONTH_DATETABLE

INSERT INTO  dbo.cft_SLF_3MONTH_DATETABLE
(
CurPerPost,
PriorPerPost,
Prior2PerPost,
StartDate,
EndDate
)

select
t1.CurPerPost,
t1.PriorPerPost,
t1.Prior2PerPost,
w2.StartDate,
t1.EndDate
from (
	select
	FYPeriod 'CurPerPost'
	, CASE WHEN FiscalPeriod = 1 THEN right(FiscalYear-1,2) ELSE right(FiscalYear,2) END + 'Per' +
		CASE WHEN FiscalPeriod = 1 THEN '12' 
		ELSE replicate('0',2-len(rtrim(convert(char(2),rtrim(FiscalPeriod-1))))) 
		+ rtrim(convert(char(2),rtrim(FiscalPeriod-1))) END 'PriorPerPost'
	, CASE WHEN FiscalPeriod IN (1,2) THEN right(FiscalYear-1,2) ELSE right(FiscalYear,2) END + 'Per' +
		CASE WHEN FiscalPeriod = 1 THEN '11' 
		WHEN FiscalPeriod = 2 THEN '12' 
		ELSE replicate('0',2-len(rtrim(convert(char(2),rtrim(FiscalPeriod-2))))) 
		+ rtrim(convert(char(2),rtrim(FiscalPeriod-2))) END 'Prior2PerPost'
	, CASE WHEN FiscalPeriod IN(1,2) THEN FiscalYear-1 ELSE FiscalYear END AS StartYear
	, CASE WHEN FiscalPeriod = 1 THEN 11
		WHEN FiscalPeriod = 2 THEN 12
		ELSE FiscalPeriod-2 END AS StartPeriod
	, NULL 'StartDate'
	, max(WeekEndDate) 'EndDate'
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WITH (NOLOCK)
	where WeekOfDate >='1/2/2000'
	group by FiscalPeriod,FiscalYear,FYPeriod) t1
left join (
	select
	FYPeriod 'CurPerPost',
	'' 'CurPerPost-1',
	'' 'CurPerPost-2',
	min(WeekOfDate) 'StartDate',
	max(WeekEndDate) 'EndDate'
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WITH (NOLOCK)
	group by FYPeriod
) w2
on t1.Prior2PerPost=w2.CurPerPost
order by w2.StartDate
-- 02 Create Insert SLF 3 month date table


-- 03 Create insert SLF Sow Farm Cost
truncate table  dbo.cft_SLF_SOWFARMCOST

INSERT INTO  dbo.cft_SLF_SOWFARMCOST
(
Location,
PerPost,
FYPeriod,
TotalCost
)

select
'LOC'+right(rtrim(gl.sub),4) 'Location',
gl.PerPost,
right(left(gl.PerPost,4),2)+'Per'+RIGHT(gl.PerPost,2) as 'FYPeriod',
sum(DrAmt)-sum(CrAmt) 'TotalCost'
from [$(SolomonApp)].dbo.GLTRAN gl WITH (NOLOCK) 
left join [$(SolomonApp)].dbo.Account a WITH (NOLOCK) 
on a.acct=gl.acct
where a.AcctType in ('3E','3I')
and gl.acct not in ('41150','41250','41900')
and left(gl.sub,3) in ('104','204')
and gl.Posted='P'
--and gl.PerPost >= '200707'
group by
'LOC'+right(rtrim(gl.sub),4),
gl.PerPost,
right(left(gl.PerPost,4),2)+'Per'+RIGHT(gl.PerPost,2)
order by gl.PerPost
-- 03 Create insert SLF Sow Farm Cost

-- 04 Create insert SLF 3 Month Cost Weaned Pig
Truncate table   dbo.cft_SLF_3MONTH_COST_WP

INSERT INTO  dbo.cft_SLF_3MONTH_COST_WP
(
CurPerPost,
Location,
ThreeMoCost,
ThreeMoWP,
ThreeMoWPCost
)

select
fp.CurPerPost,
T2.Location,
isnull(cost1.TotalCost,0) + isnull(cost2.TotalCost,0) + isnull(cost3.TotalCost,0) 'ThreeMoCost',
sum(T2.WP_Qty) as ThreeMoWP,
round(((isnull(cost1.TotalCost,0) + isnull(cost2.TotalCost,0) + isnull(cost3.TotalCost,0))/sum(T2.WP_Qty)),2) as 'ThreeMoWPCost'
from (
select * from  dbo.cft_SLF_3MONTH_DATETABLE WITH (NOLOCK)) fp
left join (
select distinct
	'LOC'+right(rtrim(gl.sub),4) 'Location',
	--gl.PerPost,
	right(left(gl.PerPost,4),2)+'Per'+right(gl.PerPost,2) as PerPost
	from [$(SolomonApp)].dbo.GLTRAN gl WITH (NOLOCK)
	where 
	left(gl.sub,3) in ('104','204')
	and gl.PerPost >= '200411'
	) glLOC
on glLOC.PerPost=fp.CurPerPost
left join  dbo.cft_SLF_SOWFARMCOST as cost1 WITH (NOLOCK)
on cost1.FYPeriod=fp.CurPerPost and cost1.Location=glLOC.Location
left join  dbo.cft_SLF_SOWFARMCOST as cost2 WITH (NOLOCK)
on cost2.FYPeriod=fp.PriorPerPost and cost2.Location=glLOC.Location
left join  dbo.cft_SLF_SOWFARMCOST as cost3 WITH (NOLOCK)
on cost3.FYPeriod=fp.Prior2PerPost and cost3.Location=glLOC.Location

left join (
	select
	T.MovementDate,
	'LOC'+rtrim(S.SiteID) 'Location',
	sum(G.Qty) 'WP_Qty'
	from
	[$(SolomonApp)].dbo.cftPMTranspRecord T WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftpmtransprecord re WITH (NOLOCK)
	on (T.refnbr = re.origrefnbr)
	left join [$(SolomonApp)].dbo.cftPMGradeQty G WITH (NOLOCK)
	on T.RefNbr=G.RefNbr
	left join [$(SolomonApp)].dbo.cftSite S WITH (NOLOCK)
	on S.ContactID=T.SourceContactID
	where T.doctype <> 're'
	and re.refnbr is null
	and left(T.SubTypeID,1) = 'S'
	and T.PigTypeID='02'
	and G.PigGradeCatTypeID in ('01','06')
	group by
	T.MovementDate,
	'LOC'+rtrim(S.SiteID)
	) T2
on fp.StartDate<=T2.MovementDate and fp.EndDate>=T2.MovementDate
and T2.Location=glLOC.Location
where isnull(cost1.TotalCost,0) + isnull(cost2.TotalCost,0) + isnull(cost3.TotalCost,0) is not null
and T2.Location is not null
group by
fp.CurPerPost,
T2.Location,
isnull(cost1.TotalCost,0) + isnull(cost2.TotalCost,0) + isnull(cost3.TotalCost,0)
order by
fp.CurPerPost,
T2.Location
-- 04 Create insert SLF 3 Month Cost Weaned Pig

-- 05 Create insert SLF Transfers All Cost Weaned Pig
create table #wpt
(PigGroupID char(10) not null,
acct char(16) not null,
FYPeriod char(7) not null,
Qty int not null,
TotalWgt float not null,
SourceProject char(16) not null
)

INSERT INTO #wpt
(PigGroupID,
acct,
FYPeriod,
Qty,
TotalWgt,
SourceProject
)
select i.PigGroupID,
i.acct,
d.FYPeriod,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
case when i.SourceProject IN ('PS8100','PS8110','PS8120','PS8130','PS8140','PS2970','PS8121') then 'PS8121'
when i.SourceProject IN ('PS8150','PS8160','PS8170','PS8180','PS8190','PS8200','PS2980','PS8122') then 'PS8122'
else i.SourceProject end as SourceProject
from [$(SolomonApp)].dbo.cftPGInvTran i with (NOLOCK)
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d with (NOLOCK)
on d.DayDate=i.TranDate
left join [$(SolomonApp)].dbo.cftPigGroup pg with (NOLOCK)
on pg.PigGroupID=i.PigGroupID
where i.Reversal<>1 and acct='PIG TRANSFER IN'
and LEFT(i.SourceProject,2)='PS' and i.SourcePigGroupID=''
and pg.PigProdPhaseID in ('NUR','FIN','WTF')
and i.TranSubTypeID in ('SN','SW')
group by
i.PigGroupID,i.acct,d.FYPeriod,
case when i.SourceProject IN ('PS8100','PS8110','PS8120','PS8130','PS8140','PS2970','PS8121') then 'PS8121'
when i.SourceProject IN ('PS8150','PS8160','PS8170','PS8180','PS8190','PS8200','PS2980','PS8122') then 'PS8122'
else i.SourceProject end
order by i.PigGroupID

truncate table  dbo.cft_SLF_TRANSFER_ALL_COST_WP
INSERT INTO  dbo.cft_SLF_TRANSFER_ALL_COST_WP
(
PigGroupID,
acct,
FYPeriod,
Qty,
TotalWgt,
SourceProject,
ThreeMoWPCost
)
select i.PigGroupID,i.acct,
i.FYPeriod,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,i.SourceProject,isnull(wp.ThreeMoWPCost,0) as ThreeMoWPCost
from #wpt i with (NOLOCK)
left join  dbo.cft_SLF_3MONTH_COST_WP wp with (NOLOCK)
on wp.CurPerPost=i.FYPeriod and right(rtrim(wp.Location),4)=right(rtrim(i.SourceProject),4)
group by
i.PigGroupID,i.acct,i.FYPeriod,i.SourceProject,wp.ThreeMoWPCost
order by i.PigGroupID

drop table #wpt
-- 05 Create insert SLF Transfers All Cost Weaned Pig

-- 06 Create insert SLF Total TransfersOut
tRUNCATE table  dbo.cft_SLF_TOTAL_TRANSFEROUT
INSERT INTO  dbo.cft_SLF_TOTAL_TRANSFEROUT
(
PigGroupID,
Qty,
TotalWgt,
PigProdPhaseID,
CostFlag,
PGStatusID,
PigSystemID
)

select i.PigGroupID,
Sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,pg.PigProdPhaseID,pg.CostFlag,
pg.PGStatusID, pg.PigSystemID
from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=i.PigGroupID
left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
on i.SourceBatNbr=i2.SourceBatNbr and i.SourceRefNbr=i2.SourceRefNbr and i.SourceLineNbr=i2.SourceLineNbr
and i2.acct='PIG TRANSFER IN' and i2.Reversal<>1
left join [$(SolomonApp)].dbo.cftPigGroup pg2 WITH (NOLOCK)
on pg2.PigGroupID=i2.PigGroupID
where i.Reversal<>1
--Transfers out and Sales to other Pig Groups when in FIN or WTF phase.
and pg.PigProdPhaseID<>'NUR'
--Does not include Transfers Out to Tailender Groups and includes Pig Sales into the Total for Transferred Out
and ((i.acct in ('PIG TRANSFER OUT') and pg2.PigProdPhaseID<>'TEF') or
	i.acct in ('PIG SALE'))
group by i.PigGroupID,
pg.PigProdPhaseID,pg.CostFlag,
pg.PGStatusID, pg.PigSystemID
UNION
select i.PigGroupID,
Sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,pg.PigProdPhaseID,pg.CostFlag,
pg.PGStatusID, pg.PigSystemID
from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=i.PigGroupID
left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
on i.SourceBatNbr=i2.SourceBatNbr and i.SourceRefNbr=i2.SourceRefNbr and i.SourceLineNbr=i2.SourceLineNbr
and i2.acct='PIG TRANSFER IN' and i2.Reversal<>1
left join [$(SolomonApp)].dbo.cftPigGroup pg2 WITH (NOLOCK)
on pg2.PigGroupID=i2.PigGroupID
where i.Reversal<>1
--Just Transfers out to other Pig Groups when NUR phase
and pg.PigProdPhaseID='NUR'
--Does not include Transfers Out to Tailender Groups 
and i.acct in ('PIG TRANSFER OUT') and pg2.PigProdPhaseID<>'TEF'
group by i.PigGroupID,
pg.PigProdPhaseID,pg.CostFlag,
pg.PGStatusID, pg.PigSystemID
order by i.PigGroupID
-- 06 Create insert SLF Total TransfersOut

-- 07 Create Insert SLF TransferIN Pig Days
TRUNCATE TABLE  dbo.cft_SLF_TRANSFERIN_PIGDAYS
INSERT INTO  dbo.cft_SLF_TRANSFERIN_PIGDAYS
(PigGroupID,
SourcePigGroupID,
TransferQty,
TransferInPigDays)

select tipd.PigGroupID,tipd.SourcePigGroupID,
SUM(tipd.Qty) as TransferQty,
SUM(tipd.TransferInPigDays) as TransferInPigDays
from (
	select i.PigGroupID,
	gStart.TranDate as SourceStartDate,
	i.SourcePigGroupID,i.Qty,i.TranDate as TransferDate,i.TranSubTypeID,
	cast(DATEDIFF(DAY,gStart.TranDate,i.TranDate) as float) as DaysInGroup,
	cast(DATEDIFF(DAY,gStart.TranDate,i.TranDate) as float)*i.Qty as TransferInPigDays
	from  [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	on i.PigGroupID=pg.PigGroupID and i.Reversal<>1 and i.acct = 'PIG TRANSFER IN'
	and i.trantypeid <> 'ia'
	and LEFT(i.TranSubTypeID,1)<>'S'
	left join [$(SolomonApp)].dbo.vCFPigGroupStart as gStart WITH (NOLOCK)
	on gStart.PigGroupID=i.SourcePigGroupID
	where pg.CostFlag='2' and pg.PGStatusID='I'
) tipd
where tipd.PigGroupID is not null
group by tipd.PigGroupID,tipd.SourcePigGroupID
having SUM(tipd.TransferInPigDays) is not null
order by tipd.PigGroupID,tipd.SourcePigGroupID
-- 07 Create Insert SLF TransferIN Pig Days

--08 Create Insert SLF TransferOut Pig Days
TRUNCATE TABLE  dbo.cft_SLF_TRANSFEROUT_PIGDAYS
INSERT INTO  dbo.cft_SLF_TRANSFEROUT_PIGDAYS
(PigGroupID,
TransferOutPigDays)

select
rtrim(pg.PigGroupID) AS PigGroupID,
sum((cast(pit.Trandate as float)-(cast(gStart.TranDate as float)))* Pit.qty * pit.InvEffect * -1) as TransferOutPigDays
from [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit
on pit.PigGroupID = pg.PigGroupID
left join [$(SolomonApp)].dbo.vCFPigGroupStart as gStart WITH (NOLOCK)
on gStart.PigGroupID=pg.PigGroupID
where pit.trantypeid <> 'ia' and pit.Reversal <> 1 and pit.acct in ('PIG TRANSFER OUT','PIG SALE')
and pg.PigProdPhaseID<>'NUR'
and pg.CostFlag='2' and pg.PGStatusID='I'
group by pg.PigGroupID
UNION
select
rtrim(pg.PigGroupID) AS PigGroupID,
sum((cast(pit.Trandate as float)-(cast(gStart.TranDate as float)))* Pit.qty * pit.InvEffect * -1) as TransferOutPigDays
from [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran as pit
on pit.PigGroupID = pg.PigGroupID
left join [$(SolomonApp)].dbo.vCFPigGroupStart as gStart WITH (NOLOCK)
on gStart.PigGroupID=pg.PigGroupID
where pit.trantypeid <> 'ia' and pit.Reversal <> 1 and pit.acct in ('PIG TRANSFER OUT')
and pg.PigProdPhaseID='NUR'
and pg.CostFlag='2' and pg.PGStatusID='I'
group by pg.PigGroupID
order by PigGroupID
--08 Create Insert SLF TransferOut Pig Days

--09  Create Insert SLF TransferIN Weight Gained
TRUNCATE TABLE  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED
INSERT INTO  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED
(PigGroupID,
SourcePigGroupID,
Qty,
TotalWgt,
AvgWgtOut,
AvgStartWgt,
WgtGained)
--WeightGained of Destination Group for Allocation by Weight Gained method 
select i.PigGroupID,
i.SourcePigGroupID,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
sum(i.TotalWgt)/sum(i.Qty) as AvgWgtOut,i2.AvgStartWgt,
((sum(i.TotalWgt)/sum(i.Qty))-i2.AvgStartWgt)*sum(i.Qty) as WgtGained
from  [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
on i.PigGroupID=pg.PigGroupID and i.Reversal<>1 and i.acct = 'PIG TRANSFER IN'
left join (
	select PigGroupID,
	sum(TotalWgt)/sum(Qty) as AvgStartWgt
	from [$(SolomonApp)].dbo.cftPGInvTran WITH (NOLOCK)
	where Reversal<>1 and acct in ('PIG TRANSFER IN')
	group by PigGroupID) i2
on i2.PigGroupID=i.SourcePigGroupID
where pg.PigProdPhaseID in ('NUR','WTF','FIN') and pg.CostFlag='2'
and i.SourcePigGroupID<>''
group by i.PigGroupID,i.SourcePigGroupID,i2.AvgStartWgt
having i2.AvgStartWgt is not null
order by i.PigGroupID,i.SourcePigGroupID
--09  Create Insert SLF TransferIN Weight Gained

--10  Create Insert SLF TransferOut Weight Gained
TRUNCATE TABLE  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED
INSERT INTO  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED
(PigGroupID,
WgtGainedTotal)

--WeightGained of Source Group for Allocation by Weight Gained method 
select a.PigGroupID,
((SUM(a.TotalWgtOut)/SUM(a.QtyOut))-(SUM(a.TotalWgtIn)/SUM(a.QtyIn)))*SUM(a.QtyOut) as WtGainedTotal
from (
	select i.PigGroupID,
	case when i.acct='PIG TRANSFER IN' then sum(i.Qty) end as QtyIn,
	case when i.acct='PIG TRANSFER IN' then sum(i.TotalWgt) end as TotalWgtIn,
	case when i.acct in ('PIG TRANSFER OUT','PIG SALE') then sum(i.Qty) end as QtyOut,
	case when i.acct in ('PIG TRANSFER OUT','PIG SALE') then sum(i.TotalWgt) end as TotalWgtOut
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	on pg.PigGroupID=i.PigGroupID
	where i.Reversal<>1 and i.acct in ('PIG TRANSFER IN','PIG TRANSFER OUT','PIG SALE') and pg.PigProdPhaseID<>'NUR'
	group by i.PigGroupID,i.acct
	UNION
	select i.PigGroupID,
	case when i.acct='PIG TRANSFER IN' then sum(i.Qty) end as QtyIn,
	case when i.acct='PIG TRANSFER IN' then sum(i.TotalWgt) end as TotalWgtIn,
	case when i.acct in ('PIG TRANSFER OUT') then sum(i.Qty) end as QtyOut,
	case when i.acct in ('PIG TRANSFER OUT') then sum(i.TotalWgt) end as TotalWgtOut
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	on pg.PigGroupID=i.PigGroupID
	where i.Reversal<>1 and i.acct in ('PIG TRANSFER IN','PIG TRANSFER OUT') and pg.PigProdPhaseID='NUR'
	group by i.PigGroupID,i.acct
	) a
group by a.PigGroupID
having (SUM(a.QtyIn) is not null) and (SUM(a.QtyOut) is not null)
order by a.PigGroupID
--10  Create Insert SLF TransferOut Weight Gained

--11  Create Final Pig Groups
create table #pgs
(
PigGroupID char(10) not null,
PigProdPhaseID char(3) not null,
acct char(16) not null,
MasterGroup char(10) not null,
PGStatusID char(2) not null,
CostFlag smallint not null,
ActCloseDate smalldatetime not null
);

INSERT INTO #pgs
(
PigGroupID,
PigProdPhaseID,
acct,
MasterGroup,
PGStatusID,
CostFlag,
ActCloseDate
)
--FIN and WTF groups that had pigs sold (start for FINAL Pig Groups list)
select distinct
pg.PigGroupID, pg.PigProdPhaseID,it.acct,pg.CF03 as MasterGroup,pg.PGStatusID,pg.CostFlag, pg.ActCloseDate
from [$(SolomonApp)].dbo.cftPGInvTran it WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=it.PigGroupID
where it.Acct='PIG SALE'
and it.Reversal<>'1'
and pg.PGStatusID = 'I'
and pg.PigSystemID = '00'
and PigProdPhaseID in ('FIN','WTF')
and pg.CostFlag='2'
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and it.PigGroupID not in ( -- Ignore all the stub CF pig groups closed out at the sale to SBF 2/6/2016
 56024, 56023, 56022, 56278, 56276, 56275, 56279, 56277, 55696, 55697, 55698, 55699, 57231, 57230, 57229, 57115,
 57116, 57117, 56989, 56990, 56992, 56991, 56295, 57225, 57224, 56110, 56109, 56108, 56431, 56432, 56433, 56434,
 57336, 57337, 57338, 57339, 57246, 57247, 57248, 56684, 56683, 56685, 57222, 57223, 56552, 56768, 56553, 55910,
 55989, 56798, 56800, 57012, 57013, 57015, 54794, 56655, 57172, 55226, 56642, 56643, 57438, 57633, 56735, 57634,
 56040, 56201, 56202, 56710, 56918, 56785, 56786, 56788, 56789, 56790, 57145, 56919, 57391, 57392, 56993, 56994,
 57086, 57085, 57088, 57087, 55928, 55929, 55930, 55937, 55938, 56092, 56093, 57393, 56854, 56855, 56856, 57209,
 57210, 56368, 56369, 56557, 56558, 56559, 56039, 56200, 56199, 56149, 56150, 56930, 56931, 56932, 56933, 55417,
 55676, 55863, 56244, 57328, 57327, 55922, 55925, 55927, 57365, 57485, 57483, 57484, 56456, 56203, 56457, 56796,
 57140, 57143, 57141, 57142, 56621, 56623, 56620, 56622, 57137, 57139, 57138, 57136, 56436, 56435, 56437, 56702,
 56703, 56604, 56605, 56606, 57144, 56527, 56528, 56529, 56530, 56897, 56900, 56898, 56899, 55642, 55223, 55224,
 56476, 56408, 56407, 56377, 56378, 56376, 56375, 56667, 56668, 56882, 56883, 57372, 57373, 57375, 57374, 57390,
 57389, 56917, 57341, 57342, 57340, 56594, 56595, 56596, 56220, 56222, 56221, 56857, 56858, 56887, 56886, 57061,
 57377, 57376, 57378, 56050, 56819, 56818, 56820, 56159, 56761, 56398, 56170, 56160, 56161, 56958, 56572, 56480,
 56727, 57418, 55962, 55961, 55963, 56062, 56063, 56064, 57234, 57233, 57232, 56076, 56078, 56079, 56077, 56570,
 56571, 57177, 57178, 57179, 56871, 56870, 55613, 57043, 57044, 57045, 55924, 55926, 57585, 56366, 56367, 56556,
 55936, 56399, 56795, 56797, 56799, 57054, 57050, 57052, 57051, 57053, 57304, 57977, 56095, 56014, 56096, 54876,
 54877, 56701, 56700, 56880, 56878, 56879, 56881, 55436, 55435, 55434, 55234, 55235, 55236, 56708, 56709, 56045,
 56171, 56172, 56310, 56658, 57305, 58079, 57480, 57479, 57487, 57486, 57636
    )
order by pg.PigGroupID

truncate table  dbo.cft_SLF_FINAL_PIG_GROUPS

INSERT INTO  dbo.cft_SLF_FINAL_PIG_GROUPS
(
PigGroupID,
PigProdPhaseID,
ActCloseDate,
PGStatusID,
CostFlag,
PigSystemID,
MasterGroup,
MGActCloseDate
)

select s.PigGroupID,s.PigProdPhaseID,s.ActCloseDate,s.PGStatusID,s.CostFlag,pg.PigSystemID,
mg.MasterGroup,mg.MGActCloseDate
from #pgs s
left join [$(SolomonApp)].dbo.cftPigGroup pg 
on pg.PigGroupID=s.PigGroupID
left join (
	select CF03 MasterGroup,MAX(ActCloseDate) MGActCloseDate
	from [$(SolomonApp)].dbo.cftPigGroup WITH (NOLOCK)
	where PGStatusID='I' and CostFlag='2'
	group by CF03
	) mg
on mg.MasterGroup=pg.CF03
order by s.PigGroupID

DROP TABLE #pgs
--11  Create Final Pig Groups

--12  Create Insert SLF Pig Groups Gen2
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN2

INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN2
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)

--Pigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,pg.MasterGroup,
pg.MGActCloseDate,--dd.FYPeriod,
pg.PigProdPhaseID as DestPhase,i.acct,
sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,pg2.CostFlag as SourceCostFlag,
pg2.PGStatusID as SourcePGStatusID, pg2.PigSystemID as SourcePigSystemID
from  dbo.cft_SLF_FINAL_PIG_GROUPS pg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr WITH (NOLOCK)
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.SourcePigGroupID not in (select PigGroupID from  dbo.cft_SLF_CIRCULAR_PIG_GROUPS WITH (NOLOCK))
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
pg.PigGroupID,pg.MasterGroup,pg.PigProdPhaseID,i.acct,i.SourcePigGroupID,tr.Qty,tr.TotalWgt,
pg2.PigProdPhaseID, pg2.CostFlag, pg2.PGStatusID, pg2.PigSystemID,
i.SourceProject,pg.MGActCloseDate
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--12  Create Insert SLF Pig Groups Gen2

--13  Create Insert SLF Pig Groups Gen3
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN3

INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN3
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)

--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from  dbo.cft_SLF_PIG_GROUPS_GEN2) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from  dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--13  Create Insert SLF Pig Groups Gen3


--14  Create Insert SLF Pig Groups Gen4
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN4


INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN4
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)

--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from dbo.cft_SLF_PIG_GROUPS_GEN3) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--14  Create Insert SLF Pig Groups Gen4


--15  Create Insert SLF Pig Groups Gen5
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN5


INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN5
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)
--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from dbo.cft_SLF_PIG_GROUPS_GEN4) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--15  Create Insert SLF Pig Groups Gen5


--16  Create Insert SLF Pig Groups Gen6
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN6

INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN6
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)

--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from dbo.cft_SLF_PIG_GROUPS_GEN5) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--16  Create Insert SLF Pig Groups Gen6


--17  Create Insert SLF Pig Groups Gen7
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN7

INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN7
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)
--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from dbo.cft_SLF_PIG_GROUPS_GEN6) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--17  Create Insert SLF Pig Groups Gen7


--18  Create Insert SLF Pig Groups Gen8
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN8

INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN8
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)
--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from dbo.cft_SLF_PIG_GROUPS_GEN7) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--18  Create Insert SLF Pig Groups Gen8


--19  Create Insert SLF Pig Groups Gen9
TRUNCATE table  dbo.cft_SLF_PIG_GROUPS_GEN9

INSERT INTO  dbo.cft_SLF_PIG_GROUPS_GEN9
(CombPigGroupID,
PigGroupID,
MasterGroup,
MGActCloseDate,
DestPhase,
acct,
Qty,
TotalWgt,
SourcePigGroupID,
SourceProject,
SourceHC_TO,
SourceWt_TO,
SourcePhase,
SourceCostFlag,
SourcePGStatusID,
SourcePigSystemID
)
--WeanPigs into FINAL Groups from preceding PigGroups
select rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID) as CombPigGroupID,pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,
pg.Phase as DestPhase,
i.acct,sum(i.Qty) as Qty,sum(i.TotalWgt) as TotalWgt,
i.SourcePigGroupID,i.SourceProject,
tr.Qty as 'SourceHC_TO',tr.TotalWgt  as 'SourceWt_TO',
pg2.PigProdPhaseID as SourcePhase,
pg2.CostFlag as SourceCostFlag, pg2.PGStatusID as SourcePGStatusID,pg2.PigSystemID as SourcePigSystemID
from
	(select distinct SourcePigGroupID as PigGroupID,MasterGroup,MGActCloseDate,SourcePhase as Phase
	from dbo.cft_SLF_PIG_GROUPS_GEN8) pg
left join [$(SolomonApp)].dbo.cftPGInvTran i
on i.PigGroupID=pg.PigGroupID
left join [$(SolomonApp)].dbo.cftPigGroup pg2
on pg2.PigGroupID=i.SourcePigGroupID
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT tr
on tr.PigGroupID=i.SourcePigGroupID
where i.acct='PIG TRANSFER IN' and i.Reversal<>1
and (i.SourcePigGroupID<>'' or i.SourceProject<>'')
and i.PigGroupID not in (select PigGroupID from dbo.cft_SLF_CIRCULAR_PIG_GROUPS)
and pg.PigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
and i.SourcePigGroupID not in (
	select distinct PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran
	where acct='PIG TRANSFER IN' and Reversal<>1
	and SourceProject='' and SourcePigGroupID='')
group by
rtrim(i.SourcePigGroupID)+'-'+rtrim(pg.PigGroupID),pg.PigGroupID,
pg.MasterGroup,pg.MGActCloseDate,pg.Phase,i.acct,i.SourcePigGroupID,i.SourceProject,
tr.Qty,tr.TotalWgt,pg2.PigProdPhaseID,pg2.CostFlag, pg2.PGStatusID,pg2.PigSystemID
order by pg.MasterGroup,pg.PigGroupID,i.SourcePigGroupID
--19  Create Insert SLF Pig Groups Gen9


--20  SLF Genarational Raw Data
TRUNCATE table  dbo.cft_SLF_GENERATIONAL_DATA_RAW

INSERT INTO  dbo.cft_SLF_GENERATIONAL_DATA_RAW
(SLF_Status,
G1_PigGroupID,
G1_MasterGroup,
MGActCloseDate,
G1_Phase,
G2_PigGroupID,
G2_Project,
G2_Phase,
G2_Cost,
G2_Status,
G2_System,
G3_PigGroupID,
G3_Project,
G3_Phase,
G3_Cost,
G3_Status,
G3_System,
G4_PigGroupID,
G4_Project,
G4_Phase,
G4_Cost,
G4_Status,
G4_System,
G5_PigGroupID,
G5_Project,
G5_Phase,
G5_Cost,
G5_Status,
G5_System,
G6_PigGroupID,
G6_Project,
G6_Phase,
G6_Cost,
G6_Status,
G6_System,
G7_PigGroupID,
G7_Project,
G7_Phase,
G7_Cost,
G7_Status,
G7_System,
G8_PigGroupID,
G8_Project,
G8_Phase,
G8_Cost,
G8_Status,
G8_System,
G9_PigGroupID,
G9_Project,
G9_Phase,
G9_Cost,
G9_Status,
G9_System)



select
'' as SLF_Status, 
fpg.PigGroupID as G1_PigGroupID,
fpg.MasterGroup as G1_MasterGroup,
fpg.MGActCloseDate,
fpg.PigProdPhaseID as G1_Phase,
g2.SourcePigGroupID as G2_PigGroupID,g2.SourceProject as G2_Project,g2.SourcePhase as G2_Phase,g2.SourceCostFlag as G2_Cost,g2.SourcePGStatusID as G2_Status,g2.SourcePigSystemID as G2_System,
g3.SourcePigGroupID as G3_PigGroupID,g3.SourceProject as G3_Project,g3.SourcePhase as G3_Phase,g3.SourceCostFlag as G3_Cost,g3.SourcePGStatusID as G3_Status,g3.SourcePigSystemID as G3_System,
g4.SourcePigGroupID as G4_PigGroupID,g4.SourceProject as G4_Project,g4.SourcePhase as G4_Phase,g4.SourceCostFlag as G4_Cost,g4.SourcePGStatusID as G4_Status,g4.SourcePigSystemID as G4_System,
g5.SourcePigGroupID as G5_PigGroupID,g5.SourceProject as G5_Project,g5.SourcePhase as G5_Phase,g5.SourceCostFlag as G5_Cost,g5.SourcePGStatusID as G5_Status,g5.SourcePigSystemID as G5_System,
g6.SourcePigGroupID as G6_PigGroupID,g6.SourceProject as G6_Project,g6.SourcePhase as G6_Phase,g6.SourceCostFlag as G6_Cost,g6.SourcePGStatusID as G6_Status,g6.SourcePigSystemID as G6_System,
g7.SourcePigGroupID as G7_PigGroupID,g7.SourceProject as G7_Project,g7.SourcePhase as G7_Phase,g7.SourceCostFlag as G7_Cost,g7.SourcePGStatusID as G7_Status,g7.SourcePigSystemID as G7_System,
g8.SourcePigGroupID as G8_PigGroupID,g8.SourceProject as G8_Project,g8.SourcePhase as G8_Phase,g8.SourceCostFlag as G8_Cost,g8.SourcePGStatusID as G8_Status,g8.SourcePigSystemID as G8_System,
g9.SourcePigGroupID as G9_PigGroupID,g9.SourceProject as G9_Project,g9.SourcePhase as G9_Phase,g9.SourceCostFlag as G9_Cost,g9.SourcePGStatusID as G9_Status,g9.SourcePigSystemID as G9_System
from dbo.cft_SLF_FINAL_PIG_GROUPS fpg
left join dbo.cft_SLF_PIG_GROUPS_GEN2 g2
on g2.PigGroupID=fpg.PigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN3 g3
on g3.PigGroupID=g2.SourcePigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN4 g4
on g4.PigGroupID=g3.SourcePigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN5 g5
on g5.PigGroupID=g4.SourcePigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN6 g6
on g6.PigGroupID=g5.SourcePigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN7 g7
on g7.PigGroupID=g6.SourcePigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN8 g8
on g8.PigGroupID=g7.SourcePigGroupID
left join dbo.cft_SLF_PIG_GROUPS_GEN9 g9
on g9.PigGroupID=g8.SourcePigGroupID
order by fpg.MasterGroup,fpg.PigGroupID
--20  SLF Genarational Raw Data


--21 Update SLF  Generational Data Raw, Set SLF_Status = 'F'
UPDATE  dbo.cft_SLF_GENERATIONAL_DATA_RAW
SET SLF_Status='F'
where G1_PigGroupID in (
select distinct G1_PigGroupID from dbo.cft_SLF_GENERATIONAL_DATA_RAW
where (G2_Cost<>2 or G3_Cost<>2 or G4_Cost<>2 or G5_Cost<>2 or G6_Cost<>2 or G7_Cost<>2 or G8_Cost<>2 or G9_Cost<>2)
or (G2_Status<>'I' or G3_Status<>'I' or G4_Status<>'I' or G5_Status<>'I' or G6_Status<>'I' or G7_Status<>'I' or G8_Status<>'I' or G9_Status<>'I')
)
--21 Update SLF  Generational Data Raw, Set SLF_Status = 'F' 


--22  Create Insert Phase Groups Tables
TRUNCATE table  dbo.cft_SLF_TWOPHASE_GROUPS

insert into  dbo.cft_SLF_TWOPHASE_GROUPS
(G1_PigGroupID,G2_PigGroupID)
--TWO PHASE PigGroups
select p1.G1_PigGroupID,p1.G2_PigGroupID from (
select distinct G1_PigGroupID,G2_PigGroupID
from dbo.cft_SLF_GENERATIONAL_DATA_RAW
where SLF_Status=''
group by G1_PigGroupID,G2_PigGroupID
having MAX(G2_PigGroupID)<>'' and MAX(G3_PigGroupID)='') p1
order by p1.G1_PigGroupID,p1.G2_PigGroupID

TRUNCATE table  dbo.cft_SLF_THREEPHASE_GROUPS

insert into  dbo.cft_SLF_THREEPHASE_GROUPS
(G1_PigGroupID,G2_PigGroupID,G3_PigGroupID)
--THREE PHASE PigGroups
select p1.G1_PigGroupID,p1.G2_PigGroupID,p1.G3_PigGroupID from (
select distinct G1_PigGroupID,G2_PigGroupID,G3_PigGroupID
from dbo.cft_SLF_GENERATIONAL_DATA_RAW
where SLF_Status=''
group by G1_PigGroupID,G2_PigGroupID,G3_PigGroupID
having MAX(G2_PigGroupID)<>'' and MAX(G3_PigGroupID)<>'' and MAX(G4_PigGroupID)='') p1
order by p1.G1_PigGroupID,p1.G2_PigGroupID,p1.G3_PigGroupID

TRUNCATE table  dbo.cft_SLF_FOURPHASE_GROUPS

insert into  dbo.cft_SLF_FOURPHASE_GROUPS
(G1_PigGroupID,G2_PigGroupID,G3_PigGroupID,G4_PigGroupID)
--FOUR PHASE PigGroups
select p1.G1_PigGroupID,p1.G2_PigGroupID,p1.G3_PigGroupID,p1.G4_PigGroupID from (
select distinct G1_PigGroupID,G2_PigGroupID,G3_PigGroupID,G4_PigGroupID
from dbo.cft_SLF_GENERATIONAL_DATA_RAW
where SLF_Status=''
group by G1_PigGroupID,G2_PigGroupID,G3_PigGroupID,G4_PigGroupID
having MAX(G2_PigGroupID)<>'' and MAX(G3_PigGroupID)<>'' and MAX(G4_PigGroupID)<>'' and MAX(G5_PigGroupID)='') p1
order by p1.G1_PigGroupID,p1.G2_PigGroupID,p1.G3_PigGroupID,p1.G4_PigGroupID

TRUNCATE table  dbo.cft_SLF_FIVEPHASE_GROUPS

insert into  dbo.cft_SLF_FIVEPHASE_GROUPS
(G1_PigGroupID,G2_PigGroupID,G3_PigGroupID,G4_PigGroupID,G5_PigGroupID)
--FIVE PHASE PigGroups
select p1.G1_PigGroupID,p1.G2_PigGroupID,p1.G3_PigGroupID,p1.G4_PigGroupID,p1.G5_PigGroupID from (
select distinct G1_PigGroupID,G2_PigGroupID,G3_PigGroupID,G4_PigGroupID,G5_PigGroupID
from dbo.cft_SLF_GENERATIONAL_DATA_RAW
where SLF_Status=''
group by G1_PigGroupID,G2_PigGroupID,G3_PigGroupID,G4_PigGroupID,G5_PigGroupID
having MAX(G2_PigGroupID)<>'' and MAX(G3_PigGroupID)<>'' and MAX(G4_PigGroupID)<>'' and MAX(G5_PigGroupID)<>'' and MAX(G6_PigGroupID)='') p1
order by p1.G1_PigGroupID,p1.G2_PigGroupID,p1.G3_PigGroupID,p1.G4_PigGroupID,p1.G5_PigGroupID
--22  Create Insert Phase Groups Tables


--23 Create Insert SLF TWO Phase Compositions
TRUNCATE TABLE  dbo.cft_SLF_TWOPHASE_COMPOSITION
INSERT INTO  dbo.cft_SLF_TWOPHASE_COMPOSITION
(CombPigGroupID,
G1_PigGroupID,
G1G2_Qty,
G1G2_TotalWgt,
G1G2_WgtGained,
G1G2_PigDays,
G1G2_HC_Pct,
G1G2_WT_Pct,
G1G2_WG_Pct,
G1G2_PD_Pct,
G2_Qty,
G2_TotalWgt,
G2_WgtGained,
G2_PigDays,
G2_PigGroupID
)

select
'FG'+rtrim(g.G2_PigGroupID)+'-'+rtrim(g.G1_PigGroupID) as CombPigGroupID,
g.G1_PigGroupID,sum(i.Qty) as G1G2_Qty,SUM(i.TotalWgt) as G1G2_TotalWgt,
tiwg.WgtGained as G1G2_WgtGained,
tipd.TransferInPigDays G1G2_PigDays,
sum(cast(i.Qty as float))/cast(t.Qty as float) as G1G2_HC_Pct,
SUM(i.TotalWgt)/t.TotalWgt as G1G2_WT_Pct,
tiwg.WgtGained/towg.WgtGainedTotal as G1G2_WG_Pct,
SUM(tipd.TransferInPigDays)/SUM(tpd.TransferOutPigDays) as G1G2_PD_Pct,
t.Qty as G2_Qty,
t.TotalWgt as G2_TotalWgt,
towg.WgtGainedTotal as G2_WgtGained,
tpd.TransferOutPigDays as G2_PigDays,
g.G2_PigGroupID
from  dbo.cft_SLF_TWOPHASE_GROUPS g WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
on i.Reversal<>1 and g.G1_PigGroupID=i.PigGroupID and g.G2_PigGroupID=i.SourcePigGroupID and i.acct = 'PIG TRANSFER IN'
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t WITH (NOLOCK)
on t.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd WITH (NOLOCK)
on tpd.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd WITH (NOLOCK)
on tipd.PigGroupID=g.G1_PigGroupID and tipd.SourcePigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg WITH (NOLOCK)
on towg.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg WITH (NOLOCK)
on tiwg.PigGroupID=g.G1_PigGroupID and tiwg.SourcePigGroupID=g.G2_PigGroupID
group by g.G1_PigGroupID,g.G2_PigGroupID,t.Qty,t.TotalWgt,tiwg.WgtGained,
tipd.TransferInPigDays,towg.WgtGainedTotal,
tpd.TransferOutPigDays
order by CombPigGroupID
--23 Create Insert SLF TWO Phase Compositions


--24 Create Insert SLF TWO Phase Compositions
TRUNCATE TABLE  dbo.cft_SLF_THREEPHASE_COMPOSITION
INSERT INTO  dbo.cft_SLF_THREEPHASE_COMPOSITION
(CombPigGroupID,
G1_PigGroupID,
G1G2_Qty,
G1G2_TotalWgt,
G1G2_WgtGained,
G1G2_PigDays,
G1G2_HC_Pct,
G1G2_WT_Pct,
G1G2_WG_Pct,
G1G2_PD_Pct,
G2_Qty,
G2_TotalWgt,
G2_WgtGained,
G2_PigDays,
G2_PigGroupID,
G2G3_Qty,
G2G3_TotalWgt,
G2G3_WgtGained,
G2G3_PigDays,
G2G3_HC_Pct,
G2G3_WT_Pct,
G2G3_WG_Pct,
G2G3_PD_Pct,
G3_Qty,
G3_TotalWgt,
G3_WgtGained,
G3_PigDays,
G3_PigGroupID
)
select
'FG'+rtrim(g.G3_PigGroupID)+'-'+rtrim(g.G2_PigGroupID)+'-'+rtrim(g.G1_PigGroupID) as CombPigGroupID,
g.G1_PigGroupID,sum(i.Qty) as G1G2_Qty,
SUM(i.TotalWgt) as G1G2_TotalWgt,
tiwg.WgtGained as G1G2_WgtGained,
tipd.TransferInPigDays G1G2_PigDays,
sum(cast(i.Qty as float))/cast(t.Qty as float) as G1G2_HC_Pct,
SUM(i.TotalWgt)/t.TotalWgt as G1G2_WT_Pct,
tiwg.WgtGained/towg.WgtGainedTotal as G1G2_WG_Pct,
SUM(tipd.TransferInPigDays)/SUM(tpd.TransferOutPigDays) as G1G2_PD_Pct,
t.Qty as G2_Qty,
t.TotalWgt as G2_TotalWgt,
towg.WgtGainedTotal as G2_WgtGained,
tpd.TransferOutPigDays as G2_PigDays,g.G2_PigGroupID,
j.G2G3_Qty,j.G2G3_TotalWgt,j.G2G3_WgtGained,j.G2G3_PigDays,j.G2G3_HC_Pct,j.G2G3_WT_Pct,j.G2G3_WG_Pct,j.G2G3_PD_Pct,
j.G3_Qty,j.G3_TotalWgt,j.G3_WgtGained,j.G3_PigDays,
g.G3_PigGroupID
from  dbo.cft_SLF_THREEPHASE_GROUPS g WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
on i.Reversal<>1 and g.G1_PigGroupID=i.PigGroupID and g.G2_PigGroupID=i.SourcePigGroupID and i.acct = 'PIG TRANSFER IN'
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t WITH (NOLOCK)
on t.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd WITH (NOLOCK)
on tpd.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd WITH (NOLOCK)
on tipd.PigGroupID=g.G1_PigGroupID and tipd.SourcePigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg WITH (NOLOCK)
on towg.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg WITH (NOLOCK)
on tiwg.PigGroupID=g.G1_PigGroupID and tiwg.SourcePigGroupID=g.G2_PigGroupID
left join (
	select g.G1_PigGroupID,g.G2_PigGroupID,sum(i2.Qty) as G2G3_Qty,
	sum(i2.TotalWgt) as G2G3_TotalWgt,tiwg2.WgtGained as G2G3_WgtGained,
	tipd2.TransferInPigDays as G2G3_PigDays,
	sum(cast(i2.Qty as float))/cast(t2.Qty as float) as G2G3_HC_Pct,
	sum(i2.TotalWgt)/t2.TotalWgt as G2G3_WT_Pct,
-- TNT: tiwg2.WgtGained/towg2.WgtGainedTotal as G2G3_WG_Pct,
	case when towg2.WgtGainedTotal = 0 then 0 else tiwg2.WgtGained/towg2.WgtGainedTotal End as G2G3_WG_Pct,
	sum(tipd2.TransferInPigDays)/sum(tpd2.TransferOutPigDays) as G2G3_PD_Pct,
	t2.Qty as G3_Qty,t2.TotalWgt as G3_TotalWgt,towg2.WgtGainedTotal as G3_WgtGained,
	tpd2.TransferOutPigDays as G3_PigDays,g.G3_PigGroupID
	from  dbo.cft_SLF_THREEPHASE_GROUPS g WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.Reversal<>1 and g.G2_PigGroupID=i2.PigGroupID and g.G3_PigGroupID=i2.SourcePigGroupID and i2.acct = 'PIG TRANSFER IN'
	left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t2 WITH (NOLOCK)
	on t2.PigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd2 WITH (NOLOCK)
	on tpd2.PigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd2 WITH (NOLOCK)
	on tipd2.PigGroupID=g.G2_PigGroupID and tipd2.SourcePigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg2 WITH (NOLOCK)
	on towg2.PigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg2 WITH (NOLOCK)
	on tiwg2.PigGroupID=g.G2_PigGroupID and tiwg2.SourcePigGroupID=g.G3_PigGroupID
	group by g.G1_PigGroupID,g.G2_PigGroupID,g.G3_PigGroupID,t2.Qty,t2.TotalWgt,
	tiwg2.WgtGained,tipd2.TransferInPigDays,towg2.WgtGainedTotal,tpd2.TransferOutPigDays
	) j
on j.G1_PigGroupID=g.G1_PigGroupID and j.G2_PigGroupID=g.G2_PigGroupID and j.G3_PigGroupID=g.G3_PigGroupID
group by g.G1_PigGroupID,g.G2_PigGroupID,g.G3_PigGroupID,
t.Qty,t.TotalWgt,tpd.TransferOutPigDays,tipd.TransferInPigDays,tiwg.WgtGained,towg.WgtGainedTotal,
j.G2G3_Qty,j.G2G3_TotalWgt,j.G2G3_WgtGained,j.G2G3_PigDays,j.G3_Qty,j.G3_TotalWgt,j.G3_WgtGained,j.G3_PigDays,j.G2G3_HC_Pct,j.G2G3_WT_Pct,j.G2G3_WG_Pct,j.G2G3_PD_Pct
order by CombPigGroupID
--24 Create Insert SLF TWO Phase Compositions


--25 Create Insert SLF FOUR Phase Compositions
TRUNCATE TABLE  dbo.cft_SLF_FOURPHASE_COMPOSITION
INSERT INTO  dbo.cft_SLF_FOURPHASE_COMPOSITION
(CombPigGroupID,
G1_PigGroupID,
G1G2_Qty,
G1G2_TotalWgt,
G1G2_WgtGained,
G1G2_PigDays,
G1G2_HC_Pct,
G1G2_WT_Pct,
G1G2_WG_Pct,
G1G2_PD_Pct,
G2_Qty,
G2_TotalWgt,
G2_WgtGained,
G2_PigDays,
G2_PigGroupID,
G2G3_Qty,
G2G3_TotalWgt,
G2G3_WgtGained,
G2G3_PigDays,
G2G3_HC_Pct,
G2G3_WT_Pct,
G2G3_WG_Pct,
G2G3_PD_Pct,
G3_Qty,
G3_TotalWgt,
G3_WgtGained,
G3_PigDays,
G3_PigGroupID,
G3G4_Qty,
G3G4_TotalWgt,
G3G4_WgtGained,
G3G4_PigDays,
G3G4_HC_Pct,
G3G4_WT_Pct,
G3G4_WG_Pct,
G3G4_PD_Pct,
G4_Qty,
G4_TotalWgt,
G4_WgtGained,
G4_PigDays,
G4_PigGroupID
)
select
'FG'+rtrim(g.G4_PigGroupID)+'-'+rtrim(g.G3_PigGroupID)+'-'+rtrim(g.G2_PigGroupID)+'-'+rtrim(g.G1_PigGroupID) as CombPigGroupID,
g.G1_PigGroupID,sum(i.Qty) as G1G2_Qty,SUM(i.TotalWgt) as G1G2_TotalWgt,
tiwg.WgtGained as G1G2_WgtGained,tipd.TransferInPigDays G1G2_PigDays,
sum(cast(i.Qty as float))/cast(t.Qty as float) as G1G2_HC_Pct,
SUM(i.TotalWgt)/t.TotalWgt as G1G2_WT_Pct,
tiwg.WgtGained/towg.WgtGainedTotal as G1G2_WG_Pct,
SUM(tipd.TransferInPigDays)/SUM(tpd.TransferOutPigDays) as G1G2_PD_Pct,
t.Qty as G2_Qty,t.TotalWgt as G2_TotalWgt,towg.WgtGainedTotal as G2_WgtGained,
tpd.TransferOutPigDays as G2_PigDays,g.G2_PigGroupID,
j.G2G3_Qty,j.G2G3_TotalWgt,j.G2G3_WgtGained,
j.G2G3_PigDays,j.G2G3_HC_Pct,j.G2G3_WT_Pct,j.G2G3_WG_Pct,j.G2G3_PD_Pct,
j.G3_Qty,j.G3_TotalWgt,j.G3_WgtGained,j.G3_PigDays,
g.G3_PigGroupID,
k.G3G4_Qty,
k.G3G4_TotalWgt,
k.G3G4_WgtGained,
k.G3G4_PigDays,k.G3G4_HC_Pct,
k.G3G4_WT_Pct,
k.G3G4_WG_Pct,
k.G3G4_PD_Pct,
k.G4_Qty,
k.G4_TotalWgt,
k.G4_WgtGained,
k.G4_PigDays,
g.G4_PigGroupID
from  dbo.cft_SLF_FOURPHASE_GROUPS g WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
on i.Reversal<>1 and g.G1_PigGroupID=i.PigGroupID and g.G2_PigGroupID=i.SourcePigGroupID and i.acct = 'PIG TRANSFER IN'
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t WITH (NOLOCK)
on t.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd WITH (NOLOCK)
on tpd.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd WITH (NOLOCK)
on tipd.PigGroupID=g.G1_PigGroupID and tipd.SourcePigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg WITH (NOLOCK)
on towg.PigGroupID=g.G2_PigGroupID
left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg WITH (NOLOCK)
on tiwg.PigGroupID=g.G1_PigGroupID and tiwg.SourcePigGroupID=g.G2_PigGroupID
left join (
	select g.G1_PigGroupID,
	g.G2_PigGroupID,sum(i2.Qty) as G2G3_Qty,
	sum(i2.TotalWgt) as G2G3_TotalWgt,tiwg2.WgtGained as G2G3_WgtGained,
	tipd2.TransferInPigDays as G2G3_PigDays,
	sum(cast(i2.Qty as float))/cast(t2.Qty as float) as G2G3_HC_Pct,
	sum(i2.TotalWgt)/t2.TotalWgt as G2G3_WT_Pct,
	tiwg2.WgtGained/towg2.WgtGainedTotal as G2G3_WG_Pct,
	sum(tipd2.TransferInPigDays)/SUM(tpd2.TransferOutPigDays) as G2G3_PD_Pct,
	t2.Qty as G3_Qty,t2.TotalWgt as G3_TotalWgt,towg2.WgtGainedTotal as G3_WgtGained,
	tpd2.TransferOutPigDays as G3_PigDays,g.G3_PigGroupID,g.G4_PigGroupID
	from  dbo.cft_SLF_FOURPHASE_GROUPS g WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.Reversal<>1 and g.G2_PigGroupID=i2.PigGroupID and g.G3_PigGroupID=i2.SourcePigGroupID and i2.acct = 'PIG TRANSFER IN'
	left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t2 WITH (NOLOCK)
	on t2.PigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd2 WITH (NOLOCK)
	on tpd2.PigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd2 WITH (NOLOCK)
	on tipd2.PigGroupID=g.G2_PigGroupID and tipd2.SourcePigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg2 WITH (NOLOCK)
	on towg2.PigGroupID=g.G3_PigGroupID
	left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg2 WITH (NOLOCK)
	on tiwg2.PigGroupID=g.G2_PigGroupID and tiwg2.SourcePigGroupID=g.G3_PigGroupID
	group by g.G1_PigGroupID,g.G2_PigGroupID,g.G3_PigGroupID,g.G4_PigGroupID,t2.Qty,tiwg2.WgtGained,t2.TotalWgt,
	tipd2.TransferInPigDays,towg2.WgtGainedTotal,tpd2.TransferOutPigDays
	) j
on j.G1_PigGroupID=g.G1_PigGroupID and j.G2_PigGroupID=g.G2_PigGroupID and j.G3_PigGroupID=g.G3_PigGroupID and j.G4_PigGroupID=g.G4_PigGroupID
left join (
	select g.G1_PigGroupID,	g.G2_PigGroupID,g.G3_PigGroupID,
	sum(i2.Qty) as G3G4_Qty,sum(i2.TotalWgt) as G3G4_TotalWgt,tiwg2.WgtGained as G3G4_WgtGained,
	tipd2.TransferInPigDays as G3G4_PigDays,
	sum(cast(i2.Qty as float))/cast(t2.Qty as float) as G3G4_HC_Pct,
	sum(i2.TotalWgt)/t2.TotalWgt as G3G4_WT_Pct,
	tiwg2.WgtGained/towg2.WgtGainedTotal as G3G4_WG_Pct,	
	sum(tipd2.TransferInPigDays)/SUM(tpd2.TransferOutPigDays) as G3G4_PD_Pct,	
	t2.Qty as G4_Qty,
	
	t2.TotalWgt as G4_TotalWgt,towg2.WgtGainedTotal as G4_WgtGained,
	
	tpd2.TransferOutPigDays as G4_PigDays,g.G4_PigGroupID
	from  dbo.cft_SLF_FOURPHASE_GROUPS g WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.Reversal<>1 and g.G3_PigGroupID=i2.PigGroupID and g.G4_PigGroupID=i2.SourcePigGroupID and i2.acct = 'PIG TRANSFER IN'
	left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t2 WITH (NOLOCK)
	on t2.PigGroupID=g.G4_PigGroupID
	left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd2 WITH (NOLOCK)
	on tpd2.PigGroupID=g.G4_PigGroupID
	left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd2 WITH (NOLOCK)
	on tipd2.PigGroupID=g.G3_PigGroupID and tipd2.SourcePigGroupID=g.G4_PigGroupID
	left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg2 WITH (NOLOCK)
	on towg2.PigGroupID=g.G4_PigGroupID
	left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg2 WITH (NOLOCK)
	on tiwg2.PigGroupID=g.G3_PigGroupID and tiwg2.SourcePigGroupID=g.G4_PigGroupID
	group by g.G1_PigGroupID,g.G2_PigGroupID,g.G3_PigGroupID,g.G4_PigGroupID,t2.Qty,tipd2.TransferInPigDays,tpd2.TransferOutPigDays,
	tiwg2.WgtGained,t2.TotalWgt,towg2.WgtGainedTotal
) k
on k.G1_PigGroupID=g.G1_PigGroupID and k.G2_PigGroupID=g.G2_PigGroupID and k.G3_PigGroupID=g.G3_PigGroupID and k.G4_PigGroupID=g.G4_PigGroupID
group by g.G1_PigGroupID,g.G2_PigGroupID,g.G3_PigGroupID,g.G4_PigGroupID,
t.Qty,t.TotalWgt,towg.WgtGainedTotal,tpd.TransferOutPigDays,tipd.TransferInPigDays,tiwg.WgtGained,j.G2G3_Qty,j.G2G3_TotalWgt,j.G2G3_WgtGained,
j.G2G3_PigDays,j.G3_Qty,j.G3_TotalWgt,j.G3_WgtGained,j.G3_PigDays,j.G2G3_HC_Pct,j.G2G3_WT_Pct,j.G2G3_WG_Pct,j.G2G3_PD_Pct,
k.G3G4_Qty,k.G3G4_TotalWgt,k.G3G4_WgtGained,k.G3G4_PigDays,k.G3G4_HC_Pct,k.G3G4_WT_Pct,k.G3G4_WG_Pct,k.G3G4_PD_Pct,k.G4_Qty,k.G4_TotalWgt,
k.G4_WgtGained,k.G4_PigDays,k.G4_PigGroupID
order by CombPigGroupID
--25 Create Insert SLF FOUR Phase Compositions

--26 Create Insert SLF ALL Compositions
--------------------------------------------------------------------
----Composition tables for All PigGroup to PigGroup Transfers-------
--------------------------------------------------------------------

TRUNCATE TABLE  dbo.cft_SLF_ALL_COMPOSITION
INSERT INTO  dbo.cft_SLF_ALL_COMPOSITION
(Source_PigGroupID,
Source_Qty,
Source_TotalWgt,
Source_WgtGained,
Source_PigDays,
HC_Pct,
WT_Pct,
WG_Pct,
PD_Pct,
Dest_Qty,
Dest_TotalWgt,
Dest_WgtGained,
Dest_PigDays,
Dest_PigGroupID
)

select
g.SourceGroup as Source_PigGroupID,
t.Qty as Source_Qty,
t.TotalWgt as Source_TotalWgt,
towg.WgtGainedTotal as Source_WgtGained,
tpd.TransferOutPigDays as Source_PigDays,
sum(cast(i.Qty as float))/cast(t.Qty as float) as HC_Pct,
SUM(i.TotalWgt)/t.TotalWgt as WT_Pct,
-- TNT: tiwg.WgtGained/towg.WgtGainedTotal as WG_Pct,
case when towg.WgtGainedTotal = 0 Then 0 else tiwg.WgtGained/towg.WgtGainedTotal END as WG_Pct,
SUM(tipd.TransferInPigDays)/SUM(tpd.TransferOutPigDays) as PD_Pct,
sum(i.Qty) as Dest_Qty,
SUM(i.TotalWgt) as Dest_TotalWgt,
tiwg.WgtGained as Dest_WgtGained,
tipd.TransferInPigDays Dest_PigDays,
g.DestGroup
from (
	select distinct z.SourceGroup,z.DestGroup from (
	select G2_PigGroupID as SourceGroup,G1_PigGroupID as DestGroup from dbo.cft_SLF_TWOPHASE_GROUPS
	UNION
	select G2_PigGroupID as SourceGroup,G1_PigGroupID as DestGroup from dbo.cft_SLF_THREEPHASE_GROUPS
	UNION
	select G3_PigGroupID as SourceGroup,G2_PigGroupID as DestGroup from dbo.cft_SLF_THREEPHASE_GROUPS
	UNION
	select G2_PigGroupID as SourceGroup,G1_PigGroupID as DestGroup from dbo.cft_SLF_FOURPHASE_GROUPS
	UNION
	select G3_PigGroupID as SourceGroup,G2_PigGroupID as DestGroup from dbo.cft_SLF_FOURPHASE_GROUPS
	UNION
	select G4_PigGroupID as SourceGroup,G3_PigGroupID as DestGroup from dbo.cft_SLF_FOURPHASE_GROUPS) z
	) g
left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
on i.Reversal<>1 and g.DestGroup=i.PigGroupID and g.SourceGroup=i.SourcePigGroupID and i.acct = 'PIG TRANSFER IN'
left join  dbo.cft_SLF_TOTAL_TRANSFEROUT t WITH (NOLOCK)
on t.PigGroupID=g.SourceGroup
left join  dbo.cft_SLF_TRANSFEROUT_PIGDAYS tpd WITH (NOLOCK)
on tpd.PigGroupID=g.SourceGroup
left join  dbo.cft_SLF_TRANSFERIN_PIGDAYS tipd WITH (NOLOCK)
on tipd.PigGroupID=g.DestGroup and tipd.SourcePigGroupID=g.SourceGroup
left join  dbo.cft_SLF_TRANSFEROUT_WEIGHTGAINED towg WITH (NOLOCK)
on towg.PigGroupID=g.SourceGroup
left join  dbo.cft_SLF_TRANSFERIN_WEIGHTGAINED tiwg WITH (NOLOCK)
on tiwg.PigGroupID=g.DestGroup and tiwg.SourcePigGroupID=g.SourceGroup
group by g.DestGroup,g.SourceGroup,t.Qty,t.TotalWgt,tiwg.WgtGained,
tipd.TransferInPigDays,towg.WgtGainedTotal,
tpd.TransferOutPigDays
order by g.SourceGroup
--26 Create Insert SLF ALL Compositions


--27 Create Insert SLF FlowGroup Compositions
--DROP TABLE  dbo.cft_SLF_FLOWGROUP_COMPOSITION

--We need to take out any PigGroups from cft_SLF_FINAL_PIG_GROUPS if the preceding PigGroups
--are not closed and costed.
DELETE from  dbo.cft_SLF_FINAL_PIG_GROUPS
where PigGroupID in (select distinct G1_PigGroupID from dbo.cft_SLF_GENERATIONAL_DATA_RAW
where SLF_Status='F')

TRUNCATE TABLE  dbo.cft_SLF_FLOWGROUP_COMPOSITION
INSERT INTO  dbo.cft_SLF_FLOWGROUP_COMPOSITION
(FlowGroup,
CombPigGroup,
SourceGroup,
HC_Pct,
WT_Pct,
WG_Pct,
PD_Pct
)

select distinct
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'PG'+rtrim(fpg.PigGroupID) as CombPigGroup,
fpg.PigGroupID as SourceGroup,
1 as HC_Pct,
1 as WT_Pct,
1 as WG_Pct,
1 as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
UNION
select distinct
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'FG'+rtrim(pg2.G2_PigGroupID)+'-'+rtrim(pg2.G1_PigGroupID) as CombPigGroup,
pg2.G2_PigGroupID as SourceGroup,
c12.HC_Pct as HC_Pct,
c12.WT_Pct as WT_Pct,
c12.WG_Pct as WG_Pct,
c12.PD_Pct as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join  dbo.cft_SLF_TWOPHASE_GROUPS pg2 WITH (NOLOCK)
on pg2.G1_PigGroupID=fpg.PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c12 WITH (NOLOCK)
on c12.Dest_PigGroupID=pg2.G1_PigGroupID and c12.Source_PigGroupID=pg2.G2_PigGroupID
where pg2.G1_PigGroupID is not null
UNION
select distinct
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'FG'+rtrim(pg3.G3_PigGroupID)+'-'+rtrim(pg3.G2_PigGroupID)+'-'+rtrim(pg3.G1_PigGroupID) as CombPigGroup,
pg3.G3_PigGroupID as SourceGroup,
c12.HC_Pct*c23.HC_Pct as HC_Pct,
c12.WT_Pct*c23.WT_Pct as WT_Pct,
c12.WG_Pct*c23.WG_Pct as WG_Pct,
c12.PD_Pct*c23.PD_Pct as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join  dbo.cft_SLF_THREEPHASE_GROUPS pg3 WITH (NOLOCK)
on pg3.G1_PigGroupID=fpg.PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c12 WITH (NOLOCK)
on c12.Dest_PigGroupID=pg3.G1_PigGroupID and c12.Source_PigGroupID=pg3.G2_PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c23 WITH (NOLOCK)
on c23.Dest_PigGroupID=pg3.G2_PigGroupID and c23.Source_PigGroupID=pg3.G3_PigGroupID
where pg3.G1_PigGroupID is not null
UNION
select distinct
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'FG'+rtrim(pg3.G2_PigGroupID)+'-'+rtrim(pg3.G1_PigGroupID) as CombPigGroup,
pg3.G2_PigGroupID as SourceGroup,
c12.HC_Pct as HC_Pct,
c12.WT_Pct as WT_Pct,
c12.WG_Pct as WG_Pct,
c12.PD_Pct as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join  dbo.cft_SLF_THREEPHASE_GROUPS pg3 WITH (NOLOCK)
on pg3.G1_PigGroupID=fpg.PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c12 WITH (NOLOCK)
on c12.Dest_PigGroupID=pg3.G1_PigGroupID and c12.Source_PigGroupID=pg3.G2_PigGroupID
where pg3.G1_PigGroupID is not null
UNION
select distinct
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'FG'+rtrim(pg4.G4_PigGroupID)+'-'+rtrim(pg4.G3_PigGroupID)+'-'+rtrim(pg4.G2_PigGroupID)+'-'+rtrim(+pg4.G1_PigGroupID) as CombPigGroup,
pg4.G4_PigGroupID as SourceGroup,
c12.HC_Pct*c23.HC_Pct*c34.HC_Pct as HC_Pct,
c12.WT_Pct*c23.WT_Pct*c34.WT_Pct as WT_Pct,
c12.WG_Pct*c23.WG_Pct*c34.WG_Pct as WG_Pct,
c12.PD_Pct*c23.PD_Pct*c34.PD_Pct as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join  dbo.cft_SLF_FOURPHASE_GROUPS pg4 WITH (NOLOCK)
on pg4.G1_PigGroupID=fpg.PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c12 WITH (NOLOCK)
on c12.Dest_PigGroupID=pg4.G1_PigGroupID and c12.Source_PigGroupID=pg4.G2_PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c23 WITH (NOLOCK)
on c23.Dest_PigGroupID=pg4.G2_PigGroupID and c23.Source_PigGroupID=pg4.G3_PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c34 WITH (NOLOCK)
on c34.Dest_PigGroupID=pg4.G3_PigGroupID and c34.Source_PigGroupID=pg4.G4_PigGroupID
where pg4.G1_PigGroupID is not null
UNION
select distinct 
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'FG'+rtrim(pg4.G3_PigGroupID)+'-'+rtrim(pg4.G2_PigGroupID)+'-'+rtrim(+pg4.G1_PigGroupID) as CombPigGroup,
pg4.G3_PigGroupID as SourceGroup,
c12.HC_Pct*c23.HC_Pct as HC_Pct,
c12.WT_Pct*c23.WT_Pct as WT_Pct,
c12.WG_Pct*c23.WG_Pct as WG_Pct,
c12.PD_Pct*c23.PD_Pct as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join  dbo.cft_SLF_FOURPHASE_GROUPS pg4 WITH (NOLOCK)
on pg4.G1_PigGroupID=fpg.PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c12 WITH (NOLOCK)
on c12.Dest_PigGroupID=pg4.G1_PigGroupID and c12.Source_PigGroupID=pg4.G2_PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c23 WITH (NOLOCK)
on c23.Dest_PigGroupID=pg4.G2_PigGroupID and c23.Source_PigGroupID=pg4.G3_PigGroupID
where pg4.G1_PigGroupID is not null
UNION
select distinct 
'FG'+rtrim(fpg.PigGroupID) as FlowGroup,
'FG'+rtrim(pg4.G2_PigGroupID)+'-'+rtrim(+pg4.G1_PigGroupID) as CombPigGroup,
pg4.G2_PigGroupID as SourceGroup,
c12.HC_Pct as HC_Pct,
c12.WT_Pct as WT_Pct,
c12.WG_Pct as WG_Pct,
c12.PD_Pct as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join  dbo.cft_SLF_FOURPHASE_GROUPS pg4 WITH (NOLOCK)
on pg4.G1_PigGroupID=fpg.PigGroupID
left join  dbo.cft_SLF_ALL_COMPOSITION c12 WITH (NOLOCK)
on c12.Dest_PigGroupID=pg4.G1_PigGroupID and c12.Source_PigGroupID=pg4.G2_PigGroupID
where pg4.G1_PigGroupID is not null

INSERT INTO  dbo.cft_SLF_FLOWGROUP_COMPOSITION
(FlowGroup,
CombPigGroup,
SourceGroup,
HC_Pct,
WT_Pct,
WG_Pct,
PD_Pct
)
--This part inserts the Subtraction Allocations needed to subtract from FINAL REPORTING GROUPS
select distinct 'FG'+fpg.PigGroupID as FlowGroup,'NEG-'+fgc.CombPigGroup as CombPigGroup,
fpg.PigGroupID as SourceGroup,
fgc.HC_Pct * -1 as HC_Pct,
fgc.WT_Pct * -1 as WT_Pct,
fgc.WG_Pct * -1 as WG_Pct,
fgc.PD_Pct * -1 as PD_Pct
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
on i.SourcePigGroupID=fpg.PigGroupID and i.Reversal<>1 and i.acct='PIG TRANSFER IN'
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=i.PigGroupID
inner join  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc
on right(left(rtrim(fgc.CombPigGroup),7),5)=fpg.PigGroupID and LEN(fgc.CombPigGroup)>7
where  pg.PigProdPhaseID<>'TEF'
--27 Create Insert SLF FlowGroup Compositions


--28 Create Insert SLF Pig Sales Qty
TRUNCATE TABLE  dbo.cft_SLF_PIGSALES_QTY
INSERT INTO  dbo.cft_SLF_PIGSALES_QTY
(PigGroupID,
Prim_Qty,
Cull_Qty,
DeadOnTruck_Qty,
DeadInYard_Qty,
Condemn_Qty
)

select ps2.PigGroupID,
isnull(sum(ps2.Prim_Qty),0) as Prim_Qty,
isnull(sum(ps2.Cull_Qty),0) as Cull_Qty,
--DP_Qty is the SUM of DT,DY,CP and CD!!!
--isnull(sum(ps2.DP_Qty),0) DP_Qty,
isnull(sum(ps2.DT_Qty),0) as DeadOnTruck_Qty,
isnull(sum(ps2.DY_Qty),0) as DeadInYard_Qty,
isnull(sum(ps2.CD_Qty),0) as Condemn_Qty
from (
	select
	pit.PigGroupID,
	case when p.PrimaryPacker=1 and psd.DetailTypeID='SS'
	then psd.Qty end Prim_Qty,
	case when (p.PrimaryPacker=1 and psd.DetailTypeID not in ('SS','DT','DY','CP','CD'))
	or (p.PrimaryPacker=0 and psd.DetailTypeID not in ('DT','DY','CP','CD'))
	then psd.Qty
	when (pit.acct = 'PIG TRANSFER OUT' and pit.TranSubTypeID in ('WC','FC'))
	then pit.Qty
	end Cull_Qty,
	case when psd.DetailTypeID = 'DT'
	then psd.Qty end DT_Qty,
	case when psd.DetailTypeID = 'DY'
	then psd.Qty end DY_Qty,
	case when psd.DetailTypeID in ('CP','CD')
	then psd.Qty end CD_Qty
	--
	from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cfvPIGSALEREV as ps WITH (NOLOCK)
	on ps.BatNbr=pit.SourceBatNbr and ps.RefNbr=pit.SourceRefNbr
	left join [$(SolomonApp)].dbo.cftPacker as p WITH (NOLOCK)
	on p.ContactID=ps.PkrContactID
	left join [$(SolomonApp)].dbo.cftPSDetail as psd WITH (NOLOCK)
	on psd.BatNbr=ps.BatNbr and psd.RefNbr=ps.RefNbr
	where pit.acct in ('PIG SALE','PIG TRANSFER OUT')
	  and pit.Reversal <> 1
	) ps2
group by ps2.PigGroupID
order by ps2.PigGroupID
--28 Create Insert SLF Pig Sales Qty


--29 Create Insert SLF Pig Sales Weight
TRUNCATE TABLE  dbo.cft_SLF_PIGSALES_WT
INSERT INTO  dbo.cft_SLF_PIGSALES_WT
(PigGroupID,
Prim_Wt,
Cull_Wt,
DeadOnTruck_Wt,
DeadInYard_Wt,
Condemn_Wt
)

select ps2.PigGroupID,
isnull(sum(ps2.Prim_Wt),0) Prim_Wt,
--isnull(sum(ps2.Top_Wt),0) Top_Wt,
isnull(sum(ps2.Cull_Wt),0) Cull_Wt,
--DP_Wt is the SUM of DT,DY,CP and CD!!!
--isnull(sum(ps2.DP_Wt),0) DP_Wt,
isnull(sum(ps2.DT_Wt),0) DeadOnTruck_Wt,
isnull(sum(ps2.DY_Wt),0) DeadInYard_Wt,
isnull(sum(ps2.CD_Wt),0) Condemn_Wt
from (
	select
	pit.PigGroupID,
	case when p.PrimaryPacker=1 and psd.DetailTypeID='SS'
	then psd.WgtLive end Prim_Wt,
	--case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID = '10'
	--then psd.WgtLive end Top_Wt,
	case when (p.PrimaryPacker=1 and psd.DetailTypeID not in ('SS','DT','DY','CP','CD'))
	or (p.PrimaryPacker=0 and psd.DetailTypeID not in ('DT','DY','CP','CD'))
	then psd.WgtLive
	when (pit.acct = 'PIG TRANSFER OUT' and pit.TranSubTypeID in ('WC','FC'))
	then pit.TotalWgt
	end Cull_Wt,
	--case when (psd.DetailTypeID in ('DT','DY','CP','CD'))
	--then psd.WgtLive end DP_Wt,
	case when psd.DetailTypeID = 'DT'
	then psd.WgtLive end DT_Wt,
	case when psd.DetailTypeID = 'DY'
	then psd.WgtLive end DY_Wt,
	--case when psd.DetailTypeID = 'CP'
	--then psd.WgtLive end CP_Wt,
	case when psd.DetailTypeID in ('CD','CP')
	then psd.WgtLive end CD_Wt
	--
	from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cfvPIGSALEREV as ps WITH (NOLOCK)
	on ps.BatNbr=pit.SourceBatNbr and ps.RefNbr=pit.SourceRefNbr
	--left join [$(SolomonApp)].dbo.cftPM as pm WITH (NOLOCK)
	--on pm.PMID=ps.PMLoadID
	left join [$(SolomonApp)].dbo.cftPacker as p WITH (NOLOCK)
	on p.ContactID=ps.PkrContactID
	left join [$(SolomonApp)].dbo.cftPSDetail as psd WITH (NOLOCK)
	on psd.BatNbr=ps.BatNbr and psd.RefNbr=ps.RefNbr
	where pit.acct in ('PIG SALE','PIG TRANSFER OUT')
	  and pit.Reversal <> 1
	) ps2
group by ps2.PigGroupID
order by ps2.PigGroupID
--29 Create Insert SLF Pig Sales Weight


--29B Create Insert SLF_PHASE_TYPE_DESCRIPTION
----OPTIONS-----
----1)OneGroup SingleStock FIN (1,687 count)
----2)OneGroup SingleStock WTF (1,687 count)
----3)OneGroup OverStock FIN (70 count)
----4)OneGroup OverStock WTF (175 count)
----5)CombGroup OverStock DiffSite Nursery(2,498 count)
----6)CombGroup OverStock DiffSite WF_Nur(3,529 count)
----7)CombGroup OverStock DiffSite MixNur(1,362 count)
----8)CombGroup OverStock SameSite Nursery(12 count)
----9)CombGroup OverStock SameSite WF_Nur(1,315 count)
----10)CombGroup OverStock SameSite MixNur(294 count)
----11)CombGroup SingleStock DiffSite Nursery(5,842 count)
----12)CombGroup SingleStock DiffSite WF_Nur(396 count)
----13)CombGroup SingleStock DiffSite MixNur(158 count)
----14)CombGroup SingleStock SameSite Nursery(19 count)
----15)CombGroup SingleStock SameSite WF_Nur(473 count)
----16)CombGroup SingleStock SameSite MixNur(95 count)


TRUNCATE TABLE  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION

INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('01','OneGroup SingleStock FIN')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('02','OneGroup SingleStock WTF')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('03','OneGroup OverStock FIN')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('04','OneGroup OverStock WTF')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('05','CombGroup OverStock DiffSite Nursery')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('06','CombGroup OverStock DiffSite WF_Nur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('07','CombGroup OverStock DiffSite MixNur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('08','CombGroup OverStock SameSite Nursery')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('09','CombGroup OverStock SameSite WF_Nur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('10','CombGroup OverStock SameSite MixNur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('11','CombGroup SingleStock DiffSite Nursery')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('12','CombGroup SingleStock DiffSite WF_Nur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('13','CombGroup SingleStock DiffSite MixNur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('14','CombGroup SingleStock SameSite Nursery')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('15','CombGroup SingleStock SameSite WF_Nur')
INSERT INTO  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION
values ('16','CombGroup SingleStock SameSite MixNur')
--29B Create Insert SLF_PHASE_TYPE_DESCRIPTION


--29C Create Insert SLF_WTF_TYPE_DATA
TRUNCATE TABLE  dbo.cft_SLF_WTF_TYPE_DATA
INSERT INTO  dbo.cft_SLF_WTF_TYPE_DATA
(FlowGroup,
FlowGroupDescription,
Group_Number,
DestPhase,
DestContactID,
DestFacilityType,
SourcePhase,
SourceContactID,
SourceFacilityType,
SourceDescription,
SourceMaxCapacity,
SourceHeadStarted,
Inv_Day21,
HS_Cap_Ratio,
Inv21_Cap_Ratio,
SourcePigGroup,	-- 20150302 JohnMaas change
SourcePigGroupStartDate,	-- 20150302 JohnMaas change
SourceWtTransIn,	-- 20150302 JohnMaas change
SourceWtTransOut	-- 20150302 JohnMaas change
)

select
rtrim(fg1.FlowGroup) as FlowGroup,
rtrim(fg1.FlowGroup)+'-'+rtrim(pg.Description) as FlowGroupDescription,
rtrim(fg1.CombPigGroup) as Group_Number,
pg.PigProdPhaseID as DestPhase,
pg.SiteContactID as DestContactID,
f.Description as DestFacilityType,
case when left(fg1.CombPigGroup,2)='PG' then null
else pg2.PigProdPhaseID end as SourcePhase,
--pg2.PigProdPhaseID as SourcePhase,
pg2.SiteContactID as SourceContactID,
case when left(fg1.CombPigGroup,2)='PG' then null
else f2.Description end as SourceFacilityType,
--f2.Description as SourceFacilityType,
pg2.Description as SourceDescription,
b2.MaxCap as SourceMaxCapacity,
--case when [$(SolomonApp)].dbo.PGGetMaxCapacity(fg1.SourceGroup)=0 then b2.MaxCap
--else [$(SolomonApp)].dbo.PGGetMaxCapacity(fg1.SourceGroup) end as SourceMaxCapacity,
hss.HeadStarted as SourceHeadStarted,
d21.Inventory_Day21 as Inv_Day21,
case when b2.MaxCap=0 then 0
else cast(hss.HeadStarted as decimal)/cast(b2.MaxCap as decimal)
--else cast(hss.HeadStarted as decimal)/cast([$(SolomonApp)].dbo.PGGetMaxCapacity(fg1.SourceGroup) as decimal)
end as HS_Cap_Ratio,
case when b2.MaxCap=0 then 0
else --[$(SolomonApp)].dbo.PGGetMaxCapacity(fg1.SourceGroup)=0 then
cast(d21.Inventory_Day21 as decimal)/cast(b2.MaxCap as decimal)
--else cast(d21.Inventory_Day21 as decimal)/cast([$(SolomonApp)].dbo.PGGetMaxCapacity(fg1.SourceGroup) as decimal)
end as Inv21_Cap_Ratio,
pg2.PigGroupID as SourcePigGroup,	-- 20150302 JohnMaas change
pg2.ActStartDate as SourcePigGroupStartDate,	-- 20150302 JohnMaas change
wti.WtTransIn as SourceWtTransIn,	-- 20150302 JohnMaas change
wto.WtTransOut as SourceWtTransOut	-- 20150302 JohnMaas change
from  dbo.cft_SLF_FINAL_PIG_GROUPS fg WITH (NOLOCK)
left join  dbo.cft_SLF_FLOWGROUP_COMPOSITION fg1 WITH (NOLOCK)
on 'FG'+rtrim(fg.PigGroupID)=fg1.FlowGroup
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=fg.PigGroupID
left join [$(SolomonApp)].dbo.cftSite s WITH (NOLOCK)
on s.ContactID=pg.SiteContactID
left join [$(SolomonApp)].dbo.cftFacilityType f WITH (NOLOCK)
on f.FacilityTypeID=s.FacilityTypeID
left join [$(SolomonApp)].dbo.cftPigGroup pg2 WITH (NOLOCK)
on pg2.PigGroupID=fg1.SourceGroup
left join [$(SolomonApp)].dbo.cftSite s2 WITH (NOLOCK)
on s2.ContactID=pg2.SiteContactID
left join [$(SolomonApp)].dbo.cftBarn b2 WITH (NOLOCK)
on b2.ContactID=s2.ContactID and b2.BarnNbr=pg2.BarnNbr
left join [$(SolomonApp)].dbo.cftFacilityType f2 WITH (NOLOCK)
on f2.FacilityTypeID=s2.FacilityTypeID
--Sub-query for HeadStarted
left join (
	select PigGroupID,SUM(Qty*InvEffect) as HeadStarted
	from [$(SolomonApp)].dbo.cftPGInvTran WITH (NOLOCK)
	where Reversal<>1 and acct in ('PIG TRANSFER IN','PIG PURCHASE','PIG MOVE IN','PIG MOVE OUT')
	group by PigGroupID) hss
on pg2.PigGroupID=hss.PigGroupID
--SubQuery for Inventory_Day21
left join (
	select i.PigGroupID,gStart.TranDate as PigStartDate,
	sum(i.qty*i.InvEffect) as Inventory_Day21
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart WITH (NOLOCK)
	on gStart.PigGroupID = i.PigGroupID
	where i.Reversal<>1
	and i.acct in ('PIG PURCHASE','PIG TRANSFER IN','PIG MOVE IN','PIG MOVE OUT','PIG TRANSFER OUT')
	and i.TranDate between gStart.TranDate and (gStart.TranDate+21)
	group by i.PigGroupID,gStart.TranDate) d21
on pg2.PigGroupID=d21.PigGroupID
-- new code 201503 JMaas
----SubQuery for WtTransOut
left join (
	select PigGroupID,SUM(TotalWgt)/SUM(Qty) as WtTransOut
	from [$(SolomonApp)].dbo.cftPGInvTran WITH (NOLOCK)
	where Reversal<>1 and acct in ('PIG TRANSFER OUT')
	and right(TranSubTypeID,1)<>'T' --Take out transfers to Tailend groups.
	group by PigGroupID
) wto
on pg2.PigGroupID=wto.PigGroupID
----SubQuery for WtTransIn
left join (
	select PigGroupID,SUM(TotalWgt)/SUM(Qty) as WtTransIn
	from [$(SolomonApp)].dbo.cftPGInvTran WITH (NOLOCK)
	where Reversal<>1 and acct in ('PIG TRANSFER IN')
	and left(TranSubTypeID,1)='S' --Only looks at transfers in from Sow Farms
	group by PigGroupID
) wti
on pg2.PigGroupID=wti.PigGroupID
-- new code 201503 JMaas
order by FlowGroup
--29C Create Insert SLF_WTF_TYPE_DATA

--29C2 Update SourceFacilityTypeAndCapacityChanges

--This will put NULL values into all rows of data for SourceFacilityType that are the Destination PigGroups
--(The final pig group from which Pigs were sold)
--When looking at the SourceFacilityTypes, we do not want to have values in the destination groups.
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType=NULL
where left(Group_Number,2)='PG'

--This will put NULL values into all rows of data for SourceFacilityType that are part groups
--of Destination groups that transferred some pigs to another Destination group.
--Example: WTF starts with 1400 head and transfers 400 pigs to another WTF group.
--both are destination groups, but the 400 head is negated from the original group.
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType=NULL
where left(Group_Number,3)='NEG'

--This puts NULL values into SourceFacilityType where the source groups were in a Nursery or WTF phase.
--We will determine these by looking at SourceWtTransIn later in this update code.
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType=NULL
where SourcePhase not in ('NUR','WTF')

--This update is specific for N05, to change the SourceFacilityType to 'Nursery' on all groups
--before Dec. 1, 2009
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='Nursery'
--Reset SourceFacilityType for N05 to Nursery for old groups
where (SourceContactID = '000499')
and (SourcePigGroupStartDate<'12/1/2009')

--This update is specific for N06, to change the SourceFacilityType to 'Nursery' on all groups
--before Nov. 25, 2012
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='Nursery'
--Reset SourceFacilityType for N06 to Nursery for old groups
where (SourceContactID = '000500')
and (SourcePigGroupStartDate<'11/25/2012')

--This update is specific for N10, to change the SourceFacilityType to 'Nursery' on all groups
--before Sep. 25, 2009
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='Nursery'
--Reset SourceFacilityType for N10 to Nursery for old groups
where (SourceContactID = '000504')
and (SourcePigGroupStartDate<'9/25/2009')

--This update is specific for N11, to change the SourceFacilityType to 'Nursery' on all groups
--before Sep. 2, 2009
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='Nursery'
--Reset SourceFacilityType for N11 to Nursery for old groups
where (SourceContactID = '000505')
and (SourcePigGroupStartDate<'9/2/2009')

--This update is specific for N24, to change the SourceFacilityType to 'Nursery' on all groups
--before Jul. 5, 2013
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='Nursery'
--Reset SourceFacilityType for N24 to Nursery for old groups
where (SourceContactID = '004418')
and (SourcePigGroupStartDate<'7/5/2013')

--This will set the SourceFacilityType to 'WF' when the average weight of Pigs Transferred in
--is less than 23 lbs (Wean Pigs) and the SourceFacilityType is not WF,Nursery.
--This will update a lot of the Source facilities that are 'Finish', yet are being used to grow wean pigs.
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='WF'
--Reset SourceFacilityType for Finish sites that have received WeanPigs to WF
where SourceWtTransIn is not null and SourceWtTransIn <23 and SourcePhase in ('NUR','WTF')
and SourceFacilityType not in ('WF','Nursery')
and SourceContactID not in ('000499','004418','000500','000504','000505','000838')

--Reset capacities for N05,N06,N10,N11 to former nursery capacities
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = SourceMaxCapacity * 3.0216
where SourceContactID in ('000499','000500','000504','000505') and left(SourceDescription,1)='N'

--Reset Capacity to 2100 per barn for N05
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = SourceMaxCapacity * 3.0216
where (SourceContactID = '000499')
and (SourcePigGroupStartDate<'12/1/2009')

--Reset Capacity to 2100 per barn for N06
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = SourceMaxCapacity * 3.0216
where (SourceContactID = '000500')
and (SourcePigGroupStartDate<'11/25/2012')

--Reset Capacity to 2100 per barn for N10
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = SourceMaxCapacity * 3.0216
where (SourceContactID = '000504')
and (SourcePigGroupStartDate<'9/25/2009')

--Reset Capacity to 2100 per barn for N11
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = SourceMaxCapacity * 3.0216
where (SourceContactID = '000505')
and (SourcePigGroupStartDate<'9/2/2009')

--Reset Capacity to 2100 per barn for N24
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = 11200
where (SourceContactID = '004418')
and (SourcePigGroupStartDate<'7/5/2013')

--Set M02 nursery groups to Nursery. These show up as 'Sow Farm' if left unchanged.
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceFacilityType='Nursery'
where SourceContactID='000838' and SourcePhase in ('NUR','WTF')

--Reset capacity for M02 Nursery Capacity to 1200
update  dbo.cft_SLF_WTF_TYPE_DATA
set SourceMaxCapacity = 1200
where SourceContactID in ('000838') and SourcePhase in ('NUR','WTF')

--This forces the HS_Cap_Ratio to zero, so that it can be calculated in the next step.
update  dbo.cft_SLF_WTF_TYPE_DATA
set HS_Cap_Ratio = 0
where SourceMaxCapacity = 0

--This Forces the HS_Cap_Ratio to be calculated after the updates to Capacities are done.
update  dbo.cft_SLF_WTF_TYPE_DATA
set HS_Cap_Ratio = cast(SourceHeadStarted as decimal)/cast(SourceMaxCapacity as decimal)
where SourceMaxCapacity <> 0

--This forces the Inv21_Cap_Ratio to zero, so that it can be calculated in the next step.
update  dbo.cft_SLF_WTF_TYPE_DATA
set Inv21_Cap_Ratio = 0
where SourceMaxCapacity = 0

--This Forces the Inv21_Cap_Ratio to be calculated after the updates to Capacities are done.
update  dbo.cft_SLF_WTF_TYPE_DATA
set Inv21_Cap_Ratio = cast(Inv_Day21 as decimal)/cast(SourceMaxCapacity as decimal)
where SourceMaxCapacity <> 0
--29C2 Update SourceFacilityTypeAndCapacityChanges


--29D Create Insert SLF_WTF_TYPE_DATA
--DROP TABLE  dbo.cft_SLF_PHASE_TYPE
--CREATE TABLE  dbo.cft_SLF_PHASE_TYPE
--(FlowGroup char(10) not null PRIMARY KEY,
--PhaseType char(2) null
--)  (updated 20150303)
TRUNCATE TABLE  dbo.cft_SLF_PHASE_TYPE
INSERT INTO  dbo.cft_SLF_PHASE_TYPE
(FlowGroup,
PhaseType)

select distinct FlowGroup,'' as PhaseType
from  dbo.cft_SLF_WTF_TYPE_DATA

update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='01'
where FlowGroup in (
	--1)OneGroup SingleStock FIN
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	group by FlowGroup
	having Count(Group_Number)=1
	and ((MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1) or
		(MAX(HS_Cap_Ratio) is null or MAX(Inv21_Cap_Ratio) is null))
	and MAX(DestPhase)='FIN'
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='02'
where FlowGroup in (
	--2)OneGroup SingleStock WTF
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)=1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)
	and MAX(DestPhase)='WTF'
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='03'
where FlowGroup in (
	--3)OneGroup OverStock FIN
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)=1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)
	and MAX(DestPhase)='FIN'
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='04'
where FlowGroup in (
	--4)OneGroup OverStock WTF
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)=1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)
	and MAX(DestPhase)='WTF'
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='05'
where FlowGroup in (
	--5)CombGroup OverStock DiffSite Nursery
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)	
	and ((MAX(DestContactID)<>MIN(SourceContactID)) or (MAX(DestContactID)<>MAX(SourceContactID)))		
	and MIN(SourceFacilityType)='Nursery' and MAX(SourceFacilityType)='Nursery'
	)	
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='06'
where FlowGroup in (
	--6)CombGroup OverStock DiffSite WF_Nur
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)	
	and ((MAX(DestContactID)<>MIN(SourceContactID)) or (MAX(DestContactID)<>MAX(SourceContactID)))		
	and MIN(SourceFacilityType)='WF' and MAX(SourceFacilityType)='WF'
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='07'
where FlowGroup in (
	--7)CombGroup OverStock DiffSite MixNur
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)	
	and ((MAX(DestContactID)<>MIN(SourceContactID)) or (MAX(DestContactID)<>MAX(SourceContactID)))		
	and ((MIN(SourceFacilityType)<>MAX(SourceFacilityType)) or
	(MIN(SourceFacilityType)=MAX(SourceFacilityType) and MAX(SourceFacilityType) not in ('WF','Nursery')))
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='08'
where FlowGroup in (
	--8)CombGroup OverStock SameSite Nursery
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)	
	and (MAX(DestContactID)=MIN(SourceContactID)) and (MAX(DestContactID)=MAX(SourceContactID))			
	and MIN(SourceFacilityType)='Nursery' and MAX(SourceFacilityType)='Nursery'
	)	
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='09'
where FlowGroup in (
	--9)CombGroup OverStock SameSite WF_Nur
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)	
	and (MAX(DestContactID)=MIN(SourceContactID)) and (MAX(DestContactID)=MAX(SourceContactID))			
	and MIN(SourceFacilityType)='WF' and MAX(SourceFacilityType)='WF'
	)		
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='10'
where FlowGroup in (
	--10)CombGroup OverStock SameSite MixNur
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)>=1.1 or MAX(Inv21_Cap_Ratio)>=1.1)	
	and (MAX(DestContactID)=MIN(SourceContactID)) and (MAX(DestContactID)=MAX(SourceContactID))			
	and ((MIN(SourceFacilityType)<>MAX(SourceFacilityType)) or
	(MIN(SourceFacilityType)=MAX(SourceFacilityType) and MAX(SourceFacilityType) not in ('WF','Nursery')))	
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='11'
where FlowGroup in (
	--11)CombGroup SingleStock DiffSite Nursery
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)	
	and ((MAX(DestContactID)<>MIN(SourceContactID)) or (MAX(DestContactID)<>MAX(SourceContactID)))		
	and MIN(SourceFacilityType)='Nursery' and MAX(SourceFacilityType)='Nursery'	
	)	
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='12'
where FlowGroup in (
	--12)CombGroup SingleStock DiffSite WF_Nur(396 count)
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)	
	and ((MAX(DestContactID)<>MIN(SourceContactID)) or (MAX(DestContactID)<>MAX(SourceContactID)))		
	and MIN(SourceFacilityType)='WF' and MAX(SourceFacilityType)='WF'	
	)	
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='13'
where FlowGroup in (
	--13)CombGroup SingleStock DiffSite MixNur
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)	
	and ((MAX(DestContactID)<>MIN(SourceContactID)) or (MAX(DestContactID)<>MAX(SourceContactID)))		
	and ((MIN(SourceFacilityType)<>MAX(SourceFacilityType)) or
	(MIN(SourceFacilityType)=MAX(SourceFacilityType) and MAX(SourceFacilityType) not in ('WF','Nursery')))	
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='14'
where FlowGroup in (
	--14)CombGroup SingleStock SameSite Nursery
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)	
	and (MAX(DestContactID)=MIN(SourceContactID)) and (MAX(DestContactID)=MAX(SourceContactID))	
	and MIN(SourceFacilityType)='Nursery' and MAX(SourceFacilityType)='Nursery'		
	)	
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='15'
where FlowGroup in (
	--15)CombGroup SingleStock SameSite WF_Nur
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)	
	and (MAX(DestContactID)=MIN(SourceContactID)) and (MAX(DestContactID)=MAX(SourceContactID))		
	and MIN(SourceFacilityType)='WF' and MAX(SourceFacilityType)='WF'		
	)
update  dbo.cft_SLF_PHASE_TYPE
set PhaseType='16'
where FlowGroup in (
	--16)CombGroup SingleStock SameSite MixNur(95 count)
	select FlowGroup
	from  dbo.cft_SLF_WTF_TYPE_DATA
	where LEFT(Group_Number,3)<>'NEG'
	group by FlowGroup
	having Count(Group_Number)>1
	and (MAX(HS_Cap_Ratio)<1.1 and MAX(Inv21_Cap_Ratio)<1.1)	
	and ((MAX(DestContactID)=MIN(SourceContactID)) and (MAX(DestContactID)=MAX(SourceContactID)))		
	and ((MIN(SourceFacilityType)<>MAX(SourceFacilityType)) or
	(MIN(SourceFacilityType)=MAX(SourceFacilityType) and MAX(SourceFacilityType) not in ('WF','Nursery')))		
	)
--29D Create Update SLF_WTF_TYPE_DATA  (updated 20150303)


--30 Create Insert SLF Essbase Data Table
TRUNCATE TABLE  dbo.cft_SLF_ESSBASE_DATA
INSERT INTO  dbo.cft_SLF_ESSBASE_DATA
(Site,
MasterGroup,
MasterGroupDescription,
FlowGroup,
FlowGroupDescription,
Group_Number,
Phase,
PhaseTypeDesc,
PigFlowID,
PigFlowDescription,
PG_Week,
MG_Week,
Scenario,
PigGroupFeedMill,
FlowGroupFeedMill,
TransferInWP_Qty,
TransferIn_Qty,
MoveIn_Qty,
MoveOut_Qty,
PigDeath_Qty,
PigDeathTD_Qty,
TransportDeath_Qty,
InventoryAdjustment_Qty,
TransferOut_Qty,
TransferToTailender_Qty,
Prim_Qty,
Cull_Qty,
DeadOnTruck_Qty,
DeadInYard_Qty,
Condemn_Qty,
TransferInWP_Wt,
TransferIn_Wt,
MoveIn_Wt,
MoveOut_Wt,
PigDeathTD_Wt,
TransportDeath_Wt,
TransferOut_Wt,
TransferToTailender_Wt,
Prim_Wt,
Cull_Wt,
DeadOnTruck_Wt,
DeadInYard_Wt,
Condemn_Wt,
DeadPigDays,
LivePigDays,
Feed_Qty,
HdCapacity,
MaxCapacityDays,
EmptyCapacityDays,
reportinggroupid,
reporting_group_description
)

select c.ContactName as Site,'MG'+rtrim(fg.MasterGroup) as MasterGroup,
'MG'+rtrim(fg.MasterGroup)+'-'+rtrim(c.ContactName) as MasterGroupDescription,
rtrim(fg1.FlowGroup) as FlowGroup,
rtrim(fg1.FlowGroup)+'-'+rtrim(pg.Description) as FlowGroupDescription,
rtrim(fg1.CombPigGroup) as Group_Number,
pg2.PigProdPhaseID as Phase,
rtrim(ptd.PhaseTypeDesc) as PhaseTypeDesc,
case when pgf.PigFlowID is null then '0'
else pgf.PigFlowID end as PigFlowID,
case when pf.PigFlowDescription is null then 'Other'
else pf.PigFlowDescription end as PigFlowDescription,
ddpg.PICYear_Week as PG_Week,
ddmg.PICYear_Week as MG_Week,
'Actual' as Scenario,
rtrim(c2.ContactName) as PigGroupFeedMill,
rtrim(c3.ContactName) as FlowGroupFeedMill,
0 as TransferInWP_Qty,
0 as TransferIn_Qty,
0 as MoveIn_Qty,
0 as MoveOut_Qty,
0 as PigDeath_Qty,
0 as PigDeathTD_Qty,
0 as TransportDeath_Qty,
0 as InventoryAdjustment_Qty,
0 as TransferOut_Qty,
0 as TransferToTailender_Qty,
0 as Prim_Qty,
0 as Cull_Qty,
0 as DeadOnTruck_Qty,
0 as DeadInYard_Qty,
0 as Condemn_Qty,
0 as TransferInWP_Wt,
0 as TransferIn_Wt,
0 as MoveIn_Wt,
0 as MoveOut_Wt,
0 as PigDeathTD_Wt,
0 as TransportDeath_Wt,
0 as TransferOut_Wt,
0 as TransferToTailender_Wt,
0 as Prim_Wt,
0 as Cull_Wt,
0 as DeadOnTruck_Wt,
0 as DeadInYard_Wt,
0 as Condemn_Wt,
0 as DeadPigDays,
0 as LivePigDays,
0 as Feed_Qty,
0 as HdCapacity,
0 as MaxCapacityDays,
0 as EmptyCapacityDays,
pgf.reportinggroupid,
rg.reporting_group_description
from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fg1 WITH (NOLOCK)
left join  dbo.cft_SLF_FINAL_PIG_GROUPS fg WITH (NOLOCK)
on 'FG'+rtrim(fg.PigGroupID)=fg1.FlowGroup
left join  dbo.cft_PIG_GROUP_ROLLUP pgf WITH (NOLOCK)
on rtrim(pgf.TaskID)='PG'+right(rtrim(fg1.FlowGroup),5)
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP rg (Nolock)
	on rg.reportinggroupid = pgf.reportinggroupid
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf WITH (NOLOCK)
on pf.PigFlowID=pgf.PigFlowID
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo ddpg WITH (NOLOCK)
on ddpg.DayDate=fg.ActCloseDate
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo ddmg WITH (NOLOCK)
on ddmg.DayDate=fg.MGActCloseDate
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=fg.PigGroupID
left join [$(SolomonApp)].dbo.cftContact c WITH (NOLOCK)
on c.ContactID=pg.SiteContactID
left join [$(SolomonApp)].dbo.cftContact c3 WITH (NOLOCK)
on c3.ContactID=pg.FeedMillContactID
left join [$(SolomonApp)].dbo.cftPigGroup pg2 WITH (NOLOCK)
on pg2.PigGroupID=fg1.SourceGroup
left join [$(SolomonApp)].dbo.cftContact c2 WITH (NOLOCK)
on c2.ContactID=pg2.FeedMillContactID
left join  dbo.cft_SLF_PHASE_TYPE pt WITH (NOLOCK)
on pt.FlowGroup=fg1.FlowGroup
left join  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION ptd WITH (NOLOCK)
on pt.PhaseType=ptd.PhaseType
order by FlowGroup
--30 Create Insert SLF Essbase Data Table

--30B  Crate Insert SLF Final to Final table
create table #alltran
(Source_PigGroupID char(10) not null,
Dest_PigGroupID char(10) not null)

INSERT INTO #alltran
(Source_PigGroupID,
Dest_PigGroupID)

select distinct z.SourceGroup,z.DestGroup from (
select G2_PigGroupID as SourceGroup,G1_PigGroupID as DestGroup from dbo.cft_SLF_TWOPHASE_GROUPS
UNION
select G2_PigGroupID as SourceGroup,G1_PigGroupID as DestGroup from dbo.cft_SLF_THREEPHASE_GROUPS
UNION
select G3_PigGroupID as SourceGroup,G2_PigGroupID as DestGroup from dbo.cft_SLF_THREEPHASE_GROUPS
UNION
select G2_PigGroupID as SourceGroup,G1_PigGroupID as DestGroup from dbo.cft_SLF_FOURPHASE_GROUPS
UNION
select G3_PigGroupID as SourceGroup,G2_PigGroupID as DestGroup from dbo.cft_SLF_FOURPHASE_GROUPS
UNION
select G4_PigGroupID as SourceGroup,G3_PigGroupID as DestGroup from dbo.cft_SLF_FOURPHASE_GROUPS) z

--------------------------------------------------------------------
----FINAL TO FINAL TRANSACTIONS-------
--------------------------------------------------------------------
--DROP TABLE  dbo.cft_SLF_FINAL_TO_FINAL
--CREATE TABLE  dbo.cft_SLF_FINAL_TO_FINAL
--(Source_PigGroupID char(10) not null,
--Dest_PigGroupID char(10) not null)
TRUNCATE TABLE  dbo.cft_SLF_FINAL_TO_FINAL
INSERT INTO  dbo.cft_SLF_FINAL_TO_FINAL
(Source_PigGroupID,
Dest_PigGroupID)

select *
from #alltran
where Source_PigGroupID in (select distinct PigGroupID
from  dbo.cft_SLF_FINAL_PIG_GROUPS fpg WITH (NOLOCK))
order by Source_PigGroupID

drop table #alltran
--30B  Crate Insert SLF Final to Final table


--31 Update Caculations witin the Essbase Data Table
-------------------------------------------------------
--Insert Account values into cft_SLF_ESSBASE_DATA------
-------------------------------------------------------

-------------------------------------------------------
--LivePigDays------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET LivePigDays = LPD.LivePigDays
FROM
	(
	select
	fgc.CombPigGroup,
	sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1)*
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as LivePigDays
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit
	on pit.PigGroupID = fgc.SourceGroup
	left join [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart
	on gStart.PigGroupID = fgc.SourceGroup
	where pit.acct <> 'pig death' and pit.trantypeid <> 'ia' and pit.Reversal <> 1
	group by fgc.CombPigGroup,fgc.WG_Pct
	) LPD
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(LPD.CombPigGroup)

-------------------------------------------------------
--DeadPigDays------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET DeadPigDays = DPD.DeadPigDays
FROM
	(
	select
	fgc.CombPigGroup,
	sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1)*
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as DeadPigDays
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit
	on pit.PigGroupID = fgc.SourceGroup
	left join [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart
	on gStart.PigGroupID = fgc.SourceGroup
	where pit.acct = 'pig death' and pit.trantypeid <> 'ia' and pit.Reversal <> 1
	group by fgc.CombPigGroup,fgc.WG_Pct
	) DPD
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(DPD.CombPigGroup)

-------------------------------------------------------
--FeedQty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Feed_qty = fq.FeedQty
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_units)*
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as FeedQty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG FEED ISSUE'
	group by fgc.CombPigGroup,fgc.WG_Pct
	) fq
join  dbo.cft_SLF_ESSBASE_DATA ed
on ed.Group_Number = fq.CombPigGroup


-------------------------------------------------------
--MoveIn_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET MoveIn_Qty = MIQ.MoveIn_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as MoveIn_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.TranTypeID='MI' and pit.acct='PIG MOVE IN'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) MIQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(MIQ.CombPigGroup)

-------------------------------------------------------
--MoveOut_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET MoveOut_Qty = MOQ.MoveOut_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as MoveOut_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.TranTypeID='MO' and pit.acct='PIG MOVE OUT'
	group by fgc.CombPigGroup,fgc.HC_Pct		
	) MOQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(MOQ.CombPigGroup)

-------------------------------------------------------
--PigDeath_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET PigDeath_Qty = DQ.PigDeath_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Pig Days (PD)------
	fgc.PD_Pct as PigDeath_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG DEATH' and pit.TranTypeID<>'TD'
	group by fgc.CombPigGroup,fgc.PD_Pct	
	) DQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(DQ.CombPigGroup)

-------------------------------------------------------
--PigDeathTD_Qty---------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET PigDeathTD_Qty = DQ.PigDeathTD_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(i.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PigDeathTD_Qty
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.SourceRefNbr=i.SourceRefNbr and i2.BatNbr=i.BatNbr and i2.acct='PIG TRANSFER IN' and i2.Reversal<>1
	inner join  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	on i2.PigGroupID = fgc.SourceGroup
	where i.Reversal<>1
	and i.acct in ('PIG DEATH') and i.TranTypeID='TD'
	group by fgc.CombPigGroup,fgc.HC_Pct	
	) DQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(DQ.CombPigGroup)

-------------------------------------------------------
--TransportDeath_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransportDeath_Qty = TDQ.TransportDeath_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(i.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as TransportDeath_Qty
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.SourceRefNbr=i.SourceRefNbr and i2.BatNbr=i.BatNbr and i2.acct='PIG TRANSFER IN' and i2.Reversal<>1
	inner join  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	on i2.PigGroupID = fgc.SourceGroup
	where i.Reversal<>1
	and i.acct in ('TRANSPORT DEATH')
	group by fgc.CombPigGroup,fgc.HC_Pct	
	) TDQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TDQ.CombPigGroup)

-------------------------------------------------------
--InventoryAdjustment_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET InventoryAdjustment_Qty = IAQ.InventoryAdjustment_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as InventoryAdjustment_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.TranTypeID='IA' and pit.acct='PIG INV ADJ'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) IAQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(IAQ.CombPigGroup)

-------------------------------------------------------
--MoveIn_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET MoveIn_Wt = MIW.MoveIn_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.TotalWgt)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as MoveIn_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.TranTypeID='MI' and pit.acct='PIG MOVE IN'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) MIW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(MIW.CombPigGroup)

-------------------------------------------------------
--MoveOut_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET MoveOut_Wt = MOW.MoveOut_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.TotalWgt)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as MoveOut_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.TranTypeID='MO' and pit.acct='PIG MOVE OUT'
	group by fgc.CombPigGroup,fgc.HC_Pct		
	) MOW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(MOW.CombPigGroup)

-------------------------------------------------------
--TransportDeath_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransportDeath_Wt = TDW.TransportDeath_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(i.TotalWgt)*
	--Allocation is now set as Weight Transferred (WT)------
	fgc.WT_Pct as TransportDeath_Wt
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.SourceRefNbr=i.SourceRefNbr and i2.BatNbr=i.BatNbr and i2.acct='PIG TRANSFER IN' and i2.Reversal<>1
	inner join  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	on i2.PigGroupID = fgc.SourceGroup
	where i.Reversal<>1	and i.acct in ('TRANSPORT DEATH')
	group by fgc.CombPigGroup,fgc.WT_Pct	
	) TDW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TDW.CombPigGroup)

-------------------------------------------------------
--PigDeathTD_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET PigDeathTD_Wt = TDW.PigDeathTD_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(i.TotalWgt)*
	--Allocation is now set as Weight Transferred (WT)------
	fgc.WT_Pct as PigDeathTD_Wt
	from [$(SolomonApp)].dbo.cftPGInvTran i WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran i2 WITH (NOLOCK)
	on i2.SourceRefNbr=i.SourceRefNbr and i2.BatNbr=i.BatNbr and i2.acct='PIG TRANSFER IN' and i2.Reversal<>1
	inner join  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	on i2.PigGroupID = fgc.SourceGroup
	where i.Reversal<>1	and i.acct in ('PIG DEATH') and i.TranTypeID='TD'
	group by fgc.CombPigGroup,fgc.WT_Pct	
	) TDW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TDW.CombPigGroup)

-------------------------------------------------------
--TransferInWP_Qty-----SOW FARM WEAN PIGS--------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferInWP_Qty = TIWQ.TransferInWP_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as TransferInWP_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER IN'
	and LEFT(pit.SourceProject,2)='PS' and pit.SourcePigGroupID=''
	and pit.TranSubTypeID in ('SN','SW')
	group by fgc.CombPigGroup,fgc.HC_Pct
	) TIWQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TIWQ.CombPigGroup)

-------------------------------------------------------
--TransferIn_Qty-----Group to Group Transfers----------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferIn_Qty = TIQ.TransferIn_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as TransferIn_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER IN'
	and LEFT(pit.SourceProject,2)='PS' and pit.SourcePigGroupID<>''
	and pit.TranSubTypeID not in ('SN','SW')
	group by fgc.CombPigGroup,fgc.HC_Pct
	) TIQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TIQ.CombPigGroup)

-------------------------------------------------------
--TransferInWP_Wt-----SOW FARM WEAN PIGS----------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferInWP_Wt = TIWW.TransferInWP_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.TotalWgt)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as TransferInWP_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER IN'
	and LEFT(pit.SourceProject,2)='PS' and pit.SourcePigGroupID=''
	and pit.TranSubTypeID in ('SN','SW')
	group by fgc.CombPigGroup,fgc.HC_Pct
	) TIWW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TIWW.CombPigGroup)

-------------------------------------------------------
--TransferIn_Wt-----Group to Group Transfers----------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferIn_Wt = TIW.TransferIn_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.TotalWgt)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as TransferIn_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER IN'
	and LEFT(pit.SourceProject,2)='PS' and pit.SourcePigGroupID<>''
	and pit.TranSubTypeID not in ('SN','SW')
	group by fgc.CombPigGroup,fgc.HC_Pct	
	) TIW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TIW.CombPigGroup)

-------------------------------------------------------
--TransferOut_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferOut_Qty = TOQ.TransferOut_Qty
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.Qty)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as TransferOut_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER OUT' and pit.TranSubTypeID not in ('FT','WT')
	and fgc.SourceGroup not in (select distinct Source_PigGroupID from dbo.cft_SLF_FINAL_TO_FINAL)
	group by fgc.CombPigGroup,fgc.HC_Pct
	UNION
	--New code 3-19-2013 to get the correct TransferOut_Qty on FINAL to FINAL PigGroups---
	select fgc.CombPigGroup,
	case when left(fgc.CombPigGroup,3)='NEG' then sum(pit.Qty) * -1
	else sum(pit.Qty) end as TransferOut_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	inner join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID=right(rtrim(fgc.CombPigGroup),5) and pit.SourcePigGroupID=fgc.SourceGroup and pit.acct='PIG TRANSFER IN' and pit.TranSubTypeID not in ('FT','WT')
	---Add this 3/2/2016 so that reversals are taken out jlm		
	and pit.Reversal<>1 
	where fgc.SourceGroup in (select distinct Source_PigGroupID from dbo.cft_SLF_FINAL_TO_FINAL)
	group by fgc.CombPigGroup
	UNION
	select fgc.CombPigGroup,
	case when left(fgc.CombPigGroup,3)='NEG' then sum(pit.Qty) * -1
	else sum(pit.Qty) end as TransferOut_Qty
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	inner join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on 'PG'+rtrim(pit.PigGroupID)=rtrim(fgc.CombPigGroup) and pit.acct='PIG TRANSFER OUT' and pit.TranSubTypeID not in ('FT','WT')
	---Add this 3/2/2016 so that reversals are taken out jlm
	and pit.Reversal<>1
	where fgc.SourceGroup in (select distinct Source_PigGroupID from dbo.cft_SLF_FINAL_TO_FINAL)
	group by fgc.CombPigGroup
	) TOQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TOQ.CombPigGroup)

-------------------------------------------------------
--TransferToTailender_Qty------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferToTailender_Qty = TOQ.TransferToTailender_Qty
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pit.Qty) as TransferToTailender_Qty
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.PigGroupID
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER OUT' and pit.TranSubTypeID in ('FT','WT')
	group by fgc.PigGroupID		
	) TOQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TOQ.CombPigGroup)

-------------------------------------------------------
--TransferOut_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferOut_Wt = TOQ.TransferOut_Wt
FROM
	(
	select fgc.CombPigGroup,
	sum(pit.TotalWgt)*
	--Allocation is now set as Weight Transferred (WT)------
	fgc.WT_Pct as TransferOut_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.SourceGroup
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER OUT' and pit.TranSubTypeID not in ('FT','WT')
	and fgc.SourceGroup not in (select distinct Source_PigGroupID from dbo.cft_SLF_FINAL_TO_FINAL)
	group by fgc.CombPigGroup,fgc.WT_Pct
	UNION
	--New code 3-19-2013 to get the correct TransferOut_Wt on FINAL to FINAL PigGroups---
	select fgc.CombPigGroup,
	case when left(fgc.CombPigGroup,3)='NEG' then sum(pit.TotalWgt) * -1
	else sum(pit.TotalWgt) end as TransferOut_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	inner join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID=right(rtrim(fgc.CombPigGroup),5) and pit.SourcePigGroupID=fgc.SourceGroup and pit.acct='PIG TRANSFER IN' and pit.TranSubTypeID not in ('FT','WT')
	---Add this 3/2/2016 so that reversals are taken out jlm
	and pit.Reversal<>1	
	where fgc.SourceGroup in (select distinct Source_PigGroupID from dbo.cft_SLF_FINAL_TO_FINAL)
	group by fgc.CombPigGroup
	UNION
	select fgc.CombPigGroup,
	case when left(fgc.CombPigGroup,3)='NEG' then sum(pit.TotalWgt) * -1
	else sum(pit.TotalWgt) end as TransferOut_Wt
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	inner join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on 'PG'+rtrim(pit.PigGroupID)=rtrim(fgc.CombPigGroup) and pit.acct='PIG TRANSFER OUT' and pit.TranSubTypeID not in ('FT','WT')
	---Add this 3/2/2016 so that reversals are taken out jlm
	and pit.Reversal<>1
	where fgc.SourceGroup in (select distinct Source_PigGroupID from dbo.cft_SLF_FINAL_TO_FINAL)
	group by fgc.CombPigGroup
	) TOQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TOQ.CombPigGroup)

-------------------------------------------------------
--TransferToTailender_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET TransferToTailender_Wt = TOQ.TransferToTailender_Wt
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pit.TotalWgt) as TransferToTailender_Wt
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	on pit.PigGroupID = fgc.PigGroupID
	where pit.Reversal<>1 and pit.acct='PIG TRANSFER OUT' and pit.TranSubTypeID in ('FT','WT')
	group by fgc.PigGroupID
	) TOQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(TOQ.CombPigGroup)

-------------------------------------------------------
--Prim_Qty------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Prim_Qty = MIQ.Prim_Qty
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.Prim_Qty) as Prim_Qty
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_QTY psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID	
	) MIQ
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(MIQ.CombPigGroup)

-------------------------------------------------------
--Cull_Qty---------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Cull_Qty = PSC.Cull_Qty
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.Cull_Qty) as Cull_Qty
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_QTY psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID
	) PSC
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSC.CombPigGroup)

-------------------------------------------------------
--DeadOnTruck_Qty---------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET DeadOnTruck_Qty = PSD.DeadOnTruck_Qty
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.DeadOnTruck_Qty) as DeadOnTruck_Qty
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_QTY psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID
	) PSD
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSD.CombPigGroup)

-------------------------------------------------------
--DeadInYard_Qty---------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET DeadInYard_Qty = PSD.DeadInYard_Qty
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.DeadInYard_Qty) as DeadInYard_Qty
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_QTY psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID
	) PSD
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSD.CombPigGroup)

-------------------------------------------------------
--Condemn_Qty---------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Condemn_Qty = PSD.Condemn_Qty
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.Condemn_Qty) as Condemn_Qty
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_QTY psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID
	) PSD
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSD.CombPigGroup)

-------------------------------------------------------
--Prim_Wt------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Prim_Wt = PSW.Prim_Wt
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.Prim_Wt) as Prim_Wt
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_WT psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID		
	) PSW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSW.CombPigGroup)

-------------------------------------------------------
--Cull_Wt----------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Cull_Wt = PSW.Cull_Wt
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.Cull_Wt) as Cull_Wt
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_WT psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID		
	) PSW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSW.CombPigGroup)

-------------------------------------------------------
--DeadOnTruck_Wt----------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET DeadOnTruck_Wt = PSW.DeadOnTruck_Wt
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.DeadOnTruck_Wt) as DeadOnTruck_Wt
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_WT psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID		
	) PSW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSW.CombPigGroup)

-------------------------------------------------------
--DeadInYard_Wt----------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET DeadInYard_Wt = PSW.DeadInYard_Wt
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.DeadInYard_Wt) as DeadInYard_Wt
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_WT psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID		
	) PSW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSW.CombPigGroup)

-------------------------------------------------------
--Condemn_Wt----------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET Condemn_Wt = PSW.Condemn_Wt
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(psq.Condemn_Wt) as Condemn_Wt
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_PIGSALES_WT psq WITH (NOLOCK)
	on psq.PigGroupID = fgc.PigGroupID
	group by fgc.PigGroupID		
	) PSW
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(PSW.CombPigGroup)

-------------------------------------------------------
--HdCapacity-------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET HdCapacity = HC.HdCapacity
FROM
	(
	select fgc.CombPigGroup,
	[$(SolomonApp)].dbo.PGGetMaxCapacity(fgc.SourceGroup) *
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as HdCapacity
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	) HC
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(HC.CombPigGroup)

-------------------------------------------------------
--MaxCapacityDays-------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET MaxCapacityDays = HC.MaxCapacityDays
FROM
	(
	select fgc.CombPigGroup,
	(DATEDIFF(day,pg.ActStartDate,e.TranDate)+1) * [$(SolomonApp)].dbo.PGGetMaxCapacity(fgc.SourceGroup) *
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as MaxCapacityDays
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.vCFPigGroupEnd e WITH (NOLOCK)
	on e.PigGroupID=fgc.SourceGroup
	left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	on pg.PigGroupID=fgc.SourceGroup
	) HC
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(HC.CombPigGroup)

-------------------------------------------------------
--EmptyCapacityDays-------------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA
SET EmptyCapacityDays = HC.EmptyCapacityDays
FROM
	(
	select fgc.CombPigGroup,
	(DATEDIFF(day,pg.ActStartDate,s.TranDate)+1) * [$(SolomonApp)].dbo.PGGetMaxCapacity(fgc.SourceGroup) *
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as EmptyCapacityDays
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.vCFPigGroupStart s WITH (NOLOCK)
	on s.PigGroupID=fgc.SourceGroup
	left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	on pg.PigGroupID=fgc.SourceGroup
	) HC
join  dbo.cft_SLF_ESSBASE_DATA ed
on rtrim(ed.Group_Number) = rtrim(HC.CombPigGroup)
--31 Update Caculations witin the Essbase Data Table


--32 Create Insert into SLF Flow Group Rollup
TRUNCATE TABLE  dbo.cft_SLF_FLOWGROUP_ROLLUP
INSERT INTO  dbo.cft_SLF_FLOWGROUP_ROLLUP
(Site,
MasterGroup,
MasterGroupDescription,
FlowGroup,
FlowGroupDescription,
PigFlowID,
PigFlowDescription,
PG_Week,
MG_Week,
Scenario,
FlowGroupFeedMill,
TransferInWP_Qty,
TransferIn_Qty,
MoveIn_Qty,
MoveOut_Qty,
PigDeath_Qty,
PigDeathTD_Qty,
TransportDeath_Qty,
InventoryAdjustment_Qty,
TransferOut_Qty,
TransferToTailender_Qty,
Prim_Qty,
Cull_Qty,
DeadOnTruck_Qty,
DeadInYard_Qty,
Condemn_Qty,
TransferInWP_Wt,
TransferIn_Wt,
MoveIn_Wt,
MoveOut_Wt,
PigDeathTD_Wt,
TransportDeath_Wt,
TransferOut_Wt,
TransferToTailender_Wt,
Prim_Wt,
Cull_Wt,
DeadOnTruck_Wt,
DeadInYard_Wt,
Condemn_Wt,
DeadPigDays,
LivePigDays,
Feed_Qty,
HdCapacity,
MaxCapacityDays,
EmptyCapacityDays
)

select
Site,
MasterGroup,
MasterGroupDescription,
FlowGroup,
FlowGroupDescription,
PigFlowID,
PigFlowDescription,
PG_Week,
MG_Week,
Scenario,
max(FlowGroupFeedMill) as FlowGroupFeedMill,
sum(TransferInWP_Qty) as TransferInWP_Qty,
sum(TransferIn_Qty) as TransferIn_Qty,
sum(MoveIn_Qty) as MoveIn_Qty,
sum(MoveOut_Qty) as MoveOut_Qty,
sum(PigDeath_Qty) as PigDeath_Qty,
sum(PigDeathTD_Qty) as PigDeathTD_Qty,
sum(TransportDeath_Qty) as TransportDeath_Qty,
sum(InventoryAdjustment_Qty) as InventoryAdjustment_Qty,
sum(TransferOut_Qty) as TransferOut_Qty,
sum(TransferToTailender_Qty) as TransferToTailender_Qty,
sum(Prim_Qty) as Prim_Qty,
sum(Cull_Qty) as Cull_Qty,
sum(DeadOnTruck_Qty) as DeadOnTruck_Qty,
sum(DeadInYard_Qty) as DeadInYard_Qty,
sum(Condemn_Qty) as Condemn_Qty,
sum(TransferInWP_Wt) as TransferInWP_Wt,
sum(TransferIn_Wt) as TransferIn_Wt,
sum(MoveIn_Wt) as MoveIn_Wt,
sum(MoveOut_Wt) as MoveOut_Wt,
sum(PigDeathTD_Wt) as PigDeathTD_Wt,
sum(TransportDeath_Wt) as TransportDeath_Wt,
sum(TransferOut_Wt) as TransferOut_Wt,
sum(TransferToTailender_Wt) as TransferToTailender_Wt,
sum(Prim_Wt) as Prim_Wt,
sum(Cull_Wt) as Cull_Wt,
sum(DeadOnTruck_Wt) as DeadOnTruck_Wt,
sum(DeadInYard_Wt) as DeadInYard_Wt,
sum(Condemn_Wt) as Condemn_Wt,
sum(DeadPigDays) as DeadPigDays,
sum(LivePigDays) as LivePigDays,
sum(Feed_Qty) as Feed_Qty,
sum(HdCapacity) as HdCapacity,
sum(MaxCapacityDays) as MaxCapacityDays,
sum(EmptyCapacityDays) as EmptyCapacityDays
from  dbo.cft_SLF_ESSBASE_DATA WITH (NOLOCK)
group by
Site,
MasterGroup,
MasterGroupDescription,
FlowGroup,
FlowGroupDescription,
PigFlowID,
PigFlowDescription,
PG_Week,
MG_Week,
Scenario
order by FlowGroup
--32 Create Insert into SLF Flow Group Rollup


--33 Create Insert into SLF Flow Group Calcs
TRUNCATE TABLE  dbo.cft_SLF_FLOWGROUP_CALCS
INSERT INTO  dbo.cft_SLF_FLOWGROUP_CALCS
(FlowGroup,
FlowGroupDescription,
WeanPigsIn_Qty,
WeanPigsIn_Wt,
AvgWeanPig_Wt,
HeadStarted,
AvgMarket_Wt,
TotalMarketLbs,
TotalMarketQty,
WeightGained,
TotalPigDays,
MortalityRate,
ADG,
FeedEfficiency,
DOA_Pct,
DIY_Pct,
Condemn_Pct,
WTF_DownDays,
Utilization,
DaysToMarket)

select FlowGroup,FlowGroupDescription,
TransferInWP_Qty as WeanPigsIn_Qty,
TransferInWP_Wt as WeanPigsIn_Wt,
case when TransFerInWP_Qty=0 then 0
else TransferInWP_Wt/TransFerInWP_Qty end as AvgWeanPig_Wt,
TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty as HeadStarted,
case when (Prim_Qty+Cull_Qty)=0 then 0
else (Prim_Wt+Cull_Wt)/(Prim_Qty+Cull_Qty) end as AvgMarket_Wt,
Prim_Wt+Cull_Wt as TotalMarketLbs,
Prim_Qty+Cull_Qty as TotalMarketQty,
(Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt) as WeightGained,
LivePigDays+DeadPigDays as TotalPigDays,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else (PigDeath_Qty+PigDeathTD_Qty+TransPortDeath_Qty)/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as MortalityRate,
((Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt))/
(LivePigDays+DeadPigDays) as ADG,
case when ((Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt))=0 then 0
else Feed_Qty/((Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt)) end as FeedEfficiency,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else DeadOnTruck_Qty/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as DOA_Pct,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else DeadInYard_Qty/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as DIY_Pct,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else Condemn_Qty/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as Condemn_Pct,
case when HdCapacity=0 then 0
else EmptyCapacityDays/HdCapacity end as WTF_DownDays,
case when MaxCapacityDays=0 then 0
else (LivePigDays+DeadPigDays)/MaxCapacityDays * 100 end as Utilization,
case when (Prim_Qty+Cull_Qty+TransferToTailender_Qty)=0 then 0
else LivePigDays/(Prim_Qty+Cull_Qty+TransferToTailender_Qty) end as DaysToMarket
from  dbo.cft_SLF_FLOWGROUP_ROLLUP
order by FlowGroup
--33 Create Insert into SLF Flow Group Calcs


--34 Create Insert into SLF Flow Month Rollup
TRUNCATE TABLE  dbo.cft_SLF_FLOW_MONTH_ROLLUP
INSERT INTO  dbo.cft_SLF_FLOW_MONTH_ROLLUP
(PigFlowID,
PigFlowDescription,
FYPeriod,
TransferInWP_Qty,
TransferIn_Qty,
MoveIn_Qty,
MoveOut_Qty,
PigDeath_Qty,
PigDeathTD_Qty,
TransportDeath_Qty,
InventoryAdjustment_Qty,
TransferOut_Qty,
TransferToTailender_Qty,
Prim_Qty,
Cull_Qty,
DeadOnTruck_Qty,
DeadInYard_Qty,
Condemn_Qty,
TransferInWP_Wt,
TransferIn_Wt,
MoveIn_Wt,
MoveOut_Wt,
PigDeathTD_Wt,
TransportDeath_Wt,
TransferOut_Wt,
TransferToTailender_Wt,
Prim_Wt,
Cull_Wt,
DeadOnTruck_Wt,
DeadInYard_Wt,
Condemn_Wt,
DeadPigDays,
LivePigDays,
Feed_Qty,
HdCapacity,
MaxCapacityDays,
EmptyCapacityDays
)

select
PigFlowID,
PigFlowDescription,
d.FYPeriod,
sum(TransferInWP_Qty) as TransferInWP_Qty,
sum(TransferIn_Qty) as TransferIn_Qty,
sum(MoveIn_Qty) as MoveIn_Qty,
sum(MoveOut_Qty) as MoveOut_Qty,
sum(PigDeath_Qty) as PigDeath_Qty,
sum(PigDeathTD_Qty) as PigDeathTD_Qty,
sum(TransportDeath_Qty) as TransportDeath_Qty,
sum(InventoryAdjustment_Qty) as InventoryAdjustment_Qty,
sum(TransferOut_Qty) as TransferOut_Qty,
sum(TransferToTailender_Qty) as TransferToTailender_Qty,
sum(Prim_Qty) as Prim_Qty,
sum(Cull_Qty) as Cull_Qty,
sum(DeadOnTruck_Qty) as DeadOnTruck_Qty,
sum(DeadInYard_Qty) as DeadInYard_Qty,
sum(Condemn_Qty) as Condemn_Qty,
sum(TransferInWP_Wt) as TransferInWP_Wt,
sum(TransferIn_Wt) as TransferIn_Wt,
sum(MoveIn_Wt) as MoveIn_Wt,
sum(MoveOut_Wt) as MoveOut_Wt,
sum(PigDeathTD_Wt) as PigDeathTD_Wt,
sum(TransportDeath_Wt) as TransportDeath_Wt,
sum(TransferOut_Wt) as TransferOut_Wt,
sum(TransferToTailender_Wt) as TransferToTailender_Wt,
sum(Prim_Wt) as Prim_Wt,
sum(Cull_Wt) as Cull_Wt,
sum(DeadOnTruck_Wt) as DeadOnTruck_Wt,
sum(DeadInYard_Wt) as DeadInYard_Wt,
sum(Condemn_Wt) as Condemn_Wt,
sum(DeadPigDays) as DeadPigDays,
sum(LivePigDays) as LivePigDays,
sum(Feed_Qty) as Feed_Qty,
sum(HdCapacity) as HdCapacity,
sum(MaxCapacityDays) as MaxCapacityDays,
sum(EmptyCapacityDays) as EmptyCapacityDays
from  dbo.cft_SLF_ESSBASE_DATA WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d WITH (NOLOCK)
on d.PICYear_Week=PG_Week
group by
PigFlowID,
PigFlowDescription,
d.FYPeriod
order by d.FYPeriod,PigFlowDescription
--34 Create Insert into SLF Flow Month Rollup


--35 Create Insert into SLF Flow Month Calcs
TRUNCATE TABLE  dbo.cft_SLF_FLOW_MONTH_CALCS
INSERT INTO  dbo.cft_SLF_FLOW_MONTH_CALCS
(PigFlowID,
PigFlowDescription,
FYPeriod,
WeanPigsIn_Qty,
WeanPigsIn_Wt,
AvgWeanPig_Wt,
HeadStarted,
AvgMarket_Wt,
TotalMarketLbs,
TotalMarketQty,
WeightGained,
TotalPigDays,
MortalityRate,
ADG,
FeedEfficiency,
DOA_Pct,
DIY_Pct,
Condemn_Pct,
WTF_DownDays,
Utilization,
DaysToMarket)

select PigFlowID,PigFlowDescription,FYPeriod,
TransferInWP_Qty as WeanPigsIn_Qty,
TransferInWP_Wt as WeanPigsIn_Wt,
case when TransFerInWP_Qty=0 then 0
else TransferInWP_Wt/TransFerInWP_Qty end as AvgWeanPig_Wt,
TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty as HeadStarted,
case when (Prim_Qty+Cull_Qty)=0 then 0
else (Prim_Wt+Cull_Wt)/(Prim_Qty+Cull_Qty) end as AvgMarket_Wt,
Prim_Wt+Cull_Wt as TotalMarketLbs,
Prim_Qty+Cull_Qty as TotalMarketQty,
(Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt) as WeightGained,
LivePigDays+DeadPigDays as TotalPigDays,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else (PigDeath_Qty+PigDeathTD_Qty+TransPortDeath_Qty)/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as MortalityRate,
((Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt))/
(LivePigDays+DeadPigDays) as ADG,
case when ((Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt))=0 then 0
else Feed_Qty/((Prim_Wt+Cull_Wt+DeadOnTruck_Wt+DeadInYard_Wt+Condemn_Wt+TransferToTailender_Wt) -
(TransferInWP_Wt+TransferIn_Wt+MoveIn_Wt-MoveOut_Wt-TransferOut_Wt)) end as FeedEfficiency,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else DeadOnTruck_Qty/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as DOA_Pct,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else DeadInYard_Qty/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as DIY_Pct,
case when (TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)=0 then 0
else Condemn_Qty/(TransFerInWP_Qty+TransferIn_Qty+MoveIn_Qty-MoveOut_qty-TransferOut_Qty)*100 end as Condemn_Pct,
case when HdCapacity=0 then 0
else EmptyCapacityDays/HdCapacity end as WTF_DownDays,
case when MaxCapacityDays=0 then 0
else (LivePigDays+DeadPigDays)/MaxCapacityDays * 100 end as Utilization,
case when (Prim_Qty+Cull_Qty+TransferToTailender_Qty)=0 then 0
else LivePigDays/(Prim_Qty+Cull_Qty+TransferToTailender_Qty) end as DaysToMarket
from  dbo.cft_SLF_FLOW_MONTH_ROLLUP
order by FYPeriod,PigFlowDescription
--35 Create Insert into SLF Flow Month Calcs


--36 Create Insert Essbase Data Costs
TRUNCATE TABLE  dbo.cft_SLF_ESSBASE_DATA_COSTS
INSERT INTO  dbo.cft_SLF_ESSBASE_DATA_COSTS
(Site,
MasterGroup,
MasterGroupDescription,
FlowGroup,
FlowGroupDescription,
CombWTFGroup,
Phase,
PhaseTypeDesc,
PigFlowID,
PigFlowDescription,
PG_Week,
MG_Week,
Scenario,
FEED_ISSUE,
FREIGHT,
MISC_JOB_CHARGES,
OTHER_REVENUE,
PIG_BASE_DOLLARS,
PIG_DEATH,
PIG_FEED_DELIV,
PIG_FEED_GRD_MIX,
PIG_FEED_ISSUE,
PIG_GRADE_PREM,
PIG_INT_WC_CHG,
PIG_MEDS_CHG,
PIG_MEDS_ISSUE,
PIG_MISC_EXP,
PIG_MKT_TRUCKING,
PIG_MOVE_IN,
PIG_MOVE_OUT,
PIG_OVR_HD_CHG,
PIG_OVR_HD_COST,
PIG_PURCHASE,
PIG_SALE,
PIG_SALE_DED_OTR,
PIG_SITE_CHG,
PIG_SORT_LOSS,
PIG_TRANSFER_IN,
PIG_TRANSFER_OUT,
PIG_TRUCKING_CHG,
PIG_TRUCKING_IN,
PIG_VACC_CHG,
PIG_VACC_ISSUE,
PIG_VET_CHG,
REPAIR_MAINT,
REPAIR_PARTS,
SITE_COST_ACCUM,
SUPPLIES,
TRANSPORT_DEATH,
reportinggroupid,
reporting_group_description
)
select c.ContactName as Site,'MG'+rtrim(fg.MasterGroup) as MasterGroup,
'MG'+rtrim(fg.MasterGroup)+'-'+rtrim(c.ContactName) as MasterGroupDescription,
rtrim(fg1.FlowGroup) as FlowGroup,
rtrim(fg1.FlowGroup)+'-'+rtrim(pg.Description) as FlowGroupDescription,
rtrim(fg1.CombPigGroup) as CombWTFGroup,
fg.PigProdPhaseID as Phase,

rtrim(ptd.PhaseTypeDesc) as PhaseTypeDesc,

case when pgf.PigFlowID is null then '0'
else pgf.PigFlowID end as PigFlowID,
case when pf.PigFlowDescription is null then 'Other'
else pf.PigFlowDescription end as PigFlowDescription,
ddpg.PICYear_Week as PG_Week,
ddmg.PICYear_Week as MG_Week,
'Actual' as Scenario,
0 as FEED_ISSUE,
0 as FREIGHT,
0 as MISC_JOB_CHARGES,
0 as OTHER_REVENUE,
0 as PIG_BASE_DOLLARS,
0 as PIG_DEATH,
0 as PIG_FEED_DELIV,
0 as PIG_FEED_GRD_MIX,
0 as PIG_FEED_ISSUE,
0 as PIG_GRADE_PREM,
0 as PIG_INT_WC_CHG,
0 as PIG_MEDS_CHG,
0 as PIG_MEDS_ISSUE,
0 as PIG_MISC_EXP,
0 as PIG_MKT_TRUCKING,
0 as PIG_MOVE_IN,
0 as PIG_MOVE_OUT,
0 as PIG_OVR_HD_CHG,
0 as PIG_OVR_HD_COST,
0 as PIG_PURCHASE,
0 as PIG_SALE,
0 as PIG_SALE_DED_OTR,
0 as PIG_SITE_CHG,
0 as PIG_SORT_LOSS,
0 as PIG_TRANSFER_IN,
0 as PIG_TRANSFER_OUT,
0 as PIG_TRUCKING_CHG,
0 as PIG_TRUCKING_IN,
0 as PIG_VACC_CHG,
0 as PIG_VACC_ISSUE,
0 as PIG_VET_CHG,
0 as REPAIR_MAINT,
0 as REPAIR_PARTS,
0 as SITE_COST_ACCUM,
0 as SUPPLIES,
0 as TRANSPORT_DEATH,
pgf.reportinggroupid,
rg.reporting_group_description
from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fg1 WITH (NOLOCK)
left join  dbo.cft_SLF_FINAL_PIG_GROUPS fg WITH (NOLOCK)
on 'FG'+rtrim(fg.PigGroupID)=fg1.FlowGroup
left join  dbo.cft_PIG_GROUP_ROLLUP pgf WITH (NOLOCK)
on rtrim(pgf.TaskID)='PG'+right(rtrim(fg1.FlowGroup),5)
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf WITH (NOLOCK)
on pf.PigFlowID=pgf.PigFlowID
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP rg (Nolock)
	on rg.reportinggroupid = pgf.reportinggroupid
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo ddpg WITH (NOLOCK)
on ddpg.DayDate=fg.ActCloseDate
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo ddmg WITH (NOLOCK)
on ddmg.DayDate=fg.MGActCloseDate
left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
on pg.PigGroupID=fg.PigGroupID
left join [$(SolomonApp)].dbo.cftContact c WITH (NOLOCK)
on c.ContactID=pg.SiteContactID
left join  dbo.cft_SLF_PHASE_TYPE pt WITH (NOLOCK)
on pt.FlowGroup=fg1.FlowGroup
left join  dbo.cft_SLF_PHASE_TYPE_DESCRIPTION ptd WITH (NOLOCK)
on pt.PhaseType=ptd.PhaseType
order by FlowGroup

--36 Create Insert Essbase Data Costs


--37 Update Calculations of Essbase Data Costs
------------------------------------------------------------
--Insert Account values into cft_SLF_ESSBASE_DATA_COSTS-----
------------------------------------------------------------

------------------------------------------------------------
--PIG_FEED_ISSUE--------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_FEED_ISSUE = pgc.PIG_FEED_ISSUE
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as PIG_FEED_ISSUE
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG FEED ISSUE'
	group by fgc.CombPigGroup,fgc.WG_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_FEED_DELIV--------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_FEED_DELIV = pgc.PIG_FEED_DELIV
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as PIG_FEED_DELIV
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG FEED DELIV'
	group by fgc.CombPigGroup,fgc.WG_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_FEED_GRD_MIX------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_FEED_GRD_MIX = pgc.PIG_FEED_GRD_MIX
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Weight Gained (WG)------
	fgc.WG_Pct as PIG_FEED_GRD_MIX
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG FEED GRD MIX'
	group by fgc.CombPigGroup,fgc.WG_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_MOVE_IN-----------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_MOVE_IN = pgc.PIG_MOVE_IN
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_MOVE_IN
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG MOVE IN'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_MOVE_OUT-----------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_MOVE_OUT = pgc.PIG_MOVE_OUT
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_MOVE_OUT
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG MOVE OUT'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_TRUCKING_IN-------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_TRUCKING_IN = pgc.PIG_TRUCKING_IN
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_TRUCKING_IN
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG TRUCKING IN'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_TRUCKING_CHG------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_TRUCKING_CHG = pgc.PIG_TRUCKING_CHG
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_TRUCKING_CHG
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG TRUCKING CHG'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_SITE_CHG----------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_SITE_CHG = pgc.PIG_SITE_CHG
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_SITE_CHG
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG SITE CHG'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_MEDS_CHG----------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_MEDS_CHG = pgc.PIG_MEDS_CHG
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_MEDS_CHG
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG MEDS CHG'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_VACC_CHG----------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_VACC_CHG = pgc.PIG_VACC_CHG
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_VACC_CHG
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG VACC CHG'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_OVR_HD_CHG--------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_OVR_HD_CHG = pgc.PIG_OVR_HD_CHG
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_OVR_HD_CHG
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG OVR HD CHG'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_INT_WC_CHG--------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_INT_WC_CHG = pgc.PIG_INT_WC_CHG
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_INT_WC_CHG
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG INT WC CHG'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

------------------------------------------------------------
--PIG_MISC_EXP----------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_MISC_EXP = pgc.PIG_MISC_EXP
FROM
	(
	select
	fgc.CombPigGroup,
	sum(pjp.act_amount)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct as PIG_MISC_EXP
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.SourceGroup
	where pjp.acct='PIG MISC EXP'
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup

-------------------------------------------------------
--PIG_BASE_DOLLARS-------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_BASE_DOLLARS = PS.PIG_BASE_DOLLARS
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pjp.act_amount) as PIG_BASE_DOLLARS
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.PigGroupID
	where pjp.acct='PIG BASE DOLLARS'	--base sales dollars for pigs sold
	group by fgc.PigGroupID	
	) PS
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on rtrim(ed.CombWTFGroup) = rtrim(PS.CombPigGroup)

-------------------------------------------------------
--PIG_GRADE_PREM-------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_GRADE_PREM = PS.PIG_GRADE_PREM
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pjp.act_amount) as PIG_GRADE_PREM
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.PigGroupID
	where pjp.acct='PIG GRADE PREM'	-- Pig Sale Grade Premium
	group by fgc.PigGroupID	
	) PS
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on rtrim(ed.CombWTFGroup) = rtrim(PS.CombPigGroup)

-------------------------------------------------------
--PIG_SORT_LOSS----------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_SORT_LOSS = PS.PIG_SORT_LOSS
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pjp.act_amount) as PIG_SORT_LOSS
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.PigGroupID
	where pjp.acct='PIG SORT LOSS'
	group by fgc.PigGroupID	
	) PS
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on rtrim(ed.CombWTFGroup) = rtrim(PS.CombPigGroup)

-------------------------------------------------------
--PIG_MKT_TRUCKING-------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_MKT_TRUCKING = PS.PIG_MKT_TRUCKING
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pjp.act_amount) as PIG_MKT_TRUCKING
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.PigGroupID
	where pjp.acct='PIG MKT TRUCKING'
	group by fgc.PigGroupID	
	) PS
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on rtrim(ed.CombWTFGroup) = rtrim(PS.CombPigGroup)

-------------------------------------------------------
--PIG_SALE_DED_OTR-------------------------------------
-------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_SALE_DED_OTR = PS.PIG_SALE_DED_OTR
FROM
	(
	select 'PG'+rtrim(fgc.PigGroupID) as CombPigGroup,
	sum(pjp.act_amount) as PIG_SALE_DED_OTR
	from  dbo.cft_SLF_FINAL_PIG_GROUPS fgc WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	on right(rtrim(pjp.pjt_entity),5) = fgc.PigGroupID
	where pjp.acct='PIG SALE DED OTR'
	group by fgc.PigGroupID	
	) PS
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on rtrim(ed.CombWTFGroup) = rtrim(PS.CombPigGroup)

------------------------------------------------------------
--PIG_TRANSFER_IN-------------------------------------------
------------------------------------------------------------
UPDATE  dbo.cft_SLF_ESSBASE_DATA_COSTS
SET PIG_TRANSFER_IN = pgc.PIG_TRANSFER_IN
FROM
	(
	select
	fgc.CombPigGroup,
	isnull(sum(wp.Qty*wp.ThreeMoWPCost),0)*
	--Allocation is now set as Head Count (HC)------
	fgc.HC_Pct
	as PIG_TRANSFER_IN
	from  dbo.cft_SLF_FLOWGROUP_COMPOSITION fgc WITH (NOLOCK)
	left join  dbo.cft_SLF_TRANSFER_ALL_COST_WP wp WITH (NOLOCK)
	on wp.PigGroupID=fgc.SourceGroup
	group by fgc.CombPigGroup,fgc.HC_Pct
	) pgc
join  dbo.cft_SLF_ESSBASE_DATA_COSTS ed
on ed.CombWTFGroup = pgc.CombPigGroup
--37 Update Calculations of Essbase Data Costs
END
