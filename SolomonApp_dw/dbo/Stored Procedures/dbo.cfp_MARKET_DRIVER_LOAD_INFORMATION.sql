

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/18/2011
-- Description:	Returns Market Driver Load Info
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION]
(
	
	 @Trucker			varchar(8000)
	,@EndPICYrWeek		varchar(8000)
	,@StartPICYrWeek	varchar(8000)

   
)
AS

BEGIN

	Create Table #Trucker (Value varchar(100))
	Insert into #Trucker Select * From  dbo.cffn_SPLIT_STRING(@Trucker,',')

	Select
	 
	TC.ContactName as Trucker,
	SC.ContactName as Site,
	PM.PMLoadID,
	WeekInfo.PICYear_Week,
	Case when Sum(PS.Qty) is null then 0 else Sum(PS.Qty) end as HeadCount,
	Case when Sum(DOA.Qty) is null then 0 else Sum(DOA.Qty) end as DOA,
	SDOA.HC as SiteHC,
	SDOA.Qty as SiteDOA,
	CFDOA.HC as CFHC,
	CFDOA.Qty as CFDOA
	
	From [$(SolomonApp)].dbo.cftPM PM
	
	left join [$(SolomonApp)].dbo.cfvPIGSALEREV PSR
	on PM.PMLoadID = PSR.PMLoadID
	
	left join [$(SolomonApp)].dbo.cftContact SC
	on PM.SourceContactID = SC.ContactID
	
	left join 
	(Select BatNbr, RefNbr, Sum(Qty) as Qty
	From [$(SolomonApp)].dbo.cftPSDetail Group by BatNbr, RefNbr) PS
	on PSR.BatNbr = PS.BatNbr
	and PSR.RefNbr = PS.RefNbr
	
	left join 
	(Select BatNbr, RefNbr, Sum(Qty) as Qty
	From [$(SolomonApp)].dbo.cftPSDetail Where DetailTypeID in ('DT','DY') Group by BatNbr, RefNbr) DOA
	on PSR.BatNbr = DOA.BatNbr
	and PSR.RefNbr = DOA.RefNbr
	
	left join [$(SolomonApp)].dbo.cftContact TC
	on PM.TruckerContactID = TC.ContactID
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo
	on PM.MovementDate = WeekInfo.DayDate
	
	left join
	(Select 
	SC.ContactName as Site,
	WeekInfo.PICYear_Week,
	Case when Sum(PS.Qty) is null then 0 else Sum(PS.Qty) end as HC,
	Case when Sum(DOA.Qty) is null then 0 else Sum(DOA.Qty) end as Qty
	
	From [$(SolomonApp)].dbo.cftPM PM
	
	left join [$(SolomonApp)].dbo.cfvPIGSALEREV PSR
	on PM.PMLoadID = PSR.PMLoadID
	
	left join [$(SolomonApp)].dbo.cftContact SC
	on PM.SourceContactID = SC.ContactID
	
	left join 
	(Select BatNbr, RefNbr, Sum(Qty) as Qty
	From [$(SolomonApp)].dbo.cftPSDetail Group by BatNbr, RefNbr) PS
	on PSR.BatNbr = PS.BatNbr
	and PSR.RefNbr = PS.RefNbr
	
	left join 
	(Select BatNbr, RefNbr, Sum(Qty) as Qty
	From [$(SolomonApp)].dbo.cftPSDetail Where DetailTypeID in ('DT','DY') Group by BatNbr, RefNbr) DOA
	on PSR.BatNbr = DOA.BatNbr
	and PSR.RefNbr = DOA.RefNbr
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo
	on PM.MovementDate = WeekInfo.DayDate
	
	Where PM.TranSubTypeID in ('FM','WM')
	
	Group by
	SC.ContactName,
	WeekInfo.PICYear_Week) SDOA
	on SDOA.Site = SC.ContactName
	and SDOA.PICYear_Week = WeekInfo.PICYear_Week
	
	left join
	(Select 
	WeekInfo.PICYear_Week,
	Case when Sum(PS.Qty) is null then 0 else Sum(PS.Qty) end as HC,
	Case when Sum(DOA.Qty) is null then 0 else Sum(DOA.Qty) end as Qty
	
	From [$(SolomonApp)].dbo.cftPM PM
	
	left join [$(SolomonApp)].dbo.cfvPIGSALEREV PSR
	on PM.PMLoadID = PSR.PMLoadID
	
	left join 
	(Select BatNbr, RefNbr, Sum(Qty) as Qty
	From [$(SolomonApp)].dbo.cftPSDetail Group by BatNbr, RefNbr) PS
	on PSR.BatNbr = PS.BatNbr
	and PSR.RefNbr = PS.RefNbr
	
	left join 
	(Select BatNbr, RefNbr, Sum(Qty) as Qty
	From [$(SolomonApp)].dbo.cftPSDetail Where DetailTypeID in ('DT','DY') Group by BatNbr, RefNbr) DOA
	on PSR.BatNbr = DOA.BatNbr
	and PSR.RefNbr = DOA.RefNbr
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo
	on PM.MovementDate = WeekInfo.DayDate
	
	Where PM.TranSubTypeID in ('FM','WM')
	
	Group by
	WeekInfo.PICYear_Week) CFDOA
	on CFDOA.PICYear_Week = WeekInfo.PICYear_Week
	
	Where PM.TranSubTypeID in ('FM','WM')
	and TC.ContactName is not null
	and WeekInfo.PICYear_Week between @StartPICYrWeek and @EndPICYrWeek
	
	Group by
	TC.ContactName,
	SC.ContactName,
	PM.PMLoadId,
	SDOA.HC,
	SDOA.Qty,
	CFDOA.HC,
	CFDOA.Qty,
	WeekInfo.PICYear_Week
	
	Order by
	TC.ContactName,
	WeekInfo.PICYear_Week,
	PM.PMLoadID,
	SC.ContactName
	
END

drop table #Trucker


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION] TO [db_sp_exec]
    AS [dbo];

