
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_INVENTORY_CALLIN_SELECT]
	@PicDate CHAR(6)
AS

-- Updated 2/2/2016 by BMD - removed SBF pig groups from calculations

DECLARE @PicWeek char(2)
DECLARE @PicYear char(4)
DECLARE @PicStartDate datetime
DECLARE @PicEndDate datetime
SET @PicWeek = RIGHT(@PicDate,2)
SET @PicYear = '20' + LEFT(@PicDate,2)

select @PicStartDate = WeekOfDate, @PicEndDate = WeekEndDate 
from [$(SolomonApp)].dbo.cftWeekDefinition where PicWeek = @PicWeek and PicYear = @PicYear

DECLARE @TranDate datetime
DECLARE @CallDate datetime
SET @TranDate = @PicEndDate
SET @CallDate = DATEADD(d,2,@TranDate)


--local variables, jmaas
declare @HaveCalled money
declare @ShouldHaveCalled money

--have called in
set @HaveCalled = (select sum(x.CurrInventory) CurrInventory from (select 'PG'+rtrim(sd.PigGroupID) PigGroupID,
    count(sd.PigGroupID) NbrOfCalls,
    min(sd.CurrInv) CurrInventory
from [$(SolomonApp)].dbo.cftSafeMort sd
Inner join [$(SolomonApp)].dbo.cftPigGroup pg on pg.PigGroupID=sd.PigGroupID
/*This is where we input the Transaction Date*/
where convert(datetime,sd.TranDate,101)='02/06/2016'--@TranDate
  and convert(datetime,sd.CallDate,101)<='02/08/2016'--@CallDate  --Called in by Monday night
  /*This is where we input the Transaction Date*/
  and pg.PigSystemID='00'
  and pg.PigProdPhaseID in ('NUR','FIN','WTF','TEF')
  and pg.PigProdPodID != 53 -- Ignore SBF pig groups
group by 'PG'+rtrim(sd.PigGroupID)) x)



--should have called in, jmaas
set @ShouldHaveCalled = (select x.Inventory from (select
Sum(t.Qty) Inventory
from
(select
DATEADD(DD,-DATEPART(DW,GETDATE()),GETDATE()) InvDate,
rtrim(IT.acct) Account,
IT.TranDate,
'PG'+rtrim(IT.PigGroupID) 'GroupNumber',
'PG'+rtrim(IT.PigGroupID)+'-'+rtrim(PG.Description) GroupAlias,
IT.Qty*IT.InvEffect Qty
from [$(SolomonApp)].dbo.cftPGInvTran IT
inner join [$(SolomonApp)].dbo.cftPigGroup PG on IT.PigGroupID=PG.PigGroupID
where PG.PGStatusID='A'
  and PG.PigSystemID='00'
  and PG.PigProdPhaseID in ('NUR','FIN','WTF','TEF')
  and pg.PigProdPodID != 53 -- Ignore SBF pig groups
  and IT.Reversal = '0'
  and IT.Qty <> '0'
  /*THIS chooses the last Saturday from the current date*/
  and IT.TranDate <=DATEADD(DD,-DATEPART(DW,GETDATE()),GETDATE())
) t) x)

select cast((@HaveCalled / @ShouldHaveCalled) as money) * 100 PctCalled



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_INVENTORY_CALLIN_SELECT] TO [db_sp_exec]
    AS [dbo];

