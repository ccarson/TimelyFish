

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 3/17/2011
-- Description:	Returns Marketing Strategy Default Percent
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKETING_SITE_PLAN_STRATEGY_PERCENT]
(
	
	 @SiteName Char(50) 
   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
SET NOCOUNT ON;
 
Declare @SiteContactID Char(6)

Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)

Select 
Case When feed.NonTriumphFeed > 0 Then 10 Else 20 End As FirstTopPercent
, Case When feed.NonTriumphFeed > 0 Then 20 Else 0 End As SecondTopPercent
, 0 As ThirdTopPercent
, Case When feed.NonTriumphFeed > 0 Then 20 Else 50 End As HeavyCloseoutPercent
, Case When feed.NonTriumphFeed > 0 Then 50 Else 30 End As LightCloseoutPercent

From [$(SolomonApp)].dbo.cftPigGroup pg
	Inner Join (  --Find the Earliest and Latest Arrival Dates for each Pig Group
				Select fd.DestPigGroupID, Min(fd.ArrivalDate) As FillStartDate, Max(fd.ArrivalDate) As FillEndDate
				From [$(SolomonApp)].dbo.cftPigGroup pg
					Inner Join [$(SolomonApp)].dbo.cftPM fd On fd.DestPigGroupID = pg.PigGroupID
				Group By fd.DestPigGroupID
				) fd On fd.DestPigGroupID = pg.PigGroupID
	Inner Join (  --Find the Feed Delivered for each Pig Group
				Select feed.PigGroupID
				, Sum(feed.QtyDel) As TotalFeedDelivered
				, Sum(Case When feed.InvtIdDel In('053M-NT','054M-NT','055M-NT') Then feed.QtyDel Else 0 End) As NonTriumphFeed
				From [$(SolomonApp)].dbo.cftPigGroup pg
					Inner Join [$(SolomonApp)].dbo.cftFeedOrder feed On feed.PigGroupID = pg.PigGroupID
				Where feed.Reversal = '0'
				Group By feed.PigGroupID
				) feed On feed.PigGroupID = pg.PigGroupID
	Inner Join (  --Headcount
				Select pg.PigGroupID, SUM(hc.Qty * hc.InvEffect) AS Headcount
				From [$(SolomonApp)].dbo.cftPigGroup As pg WITH (NOLOCK)
					Inner Join [$(SolomonApp)].dbo.cftPGInvTran As hc WITH (NOLOCK) On pg.PigGroupID = hc.PigGroupID
				Where (hc.Reversal <> 1) and pg.PGStatusID<>'I'
				Group By pg.PigGroupID
				) hc On hc.PigGroupID = pg.PigGroupID
	Left Join (  --Nursery Days
				Select p.PigGroupID, Sum(p.PigQuantity*p.NurseryDays)/Sum(p.PigQuantity) As NurseryDays
				From [$(SolomonApp)].dbo.cftPigGroup pg
					Inner Join (
						Select i.PigGroupID,i.SourcePigGroupID, i.PigQuantity, pgr.LivePigDays/pgr.TotalHeadProduced As NurseryDays
						From  dbo.cft_PIG_GROUP_ROLLUP pgr
							Inner Join (
								Select i.PigGroupID, i.SourcePigGroupID, Sum(i.Qty) As PigQuantity
								From [$(SolomonApp)].dbo.cftPGInvTran i
									Inner Join [$(SolomonApp)].dbo.cftPigGroup pg On pg.PigGroupID = i.PigGroupID
								Where i.SourcePigGroupID != ' ' And i.Reversal = 0 
									And pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
													From [$(SolomonApp)].dbo.cftPigGroup 
													Where SiteContactID = @SiteContactID 
													Order By ActStartDate Desc)
								Group By i.PigGroupID, i.SourcePigGroupID
								) i On RTrim(i.SourcePigGroupID) = RTrim(Substring(pgr.TaskID,3,10))
						Where pgr.Phase = 'NUR'
						) p On p.PigGroupID = pg.PigGroupID
				Group By p.PigGroupID
				) n On n.PigGroupID = pg.PigGroupID

Where pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
				From [$(SolomonApp)].dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc)

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKETING_SITE_PLAN_STRATEGY_PERCENT] TO [db_sp_exec]
    AS [dbo];

