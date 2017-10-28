-- ========================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2007
-- Description:	Selects matching records by movement date
-- ========================================================
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-21  Doran Dahle Removed Alterate Market loads from the results
						Removed Split as the Source ID for Split Loads

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_SELECT_BY_DATE]
(
	@MovementStartDate					SmallDateTime,
	@MovementEndDate					SmallDateTime
)
AS
BEGIN
    SET NOCOUNT ON;
	create table #LoadData
	(		MovementDate					datetime
	,		PMLoadID						char(10)
	,		ID								int
	,		SourceContact					char(50)
	,		EstimatedQty					smallint
	,		EstimatedWgt					char(7)
	,		ActualQty						smallint
	,		ActualWgt						smallint
	,		LoadType						char(30)
	,		OutByDay						int)


	INSERT INTO #LoadData
	SELECT 
		pm.movementdate
		,pm.PMLoadID
		,pm.ID
		,Src.ContactName SourceContact
		,pm.EstimatedQty
		,pm.EstimatedWgt
      	,pm.ActualQty
		,pm.ActualWgt
		,cftMarketSaleType.Description LoadType
		,CASE WHEN CAST(dateadd(day,-4,[$(SolomonApp)].dbo.getNextLoadArrivingDate(cast(pm.SourceContactID as int), pm.SourceBarnNbr, @MovementStartDate, @MovementEndDate)) AS SmallDateTime) <= @MovementStartDate
                  THEN 2
            WHEN [$(SolomonApp)].dbo.getNextLoadArrivingDate(cast(pm.SourceContactID as int), pm.SourceBarnNbr, @MovementStartDate, @MovementEndDate) IS NULL
                  THEN 7
            ELSE datepart(dw,dateadd(day,-4,[$(SolomonApp)].dbo.getNextLoadArrivingDate(cast(pm.SourceContactID as int), pm.SourceBarnNbr, @MovementStartDate, @MovementEndDate))) 
		END AS OutByDay
	FROM 
		[$(SolomonApp)].dbo.cftPM PM (NOLOCK)
		inner join [$(SolomonApp)].dbo.cftContact Src (NOLOCK) on Src.ContactID = pm.SourceContactID
		left outer join [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) on cftMarketSaleType.MarketSaleTypeID = pm.MarketSaleTypeID
	where
      ((MovementDate between @MovementStartDate and @MovementEndDate)
      and
      (pm.MarketSaleTypeID in (10,20,25,30)))
--      and
--      ((pm.EstimatedQty > 0 and pm.EstimatedWgt > 0)
--      or (pm.ActualQty > 0 and pm.ActualWgt > 0))

      and
      (pm.Highlight <> 255 and pm.Highlight <> -65536)
      and pm.DestContactID <> 816  -- Remove Alternate Market Loads DGD  8/03/2011

	--CALCULATE EstimatedWgtAvg FOR SPLIT LOADS
	SELECT 
		ID, 
		PMLoadID, 
		EstimatedWgt, 
		EstimatedQty, 
		cast(cast(EstimatedWgt as numeric(10,2)) * EstimatedQty as numeric(10,2)) as EstimatedWgtAvg
	INTO #LoadDataEstimatedWgts
	FROM #LoadData
	WHERE EstimatedWgt > 0

	SELECT PMLoadID, SUM(EstimatedWgtAvg) 'EstimatedWgtAvgLoad'
	INTO #LoadDataEstimatedWgtAvg
	FROM #LoadDataEstimatedWgts
	GROUP BY PMLoadID

	SELECT loads.PMLoadID, loads.EstimatedQty 'EstimatedQty'
	INTO #LoadEstimatedWgt
	FROM (select PMLoadID, SUM(EstimatedQty) EstimatedQty from #LoadData where EstimatedWgt > 0 group by pmloadid) loads


	--CALCULATE ActualWgtAvg FOR SPLIT LOADS
	SELECT 
		ID, 
		PMLoadID, 
		ActualWgt,
		ActualQty,
		cast(cast(ActualWgt as numeric(10,2)) * ActualQty as numeric(10,2)) as ActualWgtAvg
	INTO #LoadDataActualWgts
	FROM #LoadData
	WHERE ActualWgt > 0

	SELECT PMLoadID, SUM(ActualWgtAvg) 'ActualWgtAvgLoad'
	INTO #LoadDataActualWgtAvg
	FROM #LoadDataActualWgts
	GROUP BY PMLoadID

	SELECT loads.PMLoadID, loads.ActualQty 'ActualQty'
	INTO #LoadActualWgt
	FROM (select PMLoadID, SUM(ActualQty) ActualQty from #LoadData where ActualWgt > 0 group by pmloadid) loads



	select      'Regular' 'Load'
	,     MovementDate
	,     LoadData.PMLoadID
	,     SourceContact
	,     EstimatedQty
	,     EstimatedWgt
	,	  LoadData.ActualQty
	,	  LoadData.ActualWgt
	,     LoadType
	,     OutByDay
	from #LoadData LoadData
	inner join (select PMLoadID from #LoadData group by PMLoadID having count(PMLoadID) = 1) Singles
		  on Singles.PMLoadID = LoadData.PMLoadID

	union all
	select      'Split' 'Load'
	,     MovementDate
	,     LoadData.PMLoadID
	--,     'Split' 'SourceContact'	
	,	  SourceContact
	,     SUM(LoadData.EstimatedQty) 'EstimatedQty'
	,	  CAST(AVG(LoadDataEstimatedWgtAvg.EstimatedWgtAvgLoad) / AVG(LoadEstimatedWgt.EstimatedQty) AS INT)
	,	  SUM(LoadData.ActualQty) 'ActualQty'
	,	  CAST(AVG(LoadDataActualWgtAvg.ActualWgtAvgLoad) / AVG(LoadActualWgt.ActualQty) AS INT)
	,     'Split' 'LoadType'
	,     MIN(OutByDay) 'OutByDay'
	from #LoadData LoadData
	left outer join (select PMLoadID, count(PMLoadID) LoadCount from #LoadData where ActualWgt > 0 group by PMLoadID) SplitsAct
		  on SplitsAct.PMLoadID = LoadData.PMLoadID
	left outer join #LoadDataEstimatedWgtAvg LoadDataEstimatedWgtAvg
		on LoadDataEstimatedWgtAvg.PMLoadID = LoadData.PMLoadID
	left outer join #LoadEstimatedWgt LoadEstimatedWgt
		on LoadEstimatedWgt.PMLoadID = LoadData.PMLoadID

	left outer join #LoadDataActualWgtAvg LoadDataActualWgtAvg
		on LoadDataActualWgtAvg.PMLoadID = LoadData.PMLoadID
	left outer join #LoadActualWgt LoadActualWgt
		on LoadActualWgt.PMLoadID = LoadData.PMLoadID

	group by LoadData.MovementDate, LoadData.PMLoadID, SplitsAct.LoadCount, LoadData.SourceContact
	having count(LoadData.PMLoadID) > 1
	order by MovementDate

	DROP TABLE #LoadData
	DROP TABLE #LoadDataEstimatedWgts
	DROP TABLE #LoadDataEstimatedWgtAvg
	DROP TABLE #LoadEstimatedWgt
	DROP TABLE #LoadDataActualWgts
	DROP TABLE #LoadDataActualWgtAvg
	DROP TABLE #LoadActualWgt

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

