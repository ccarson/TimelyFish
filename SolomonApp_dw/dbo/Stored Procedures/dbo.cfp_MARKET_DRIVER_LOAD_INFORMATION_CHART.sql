

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/18/2011
-- Description:	Returns Market Driver Load Info
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION_CHART]
(
	
	 @Trucker			varchar(8000)
	,@EndPICYrWeek		varchar(8000)
	,@StartPICYrWeek	varchar(8000)

   
)
AS

BEGIN

	Create Table #Trucker (Value varchar(100))
	Insert into #Trucker Select * From  dbo.cffn_SPLIT_STRING(@Trucker,',')
	
	Select Identity(int, 1,1) as RowNumber, t.Trucker1 INTO #RowNumber
	From (Select Distinct Replace(RN.TruckerName,',','') as Trucker1 from  dbo.cft_MARKET_LOAD RN
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
	on RN.MovementDate = DD.DayDate
	join #Trucker TR
	on Replace(RN.TruckerName,',','') like TR.Value
	Where DD.PICYear_Week >= @StartPICYrWeek and DD.PICYear_Week <= @EndPICYrWeek group by Replace(RN.TruckerName,',','')) t
	
	Select
	
	a.Trucker,
	a.PICYear_Week,
	a.HeadCount,
	a.DOA,
	a.CFHC,
	a.CFDOA,
	RN.RowNumber
	
	from (Select
	
	Rtrim(MDLI.Trucker1) Trucker1, 
	Rtrim(MDLI.Trucker) Trucker,
	MDLI.PICYear_Week,
	Sum(MDLI.Qty) HeadCount,
	Sum(DOA.Qty) DOA,
	CFHC.Qty as CFHC,
	CFDOA.Qty as CFDOA
	
	From (Select Replace(MD.TruckerName,',','') as Trucker1, MD.TruckerName as Trucker, MD.OriginSiteName as Site, MD.PMLoadID, DD.PICYear_Week, Sum(MD.PigQuantity) as Qty 
	From  dbo.cft_MARKET_LOAD MD
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
	on MD.MovementDate = DD.DayDate 
	Where DD.PICYear_Week >= @StartPICYrWeek and DD.PICYear_Week <= @EndPICYrWeek  
	Group by MD.TruckerName, MD.OriginSiteName, MD.PMLoadID, DD.PICYear_Week) MDLI
	
	join #Trucker TR
	on MDLI.Trucker1 like TR.Value
	
	left join (Select MD.TruckerName as Trucker, MD.OriginSiteName as Site, MD.PMLoadID, DD.PICYear_Week, Sum(MD.DOA+MD.DIY) as Qty 
	From  dbo.cft_MARKET_LOAD MD
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
	on MD.MovementDate = DD.DayDate 
	Where DD.PICYear_Week >= @StartPICYrWeek and DD.PICYear_Week <= @EndPICYrWeek
	Group by MD.TruckerName, MD.OriginSiteName, MD.PMLoadID, DD.PICYear_Week) DOA
	on MDLI.Trucker = DOA.Trucker
	and MDLI.Site = DOA.Site
	and MDLI.PMLoadID = DOA.PMLoadID
	and MDLI.PICYear_Week = DOA.PICYear_Week
	
	left join (Select Sum(MD.PigQuantity) as Qty, DD.PICYear_Week 
	From  dbo.cft_MARKET_LOAD MD
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
	on MD.MovementDate = DD.DayDate 
	Where DD.PICYear_Week >= @StartPICYrWeek and DD.PICYear_Week <= @EndPICYrWeek  Group by DD.PICYear_Week) CFHC
	on MDLI.PICYear_Week = CFHC.PICYear_Week
	
	left join (Select Sum(MD.DOA+MD.DIY) as Qty, DD.PICYear_Week 
	From  dbo.cft_MARKET_LOAD MD
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
	on MD.MovementDate = DD.DayDate 
	Where DD.PICYear_Week >= @StartPICYrWeek and DD.PICYear_Week <= @EndPICYrWeek 
	Group by DD.PICYear_Week) CFDOA
	on MDLI.PICYear_Week = CFDOA.PICYear_Week
	
	Where MDLI.PICYear_Week >= @StartPICYrWeek and MDLI.PICYear_Week <= @EndPICYrWeek 
	
	Group by
	MDLI.Trucker1,
	MDLI.Trucker,
	MDLI.PICYear_Week,
	CFHC.Qty,
	CFDOA.Qty) a
	
	join #RowNumber RN
	on a.Trucker1 = RN.Trucker1
	
	Order by
	a.Trucker
	
END

drop table #Trucker

drop table #RowNumber


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION_CHART] TO [db_sp_exec]
    AS [dbo];

