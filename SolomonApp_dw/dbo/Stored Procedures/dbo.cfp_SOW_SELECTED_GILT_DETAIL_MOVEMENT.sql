
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 09/29/2010
-- Description:	Returns all Start Periods
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SELECTED_GILT_DETAIL_MOVEMENT]
(
	 @StartPeriod	int
	,@EndPeriod		int
	   
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select
	
	Rtrim(GFlow.Source) as Source,
	Rtrim(GFlow.Phase) as Phase,
	Rtrim(GFlow.SiteId) as SiteID,
	Rtrim(GFlow.ContactName) as ContactName,
	Rtrim(GFlow.FlowName) as FlowName,
	Rtrim(Movement.DContactName) as DContactName,
	Sum(Movement.Movement) as Movement,
	Avg(Movement.AvgWgt) as AvgWgt
	
	from 
	(Select
	Case when Flow.Siteid = 0001 then 8050 
	when Flow.Siteid = 0002 then 8050 else Flow.Siteid end Siteid,
	Flow.ContactName,
	Flow.Source,
	Flow.Phase,
	Flow.FlowName,
	Flow.StartPeriod,
	Case when Flow.EPRecord is null then 
	(Select Case when WD.FiscalPeriod < 10 
	then Rtrim(CAST(WD.FiscalYear AS char)) + '0' + Rtrim(CAST(WD.FiscalPeriod AS char)) 
	else Rtrim(CAST(WD.FiscalYear AS char)) + Rtrim(CAST(WD.FiscalPeriod AS char)) end 
	from [$(SolomonApp)].dbo.cftDayDefinition DD 
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate 
	Where rtrim(DD.DayDate) = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) else
	EP.EndPeriod end as EndPeriod

	From (Select 
	Min(GF.EPRecord) EPRecord,
	GF.SiteID,
	GF.ContactName,
	GF.Source,
	GF.Phase,
	GF.FlowName,
	GF.StartPeriod

	From (Select
	SP.SPRecord,
	EP.EPRecord,
	Case when EP.EPRecord is NULL then 0 else EP.EPRecord - SP.SPRecord end as RecVar,
	SP.SiteID,
	SP.ContactName,
	SP.Source,
	SP.Phase,
	SP.FlowName,
	SP.StartPeriod
	
	From (Select 
	SGF.Record as SPRecord, 
	SGF.SiteID, 
	Case when SGF.SiteID = 0001 then 'M001Lr'
	when SGF.SiteID = 0002 then 'M001' else C.ContactName end as ContactName,
	SGF.Source, 
	SGF.Phase, 
	SGF.FlowName, 
	Case when SGF.FiscalPeriod < 10 
	then Rtrim(CAST(SGF.FiscalYear AS char)) + '0' + Rtrim(CAST(SGF.FiscalPeriod AS char)) 
	else Rtrim(CAST(SGF.FiscalYear AS char)) + Rtrim(CAST(SGF.FiscalPeriod AS char)) end as StartPeriod 
	
	from  dbo.cft_SOW_SELECTED_GILT_FLOW SGF
	
	left join [$(SolomonApp)].dbo.cftSite S
	on SGF.SiteID = S.SiteID

	left join [$(SolomonApp)].dbo.cftContact C
	on S.ContactID = C.ContactID 
	
	Where SGF.MovementType = 'Entry') SP
	
	left join 
	
	(Select 
	Record as EPRecord, 
	SiteID, 
	Source, 
	Phase, 
	FlowName, 
	FiscalPeriod,
	FiscalYear 
	
	from  dbo.cft_SOW_SELECTED_GILT_FLOW Where MovementType = 'Exit') EP
	
	on SP.SiteID = EP.SiteID
	and SP.Source = EP.Source
	and SP.Phase = EP.Phase
	and SP.FlowName = EP.FlowName) GF
	
	Where GF.RecVar >= 0
	
	Group by 
	GF.SiteID,
	GF.ContactName,
	GF.Source,
	GF.Phase,
	GF.FlowName,
	GF.StartPeriod) Flow
	
	left join 
	
	(Select 
	Record, 
	SiteID, 
	Source, 
	Phase, 
	FlowName, 
	Case when FiscalPeriod < 10 
	then Rtrim(CAST(FiscalYear AS char)) + '0' + Rtrim(CAST(FiscalPeriod AS char)) 
	else Rtrim(CAST(FiscalYear AS char)) + Rtrim(CAST(FiscalPeriod AS char)) end as EndPeriod 
	
	from  dbo.cft_SOW_SELECTED_GILT_FLOW Where MovementType = 'Exit') EP
	
	on Flow.EPRecord = EP.Record) GFlow
	
	left join   dbo.cft_SOW_SELECTED_GILT_MOVEMENT Movement
	on GFlow.Siteid = Movement.Ssite
	and Movement.GroupPeriod between case when GFlow.StartPeriod <= @StartPeriod then @StartPeriod 
	else GFlow.Startperiod end 
	and case when GFlow.EndPeriod <= @EndPeriod then GFlow.EndPeriod else @EndPeriod end
	
	left join (Select
	Flow.Siteid,
	Flow.ContactName,
	Flow.Source,
	Flow.Phase,
	Flow.FlowName,
	Flow.StartPeriod,
	Case when Flow.EPRecord is null then 
	(Select Case when WD.FiscalPeriod < 10 
	then Rtrim(CAST(WD.FiscalYear AS char)) + '0' + Rtrim(CAST(WD.FiscalPeriod AS char)) 
	else Rtrim(CAST(WD.FiscalYear AS char)) + Rtrim(CAST(WD.FiscalPeriod AS char)) end 
	from [$(SolomonApp)].dbo.cftDayDefinition DD 
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate 
	Where rtrim(DD.DayDate) = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) else
	EP.EndPeriod end as EndPeriod

	From (Select 
	Min(GF.EPRecord) EPRecord,
	GF.SiteID,
	GF.ContactName,
	GF.Source,
	GF.Phase,
	GF.FlowName,
	GF.StartPeriod

	From (Select
	SP.SPRecord,
	EP.EPRecord,
	Case when EP.EPRecord is NULL then 0 else EP.EPRecord - SP.SPRecord end as RecVar,
	SP.SiteID,
	SP.ContactName,
	SP.Source,
	SP.Phase,
	SP.FlowName,
	SP.StartPeriod
	
	From (Select 
	SGF.Record as SPRecord, 
	SGF.SiteID, 
	Case when SGF.SiteID = 0001 then 'M001Lr'
	when SGF.SiteID = 0002 then 'M001' else C.ContactName end as ContactName,
	SGF.Source, 
	SGF.Phase, 
	SGF.FlowName, 
	Case when SGF.FiscalPeriod < 10 
	then Rtrim(CAST(SGF.FiscalYear AS char)) + '0' + Rtrim(CAST(SGF.FiscalPeriod AS char)) 
	else Rtrim(CAST(SGF.FiscalYear AS char)) + Rtrim(CAST(SGF.FiscalPeriod AS char)) end as StartPeriod 
	
	from  dbo.cft_SOW_SELECTED_GILT_FLOW SGF
	
	left join [$(SolomonApp)].dbo.cftSite S
	on SGF.SiteID = S.SiteID

	left join [$(SolomonApp)].dbo.cftContact C
	on S.ContactID = C.ContactID 
	
	Where SGF.MovementType = 'Entry') SP
	
	left join 
	
	(Select 
	Record as EPRecord, 
	SiteID, 
	Source, 
	Phase, 
	FlowName, 
	FiscalPeriod,
	FiscalYear 
	
	from  dbo.cft_SOW_SELECTED_GILT_FLOW Where MovementType = 'Exit') EP
	
	on SP.SiteID = EP.SiteID
	and SP.Source = EP.Source
	and SP.Phase = EP.Phase
	and SP.FlowName = EP.FlowName) GF
	
	Where GF.RecVar >= 0
	
	Group by 
	GF.SiteID,
	GF.ContactName,
	GF.Source,
	GF.Phase,
	GF.FlowName,
	GF.StartPeriod) Flow
	
	left join 
	
	(Select 
	Record, 
	SiteID, 
	Source, 
	Phase, 
	FlowName, 
	Case when FiscalPeriod < 10 
	then Rtrim(CAST(FiscalYear AS char)) + '0' + Rtrim(CAST(FiscalPeriod AS char)) 
	else Rtrim(CAST(FiscalYear AS char)) + Rtrim(CAST(FiscalPeriod AS char)) end as EndPeriod 
	
	from  dbo.cft_SOW_SELECTED_GILT_FLOW Where MovementType = 'Exit') EP
	
	on Flow.EPRecord = EP.Record
	
	Where Flow.SiteID not in (0001,0002)) DGFlow
	on Movement.DSite = DGFlow.SiteID
	and Movement.GroupPeriod between case when DGFlow.StartPeriod <= @StartPeriod then @StartPeriod 
	else DGFlow.Startperiod end 
	and case when DGFlow.EndPeriod <= @EndPeriod then DGFlow.EndPeriod else @EndPeriod end
	
	Where 
	
	((GFlow.FlowName = 'Nursery M1' and GFlow.Phase = 'FP' and DGFlow.FlowName = 'Gilt Development M1' and DGFlow.Phase = 'SG')
	or (GFlow.FlowName = 'Isolation M3/M4' and GFlow.Phase = 'Gilt' and DGFlow.FlowName = 'Sow Farms M3/M4' and DGFlow.Phase = 'WP')
	or (GFlow.FlowName in ('Sow Farms M1','Sow Farms M3/M4') and GFlow.Phase = 'WP' and DGFlow.FlowName in ('PRRS Neg Nursery M3/M4','ILL Flow') and DGFlow.Phase = 'FP')
	or (GFlow.FlowName = 'Sow Farms M1Lr' and GFlow.Phase = 'WPLr' and DGFlow.FlowName = 'Nursery M1' and DGFlow.Phase = 'FP')
	or (GFlow.FlowName in ('PRRS Neg Nursery M3/M4','ILL Flow','ON Complex','SI Flow') and GFlow.Phase = 'FP' and DGFlow.FlowName in ('MN HH Flow','MN PRRS Pos GDU','LDC Complex','ON Complex','SI Flow') and DGFlow.Phase in ('SG'))
	or (GFlow.FlowName = 'Isolation M5/M6' and GFlow.Phase = 'Gilt' and DGFlow.FlowName = 'Sow Farms M5/M6' and DGFlow.Phase = 'WP')
	or (GFlow.FlowName = 'Sow Farms M5/M6' and GFlow.Phase = 'WP' and DGFlow.FlowName in ('ILL Flow','SI Flow') and DGFlow.Phase = 'FP')
	--or (GFlow.FlowName = 'ILL Flow' and GFlow.Phase = 'FP' and DGFlow.FlowName = 'SI Flow' and DGFlow.Phase = 'SG')
	or (GFlow.FlowName = 'Nursery M2' and GFlow.Phase = 'FP' and DGFlow.FlowName in ('Finish M2','Isolation M2') and DGFlow.Phase in ('SB','BoarIso'))
	or (GFlow.FlowName = 'Finish M2' and GFlow.Phase = 'SB' and DGFlow.FlowName = 'Isolation M2' and DGFlow.Phase = 'BoarIso')
	or (GFlow.Phase = 'WP' and Movement.PigGradeCatTypeID not in ('02','03','06') and Movement.PigTypeID = '02' and Left(Movement.SubTypeID, 1) = 'S')
	or (GFlow.Phase = 'SG' and Movement.PigGradeCatTypeID not in ('02','03','06') and Movement.PigTypeID = '06' and Right(Rtrim(Movement.SubTypeID), 1) in ('I','S'))
	or (GFlow.Phase = 'SB' and Movement.PigGradeCatTypeID not in ('02','03') and Movement.PigTypeID = '06' and Right(Rtrim(Movement.SubTypeID), 1) in ('I','S'))
	or (GFlow.Phase <> 'SG' and (Movement.PigTypeId is null or Movement.PigTypeID in ('06','12')) and (Movement.SubTypeId is null or Right(Movement.SubTypeID, 1) in ('B','I'))))
	and ((GFlow.Source <> 'M2' and Movement.PigGradeCatTypeID not in ('02','03','06'))
	or (GFlow.Source = 'M2' and Movement.PigGradeCatTypeID not in ('02','03')))
	and (GFlow.SiteID <> DGFlow.SiteID or GFlow.SiteID <> Movement.DSite)
	
	Group by
	
	GFlow.Source,
	GFlow.Phase,
	GFlow.SiteId,
	GFlow.ContactName,
	GFlow.FlowName,
	Movement.DContactName
	
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SELECTED_GILT_DETAIL_MOVEMENT] TO [db_sp_exec]
    AS [dbo];

