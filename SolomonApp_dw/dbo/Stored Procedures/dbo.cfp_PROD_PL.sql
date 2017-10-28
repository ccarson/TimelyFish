



-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Prod P&L and Pig Movement Data
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PROD_PL]
(
	
	 @StartPeriod	int
	,@EndPeriod		int
   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @HeadCap Table
	(Sub int
	,SiteID varchar(50)
	,FYPeriod float
	,Head float
	,LiveWgt float
	,Cap float)

	Insert into @HeadCap

	Select 
	Sub.Sub,
	Sow.SiteID,
	gp.GroupPeriod,
	SUM(Sow.GoodPigs) as Head,
	'' as 'LiveWgt',
	SUM(Sow.SowDays)/SUM(wd.Days) as 'Cap'

	From (Select Distinct
	WeekOfDate, 
	Case When FiscalPeriod < 10 Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end as 'GroupPeriod'
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) GP

	left join (

	Select 
	cftSite.SiteID,
	gp.WeekOfDate,
	SUM(gp.GoodPigs) as 'GoodPigs',
	SUM(gp.SowDays) as 'SowDays'
	from  dbo.cft_SOW_SOWDAYS_GOODPIGS gp
	left join [$(SolomonApp)].dbo.cftSite cftSite
	on gp.ContactID = cftSite.ContactID
	Group by
	cftSite.SiteID,
	gp.WeekOfDate) Sow
	on GP.WeekOfDate = Sow.WeekOfDate
	
	left join (

	Select 
	COUNT(DayDate) as Days, 
	WeekOfDate, 
	FiscalYear, 
	FiscalPeriod
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo 
	Group by 
	WeekOfDate, 
	FiscalYear, 
	FiscalPeriod) WD
	on GP.WeekOfDate = WD.WeekOfDate
	
	left join (

	Select Distinct
	GroupPeriod,
	Sub
	From  dbo.cft_PRODUCTION_PL_2
	where GroupPeriod >= 200801) Sub
	on Sow.SiteID = RIGHT(rtrim(sub.Sub),4)
	and gp.GroupPeriod = Sub.GroupPeriod
	
	Group by
	Sub.Sub,
	Sow.SiteID,
	gp.GroupPeriod
	
	union
	
	Select
	Sub.Sub,
	n.SiteID,
	Sub.GroupPeriod,
	SUM(n.GoodPigs) as 'Head',
	'' as 'LiveWgt',
	Cap.AvgInventory as 'Cap'

	From (Select Distinct
	GroupPeriod,
	Sub
	From  dbo.cft_PRODUCTION_PL_2
	where GroupPeriod >= 200801
	and LEFT(rtrim(Sub),4) in (1530,2130)) Sub
	
	left join (

	Select 
	S.SiteID,
	Case When D.FiscalPeriod < 10 Then Rtrim(Cast(D.FiscalYear as char))+'0'+Rtrim(Cast(D.FiscalPeriod as char)) 
	else Rtrim(Cast(D.FiscalYear as char))+Rtrim(Cast(D.FiscalPeriod as char)) end As FiscalPerPost,
	Case When CT.PigGradeCatTypeDesc = 'Standards' then Sum(G.Qty) 
	When CT.PigGradeCatTypeDesc = 'Dead before Grade' then Sum(G.Qty)
	When CT.PigGradeCatTypeDesc = 'Dead on truck' then Sum(G.Qty) Else 0 End GoodPigs

	from [$(SolomonApp)].dbo.cftPMGradeQty G
	join [$(SolomonApp)].dbo.cftPMTranspRecord T
	on t.RefNbr=G.RefNbr
	join [$(SolomonApp)].dbo.cftContact C
	on C.ContactID=T.SourceContactID
	join [$(SolomonApp)].dbo.cftPigGradeCatType CT
	on CT.PigGradeCatTypeID=G.PigGradeCatTypeID
	left join [$(SolomonApp)].dbo.cftpmtransprecord re
	on (T.refnbr = re.origrefnbr)
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo D
	on D.DayDate=T.MovementDate
	left join [$(SolomonApp)].dbo.cftSite S
	on C.ContactID=S.ContactID

	left join [$(SolomonApp)].dbo.pjproj pj
	on S.SolomonProjectID=pj.project

	where
	t.PigTypeID='03'
	and left(T.SubTypeID,1) = 'N'
	and T.doctype <> 're'
	and re.refnbr is null
	and PICYear_Week >= '07WK01'

	group by
	S.SiteID,
	CT.PigGradeCatTypeDesc,
	Case When D.FiscalPeriod < 10 Then Rtrim(Cast(D.FiscalYear as char))+'0'+Rtrim(Cast(D.FiscalPeriod as char)) 
	else Rtrim(Cast(D.FiscalYear as char))+Rtrim(Cast(D.FiscalPeriod as char)) end) n
	on RIGHT(rtrim(sub.Sub),4) = n.SiteID
	and sub.GroupPeriod = n.FiscalPerPost

	left join (

	Select 
	S.SiteID,
	AI.ContactName,
	AI.GroupPeriod,
	AI.AvgInventory
	from  dbo.cft_GROWFIN_SITE_AVG_INVENTORY AI
	left join [$(SolomonApp)].dbo.cftSite S
	on AI.ContactID = Cast(S.ContactID as int)) Cap
	on RIGHT(rtrim(sub.Sub),4) = Cap.SiteID 
	and sub.GroupPeriod = Cap.GroupPeriod

	Group by
	Sub.Sub,
	n.SiteID,
	Sub.GroupPeriod,
	Cap.AvgInventory
	
	union

	select
	pl.Sub,
	RIGHT(rtrim(pl.Sub),4) as 'SiteID',
	pl.GroupPeriod,
	sum(PS2.HCRev) as 'Head',
	sum(PS2.LWRev) as 'LiveWgt',
	Cap.AvgInventory as 'Cap'
	
	From (Select Distinct Sub, GroupPeriod from  dbo.cft_PRODUCTION_PL_2
	where LEFT(rtrim(sub),4) in ('1531','2131','1532','2132')) PL
	
	left join (Select Sub, ProjectID, BatNbr, RefNbr, PerPost from [$(SolomonApp)].dbo.GLTran 
	where PerPost >= '200801' and Acct='40100'
	and LEFT(rtrim(sub),4) in ('1531','2131','1532','2132')) gl
	on pl.Sub = gl.Sub
	and pl.GroupPeriod = gl.PerPost
	
	left join (

	Select 
	Case When DocType='RE' then HCTot * -1 else HCTot end HCRev,
	Case When DocType='RE' then Headcount * -1 else Headcount end HdRev,
	Case When DocType='RE' then DelvLiveWgt * -1 else DelvLiveWgt end LWRev,
	*
	from [$(SolomonApp)].dbo.cftPigSale) PS2
	on gl.BatNbr=PS2.BatNbr 
	and gl.RefNbr=PS2.RefNbr

	left join (

	Select 
	S.SiteID,
	AI.ContactName,
	AI.GroupPeriod,
	AI.AvgInventory
	from  dbo.cft_GROWFIN_SITE_AVG_INVENTORY AI
	left join [$(SolomonApp)].dbo.cftSite S
	on AI.ContactID = Cast(S.ContactID as int)) Cap
	on RIGHT(rtrim(pl.Sub),4) = Cap.SiteID
	and pl.GroupPeriod = Cap.GroupPeriod 

	Group by
	pl.sub,
	RIGHT(rtrim(pl.Sub),4),
	pl.GroupPeriod,
	Cap.AvgInventory

	Select 
	pl.Sub,
	pl.Division,
	pl.Department,
	pl.Location,
	pl.GroupPeriod,
	flow.PigFlowDescription,
	flow.PhaseDesc,
	left(rtrim(pl.GroupPeriod),4) as FiscalYear,
	right(rtrim(pl.GroupPeriod),2) as FiscalPeriod,
	Case when pl.AccountRollup is null then 'Other' else pl.AccountRollup end as AccountRollup,
	pl.Descr,
	pl.TranDesc,
	pl.Amt,
	Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end as 'Budget',
	pl.Qty,
	Head.Head,
	Head.LiveWgt,
	Head.Cap,
	Case when Head.Cap = 0 then 0
	else ((PL.Amt/Head.Cap)/WK.Weeks)*52 end as AmtCap,
	Case when Head.Cap = 0 then 0
	else (((Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end)/Head.Cap)/WK.Weeks)*52 end as BudCap,
	Case when Head.Cap = 0 then 0
	else ((PL.Qty/Head.Cap)/WK.Weeks)*52 end as QtyCap,
	Case when Head.Head=0 then 0
	else PL.Amt/Head.Head end as AmtHead,
	Case when Head.Head=0 then 0
	else (Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end)/Head.Head end as BudHead,
	Case when Head.Head=0 then 0
	else PL.Qty/Head.Head end as QtyHead,
	DeptHead.Head as 'DeptHead',
	DeptFlowHead.Head as 'DeptFlowHead',
	DeptHead.LiveWgt as 'DeptLiveWgt',
	DeptFlowHead.LiveWgt as 'DeptFlowLiveWgt',
	DeptHead.Cap as 'DeptCap',
	DeptFlowHead.Cap as 'DeptFlowCap',
	Case when DeptHead.Cap = 0 then 0
	else ((PL.Amt/DeptHead.Cap)/WK.Weeks)*52 end as DeptAmtCap,
	Case when DeptFlowHead.Cap = 0 then 0
	else ((PL.Amt/DeptFlowHead.Cap)/WK.Weeks)*52 end as DeptFlowAmtCap,
	Case when DeptHead.Cap = 0 then 0
	else (((Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end)/DeptHead.Cap)/WK.Weeks)*52 end as DeptBudCap,
	Case when DeptHead.Cap = 0 then 0
	else ((PL.Qty/DeptHead.Cap)/WK.Weeks)*52 end as DeptQtyCap,
	Case when DeptFlowHead.Cap = 0 then 0
	else ((PL.Qty/DeptFlowHead.Cap)/WK.Weeks)*52 end as DeptFlowQtyCap,
	Case when DeptHead.Head=0 then 0
	else PL.Amt/DeptHead.Head end as DeptAmtHead,
	Case when DeptFlowHead.Head=0 then 0
	else PL.Amt/DeptFlowHead.Head end as DeptFlowAmtHead,
	Case when DeptHead.Head=0 then 0
	else (Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end)/DeptHead.Head end as DeptBudHead,
	Case when DeptHead.Head=0 then 0
	else PL.Qty/DeptHead.Head end as DeptQtyHead,
	Case when DeptFlowHead.Head=0 then 0
	else PL.Qty/DeptFlowHead.Head end as DeptFlowQtyHead,
	DivHead.Head as 'DivHead',
	DivFlowHead.Head as 'DivFlowHead',
	DivHead.LiveWgt as 'DivLiveWgt',
	DivFlowHead.LiveWgt as 'DivFlowLiveWgt',
	DivHead.Cap as 'DivCap',
	DivFlowHead.Cap as 'DivFlowCap',
	Case when DivHead.Cap = 0 then 0
	else ((PL.Amt/DivHead.Cap)/WK.Weeks)*52 end as DivAmtCap,
	Case when DivFlowHead.Cap = 0 then 0
	else ((PL.Amt/DivFlowHead.Cap)/WK.Weeks)*52 end as DivFlowAmtCap,
	Case when DivHead.Cap = 0 then 0
	else (((Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end)/DivHead.Cap)/WK.Weeks)*52 end as DivBudCap,
	Case when DivHead.Cap = 0 then 0
	else ((PL.Qty/DivHead.Cap)/WK.Weeks)*52 end as DivQtyCap,
	Case when DivFlowHead.Cap = 0 then 0
	else ((PL.Qty/DivFlowHead.Cap)/WK.Weeks)*52 end as DivFlowQtyCap,
	Case when DivHead.Head=0 then 0
	else PL.Amt/DivHead.Head end as DivAmtHead,
	Case when DivFlowHead.Head=0 then 0
	else PL.Amt/DivFlowHead.Head end as DivFlowAmtHead,
	Case when DivHead.Head=0 then 0
	else (Case when Bud.Budget is Null then 0 else Bud.Budget end + Case when BudSite.Budget is Null then 0 else BudSite.Budget end)/DivHead.Head end as DivBudHead,
	Case when DivHead.Head=0 then 0
	else PL.Qty/DivHead.Head end as DivQtyHead,
	Case when DivFlowHead.Head=0 then 0
	else PL.Qty/DivFlowHead.Head end as DivFlowQtyHead
	from  dbo.cft_PRODUCTION_PL_2 pl
	
	left join  dbo.cft_GROWFIN_SITE_FLOW flow
	on cast(right(rtrim(pl.Sub),4) as int) = flow.SiteID
	and pl.GroupPeriod = flow.GroupPeriod 
	
	left join (
	
	Select
	RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2) as 'Sub',
	'2012'+RIGHT(rtrim(FB.time),2) as 'GroupPeriod',
	Acct.Descr,
	Case when (Select COUNT(Sub) from  dbo.cft_PRODUCTION_PL_2 
	where left(rtrim(Sub),4) = RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2)
	and Descr = Acct.Descr and GroupPeriod = '2012'+RIGHT(rtrim(FB.time),2)) = 0 
	then SUM(FB.Total) else SUM(FB.Total)/(Select COUNT(Sub) from  dbo.cft_PRODUCTION_PL_2 
	where left(rtrim(Sub),4) = RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2)
	and Descr = Acct.Descr and GroupPeriod = '2012'+RIGHT(rtrim(FB.time),2)) end as 'Budget'
	from (select Scenario, Time, Company, Division, Department, Location, Account, Total 
	from  dbo.cft_PRODUCTION_PL_BUDGET
	where location = 'LOC0000') FB

	left join (Select Distinct Acct, Descr
	from [$(SolomonApp)].dbo.Account
	where AcctType in ('3I','3E')) Acct
	on RIGHT(rtrim(FB.Account),5) = Acct.Acct
	
	--Where RIGHT(rtrim(FB.Location),4) = '0000'

	Group by
	RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2),
	'2012'+RIGHT(rtrim(FB.time),2),
	Acct.Descr) Bud
	on left(rtrim(pl.Sub),4) = Bud.Sub
	and pl.Descr = Bud.Descr
	and pl.GroupPeriod = Bud.GroupPeriod
	
	left join (
	
	Select
	RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2)+RIGHT(rtrim(FB.Location),4) as 'Sub',
	'2012'+RIGHT(rtrim(FB.time),2) as 'GroupPeriod',
	Acct.Descr,
	Case when (Select COUNT(Sub) from  dbo.cft_PRODUCTION_PL_2 
	where Sub = RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2)+RIGHT(rtrim(FB.Location),4)
	and Descr = Acct.Descr and GroupPeriod = '2012'+RIGHT(rtrim(FB.time),2)) = 0 
	then SUM(FB.Total) else SUM(FB.Total)/(Select COUNT(Sub) from  dbo.cft_PRODUCTION_PL_2 
	where Sub = RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2)+RIGHT(rtrim(FB.Location),4)
	and Descr = Acct.Descr and GroupPeriod = '2012'+RIGHT(rtrim(FB.time),2)) end as 'Budget'
	from (select Scenario, Time, Company, Division, Department, Case when RIGHT(rtrim(Location),4) in ('8100','8120','8140') then 'LOC8121' 
	when RIGHT(rtrim(Location),4) in ('8150','8170','8190') then 'LOC8122' else Location end as 'Location', Account, Sum(Total) as 'Total'
	from  dbo.cft_PRODUCTION_PL_BUDGET
	where location <> 'LOC0000'
	group by Scenario, Time, Company, Division, Department, Case when RIGHT(rtrim(Location),4) in ('8100','8120','8140') then 'LOC8121' 
	when RIGHT(rtrim(Location),4) in ('8150','8170','8190') then 'LOC8122' else Location end, Account) FB

	left join (Select Distinct Acct, Descr
	from [$(SolomonApp)].dbo.Account
	where AcctType in ('3I','3E')) Acct
	on RIGHT(rtrim(FB.Account),5) = Acct.Acct

	Group by
	RIGHT(rtrim(FB.Division),2)+RIGHT(rtrim(FB.Department),2)+RIGHT(rtrim(FB.Location),4),
	'2012'+RIGHT(rtrim(FB.time),2),
	Acct.Descr) BudSite
	on pl.Sub = BudSite.Sub
	and pl.Descr = BudSite.Descr
	and pl.GroupPeriod = BudSite.GroupPeriod
	
	left join
	(Select 
	Count(WeekOfDate) Weeks,
	Case When FiscalPeriod < 10 
	Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end As GroupPeriod
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	Group by
	FiscalYear,
	FiscalPeriod) wk
	on pl.GroupPeriod = wk.GroupPeriod

	left join @HeadCap Head
	on pl.Sub = Head.Sub
	and pl.GroupPeriod = Head.FYPeriod
	
	left join (
	
	Select 
	Case when left(rtrim(Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(Sub),4) in (2132) then 'Multiplication WTF' else '' end as 'Department',
	FYPeriod,
	SUM(Head) as 'Head',
	SUM(LiveWgt) as 'LiveWgt',
	SUM(Cap) as 'Cap'
	
	from @HeadCap 
	
	Group by 
	Case when left(rtrim(Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(Sub),4) in (2132) then 'Multiplication WTF' else '' end,
	FYPeriod) DeptHead
	on pl.Department = DeptHead.Department
	and pl.GroupPeriod = DeptHead.FYPeriod
	
	left join (
	
	Select 
	Case when left(rtrim(Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(Sub),4) in (1532,2132) then 'WTF' else '' end as 'Division',
	FYPeriod,
	SUM(Head) as 'Head',
	SUM(LiveWgt) as 'LiveWgt',
	SUM(Cap) as 'Cap'
	
	from @HeadCap 
	
	Group by 
	Case when left(rtrim(Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(Sub),4) in (1532,2132) then 'WTF' else '' end,
	FYPeriod) DivHead
	on pl.Division = DivHead.Division
	and pl.GroupPeriod = DivHead.FYPeriod
	
	left join (
	
	Select 
	Case when left(rtrim(hc.Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(hc.Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(hc.Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(hc.Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(hc.Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(hc.Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(hc.Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(hc.Sub),4) in (2132) then 'Multiplication WTF' else '' end as 'Department',
	ai.PigFlowDescription, 
	hc.FYPeriod,
	SUM(hc.Head) as 'Head',
	SUM(hc.LiveWgt) as 'LiveWgt',
	SUM(hc.Cap) as 'Cap'
	
	from @HeadCap hc
	left join (Select s.SiteID, sf.PigFlowDescription, ai.AvgInventory, ai.GroupPeriod 
	from  dbo.cft_GROWFIN_SITE_AVG_INVENTORY ai
	left join [$(SolomonApp)].dbo.cftSite s
	on ai.ContactID = CAST(s.ContactID as int)
	left join  dbo.cft_GROWFIN_SITE_FLOW sf
	on s.SiteID = sf.SiteID
	and ai.GroupPeriod = sf.GroupPeriod) ai
	on hc.SiteID = ai.SiteID
	and hc.FYPeriod = ai.GroupPeriod
	
	Group by 
	Case when left(rtrim(hc.Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(hc.Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(hc.Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(hc.Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(hc.Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(hc.Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(hc.Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(hc.Sub),4) in (2132) then 'Multiplication WTF' else '' end,
	ai.PigFlowDescription, 
	hc.FYPeriod) DeptFlowHead
	on pl.Department = DeptFlowHead.Department
	and flow.PigFlowDescription = DeptFlowHead.PigFlowDescription
	and pl.GroupPeriod = DeptFlowHead.FYPeriod
	
	left join (
	
	Select 
	Case when left(rtrim(hc.Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(hc.Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(hc.Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(hc.Sub),4) in (1532,2132) then 'WTF' else '' end as 'Division',
	hc.FYPeriod,
	ai.PigFlowDescription,
	SUM(hc.Head) as 'Head',
	SUM(hc.LiveWgt) as 'LiveWgt',
	SUM(hc.Cap) as 'Cap'
	
	from @HeadCap hc
	left join (Select s.SiteID, sf.PigFlowDescription, ai.AvgInventory, ai.GroupPeriod 
	from  dbo.cft_GROWFIN_SITE_AVG_INVENTORY ai
	left join [$(SolomonApp)].dbo.cftSite s
	on ai.ContactID = CAST(s.ContactID as int)
	left join  dbo.cft_GROWFIN_SITE_FLOW sf
	on s.SiteID = sf.SiteID
	and ai.GroupPeriod = sf.GroupPeriod) ai
	on hc.SiteID = ai.SiteID
	and hc.FYPeriod = ai.GroupPeriod
	
	Group by 
	Case when left(rtrim(hc.Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(hc.Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(hc.Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(hc.Sub),4) in (1532,2132) then 'WTF' else '' end,
	ai.PigFlowDescription,
	hc.FYPeriod) DivFlowHead
	on pl.Division = DivFlowHead.Division
	and flow.PigFlowDescription = DivFlowHead.PigFlowDescription
	and pl.GroupPeriod = DivFlowHead.FYPeriod

	Where pl.GroupPeriod between @StartPeriod and @EndPeriod
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PROD_PL] TO [db_sp_exec]
    AS [dbo];

