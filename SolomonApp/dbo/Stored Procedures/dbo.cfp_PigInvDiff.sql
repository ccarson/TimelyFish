




-- =============================================
-- Author:		SRipley, dbo.cfp_amy
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the LP spreadsheet
-- The user needs to provide the sitename and a start and end date for a transdate search.
-- =============================================
create PROCEDURE [dbo].[cfp_PigInvDiff] 
	@piggroupid varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Select smc.ContactName as SM
      ,smc.ContactID as 'SM C ID'
      ,pg.Description as Site
      ,sm.PigGroupID as PGID
      ,convert(char(10),cast(sm.CallDate as date),101) as CallDate
      ,sm.trandate
      ,sm.CurrInv as 'Door Card Inv'
      ,pg.InventoryCount as 'PGA Inv'
      ,pg.InventoryCount - sm.CurrInv as 'Difference'
      --,dw.PICyear_Week
      ,dw.PICWeek -1 as 'Reported Wk'
                          ,case when pg.InventoryCount - sm.CurrInv < -2 then datediff (ww, dw.WeekEndDate, getdate()) +1
                                when pg.InventoryCount - sm.CurrInv > 2 then datediff (ww, dw.WeekEndDate, getdate()) +1
                                else -1 
                           end as WeekDiff
From 
                        (SELECT pg.ProjectID, pg.TaskID, pg.Description, PG.PigGroupID, PG.PGStatusID, PG.UseActualsFlag, PG.PigProdPhaseID, PG.EstCloseDate,
                                TR.PicWeek, TR.PicYear, 
                                                                        TR.WeekOfDate, TR.WeekEndDate, 
                                                                        Sum(TR.Qty * TR.InvEffect) as InventoryCount
       from cftPigGroup pg WITH (NOLOCK)
       left outer join
                                                   (select PIT.*, WD.FiscalPeriod, WD.FiscalYear, WD.PICWeek, WD.PICYear, WD.WeekOfDate, WD.WeekEndDate 
                                                    from cftPGInvTran PIT WITH (NOLOCK) 
                                                    cross join cftWeekDefinition WD WITH (NOLOCK)
                                                    Where PIT.Reversal<>1 and PIT.TranDate < WD.WeekEndDate) TR ON pg.PigGroupID = TR.PigGroupID   --changed this from <= to <, doing this lined up the inventory
      WHERE pg.piggroupid = @piggroupid
                                AND TR.WeekEndDate < GETDATE()+7  
                                                                        AND pg.PGStatusID = 'A' -- active
                                                                        AND pg.UseActualsFlag = '1' -- is checked
                                                                        AND pg.PigProdPhaseID in ('FIN', 'NUR', 'WTF')
      GROUP BY pg.ProjectID, pg.TaskID, TR.PicWeek, TR.PicYear, pg.Description, PG.PigGroupID, PG.PGStatusID, 
                                   PG.UseActualsFlag, PG.PigProdPhaseID, PG.EstCloseDate, 
                                   TR.WeekOfDate, TR.WeekEndDate
                        ) pg -- Get pig groups and their inventory by week

LEFT OUTER JOIN SolomonApp.dbo.cftSafeMort sm (NOLOCK) on pg.PigGroupID = sm.PigGroupID and dateadd(d,1,sm.calldate) between pg.weekofdate and pg.weekenddate -- add one day to the calldate since the PGA reporting week begins on Saturday, not Sunday like the table is designed for the starting day of the week
INNER JOIN SolomonApp.dbo.cftSite s (NOLOCK) on sm.SiteID = s.SiteID
INNER JOIN SolomonApp.dbo.cftContact c (NOLOCK) on s.ContactID = c.ContactID
LEFT JOIN (SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate -- Get the current service manager
             FROM CentralData.dbo.SiteSvcMgrAssignment sma (NOLOCK) 
                                                   GROUP BY SiteContactID) csm ON csm.SiteContactID = s.ContactID
LEFT JOIN CentralData.dbo.SiteSvcMgrAssignment sma (NOLOCK)ON sma.SiteContactID = csm.SiteContactID AND sma.EffectiveDate = csm.EffectiveDate
LEFT JOIN CentralData.dbo.Contact smc (NOLOCK) ON smc.ContactID = sma.SvcMgrContactID
LEFT JOIN Solomonapp.dbo.cfvDayDefinition_WithWeekInfo dw on convert(char(10),cast(dateadd(d,1,sm.CallDate) as date),101) = dw.DayDate 

WHERE pg.PGStatusID = 'A' -- active
  AND pg.UseActualsFlag = '1' -- is checked
  AND pg.PigProdPhaseID in ('FIN', 'NUR', 'WTF')
  AND datediff(day,getdate(),pg.EstCloseDate) >= 4
  AND smc.ContactID not in (85, 67, 3721) -- exclude Harris85, Gifford67, Ebert3721
  AND PG.PigGroupID not in -- Exclude returning PigGroups where the current inventories are not outside the allowed range
        (select cpg1.PigGroupID
                                                   from cftPigGroup cpg1
                                                INNER join (select piggroupid, max(trandate) as max_trandt from SolomonApp.dbo.cftSafeMort group by piggroupid) csm on csm.PigGroupID = cpg1.PigGroupID
                                                INNER join SolomonApp.dbo.cftSafeMort csm2 on cpg1.PigGroupID = csm2.PigGroupID and csm.max_trandt = csm2.TranDate 
                                                INNER JOIN SolomonApp.dbo.cfvCurrentInv ci (NOLOCK) on 'PG' + cpg1.PigGroupID = ci.TaskID
                                                where (csm2.CurrInv - ci.CurrentInv) between -2 and 2 
                                                  and cpg1.PGStatusID = 'A' -- active
          AND cpg1.UseActualsFlag = '1' -- is checked
          AND cpg1.PigProdPhaseID in ('FIN', 'NUR', 'WTF')
                                                )

--) dt
order by 3,10






END











GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PigInvDiff] TO [ASchimmelpfennig]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfp_PigInvDiff] TO [ASchimmelpfennig]
    AS [dbo];

