-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/14/2011
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_PAYLEAN_MONTHLY_CLOSED_GROUP 
	(@Month Int, @Year Int)
	
AS
BEGIN

SET NOCOUNT ON;

Select pgr.TaskID
, pgr.ActCloseDate
, pl.PLHeadSold As TotalHeadProduced
, RTrim(Substring(pgr.TaskID,3,10)) As PigGroupID
, pgr.SiteContactID
, s.SiteContactName
, pgr.BarnNbr
, pgr.AveragePurchase_Wt as AverageStartingWeight
, pgr.AverageOut_Wt as AverageProducedWeight
, pgr.Mortality
, pgr.AverageDailyFeedIntake As ADFI
, pgr.AverageDailyGain AS ADG
, pgr.FeedToGain
, pgr.AdjFeedToGain
, pgr.DaysInGroup
, IsNull(pl.FQ_75,0) as FeedQuantity_75
, pl.FQ_75/pl.PLHeadSold  as PayleanMGPerPigProduced
, (pl.FQ_75/5.5)/pl.PLHeadSold PayleanDaysPerPigProduced
, pl.FirstPLDate as FirstPayleanDate
From  dbo.cft_Pig_Group_Rollup pgr
left join (
	Select f.PigGroupID,
	f.FirstPLDate,
	f.FQ_75,
	sum(ps.Headcount) PLHeadSold,
	sum(ps.Headcount * DateDiff(d,f.FirstPLDate,ps.SaleDate)) PayleanDays
	from (
		Select
		PigGroupID,
		Min(DateDel) FirstPLDate,
		Sum(QtyDel) FQ_75
		From [$(SolomonApp)].dbo.cftFeedOrder with (nolock)
		Where InvtIdDel like '%75%'
		and Reversal=0
		group by PigGroupID) f
		left join (
			select SaleDate,PigGroupID,TaskID,
			sum(HeadCount) Headcount
			From [$(SolomonApp)].dbo.cfvPIGSALEREV
			group by
			SaleDate,PigGroupID,TaskID
			) ps
		on ps.PigGroupID=f.PigGroupID 
		and ps.SaleDate>f.FirstPLDate
	group by
	f.PigGroupID,
	f.FirstPLDate,
	f.FQ_75
	) pl
on pl.PigGroupID=RTrim(Substring(pgr.TaskID,3,10))
Left Join  dbo.cfv_Site s On pgr.SiteContactID = s.SiteContactID
Where Month(pgr.ActCloseDate) = @Month And Year(pgr.ActCloseDate) = @Year
	And IsNull(pl.FQ_75,0) > 0


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PAYLEAN_MONTHLY_CLOSED_GROUP] TO [db_sp_exec]
    AS [dbo];

