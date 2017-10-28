

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 10/11/2010
-- Description:	Returns Selected Gilt Cost
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SELECTED_GILT]
(
	
	 @StartPeriod		int
	,@EndPeriod			int
	,@Range				int
	,@Source			varchar(20)
	,@FlowName			varchar(20)
	,@Phase				varchar(20)
	,@SiteID			int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TempSource varchar(20)

	IF @Source = '%' 

	BEGIN
		SET @TempSource = '%'
	END
	
	ELSE
	BEGIN
		SET @TempSource = @Source
	END
	
	DECLARE @TempFlowName varchar(20)

	IF @FlowName = '%' 

	BEGIN
		SET @TempFlowName = '%'
	END
	
	ELSE
	BEGIN
		SET @TempFlowName = @FlowName
	END
	
	DECLARE @TempPhase varchar(20)

	IF @Phase = '%' 

	BEGIN
		SET @TempPhase = '%'
	END
	
	ELSE
	BEGIN
		SET @TempPhase = @Phase
	END

	DECLARE @TempSiteID varchar(20)

	IF @SiteID = -1 

	BEGIN
		SET @TempSiteID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempSiteID = @SiteID
	END

	Declare @GL Table
	(Sub int
	,Perpost Float
	,Id Varchar(50)
	,Acct Float
	,Descr Varchar(50)
	,TranDesc Varchar(50)
	,Amt Float)
	
	Insert Into @GL
	
	Select 
	
	Sub, 
	PerPost,
	Id,
	Acct,
	Descr,
	TranDesc,
	Amt
	
	from  dbo.cft_SOW_SELECTED_GILT_GL
	
	Insert into @GL
	Values(20428050,@EndPeriod,'',50100,'Labor','GeneticLr Labor',
	Case when @Range = 1 then -226426/12
	when @Range = 3 then -226426/4
	when @Range = 6 then -226426/2 else -226426 end)
	
	Insert into @GL
	Values(20420001,@EndPeriod,'',50100,'Labor','GeneticLr Labor',
	Case when @Range = 1 then 226426/12
	when @Range = 3 then 226426/4
	when @Range = 6 then 226426/2 else 226426 end)
	
	Insert into @GL
	Values(20420002,@EndPeriod,'',50100,'Labor','GeneticLr Labor',
	Case when @Range = 1 then -226426/12
	when @Range = 3 then -226426/4
	when @Range = 6 then -226426/2 else -226426 end)

	Declare @Movement Table 
	(Source Varchar(50)
	, Phase Varchar(10)
	, SiteID Float
	, ContactName Varchar(50)
	, FlowName Varchar(50)
	, Movement Float
	, AvgWgt Float)

	Insert Into @Movement

	Select
	
	GFlow.Source,
	GFlow.Phase,
	GFlow.SiteId,
	GFlow.ContactName,
	GFlow.FlowName,
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
	or (GFlow.FlowName in ('PRRS Neg Nursery M3/M4','ILL Flow','ON Complex','SI Flow') and GFlow.Phase = 'FP' and DGFlow.FlowName in ('MN HH Flow','MN PRRS Pos GDU','LDC Complex','ON Complex','SI Flow','ILL Flow') and DGFlow.Phase in ('SG'))
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
	GFlow.FlowName
	
	Declare @GTMovement Table 
	(Source Varchar(50)
	, Phase Varchar(10)
	, SiteID Float
	, ContactName Varchar(50)
	, FlowName Varchar(50)
	, Movement Float
	, AvgWgt Float)

	Insert Into @GTMovement

	Select
	
	GFlow.Source,
	GFlow.Phase,
	GFlow.SiteId,
	GFlow.ContactName,
	GFlow.FlowName,
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
	
	left join   dbo.cft_SOW_SELECTED_GILT_MOVEMENT_70 Movement
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
	else DGFlow.Startperiod end and case when DGFlow.EndPeriod <= @EndPeriod 
	then DGFlow.EndPeriod else @EndPeriod end
	
	Where 
	
	((GFlow.FlowName = 'Nursery M1' and GFlow.Phase = 'FP' and DGFlow.FlowName = 'Gilt Development M1' and DGFlow.Phase = 'SG')
	or (GFlow.FlowName = 'Isolation M3/M4' and GFlow.Phase = 'Gilt' and DGFlow.FlowName = 'Sow Farms M3/M4' and DGFlow.Phase = 'WP')
	or (GFlow.FlowName in ('Sow Farms M1','Sow Farms M3/M4') and GFlow.Phase = 'WP' and DGFlow.FlowName in ('PRRS Neg Nursery M3/M4','ILL Flow') and DGFlow.Phase = 'FP')
	or (GFlow.FlowName = 'Sow Farms M1Lr' and GFlow.Phase = 'WPLr' and DGFlow.FlowName = 'Nursery M1' and DGFlow.Phase = 'FP')
	or (GFlow.FlowName in ('PRRS Neg Nursery M3/M4','ILL Flow','ON Complex','SI Flow') and GFlow.Phase = 'FP' and DGFlow.FlowName in ('MN HH Flow','MN PRRS Pos GDU','LDC Complex','ON Complex','SI Flow','ILL Flow') and DGFlow.Phase in ('SG'))
	or (GFlow.FlowName = 'Isolation M5/M6' and GFlow.Phase = 'Gilt' and DGFlow.FlowName = 'Sow Farms M5/M6' and DGFlow.Phase = 'WP')
	or (GFlow.FlowName = 'Sow Farms M5/M6' and GFlow.Phase = 'WP' and DGFlow.FlowName in ('ILL Flow','SI Flow') and DGFlow.Phase = 'FP')
	--or (GFlow.FlowName = 'ILL Flow' and GFlow.Phase = 'FP' and DGFlow.FlowName = 'SI Flow' and DGFlow.Phase = 'SG')
	or (GFlow.FlowName = 'Nursery M2' and GFlow.Phase = 'FP' and DGFlow.FlowName in ('Finish M2','Isolation M2') and DGFlow.Phase in ('SB','BoarIso'))
	or (GFlow.FlowName = 'Finish M2' and GFlow.Phase = 'SB' and DGFlow.FlowName = 'Isolation M2' and DGFlow.Phase = 'BoarIso')
	or (GFlow.Phase = 'WP' and Movement.PigGradeCatTypeID not in ('02','03','06') and Movement.PigTypeID = '02' and Left(Movement.SubTypeID, 1) = 'S')
	or (GFlow.Phase in ('SG') and Movement.PigTypeID is null and Movement.PigGradeCatTypeID not in ('02','03','06'))
	or (GFlow.Phase in ('SG') and Movement.PigTypeID in ('04','06','08') and Movement.PigGradeCatTypeID not in ('02','03','06') or Movement.PigGradeCatTypeID is null)
	or (GFlow.Phase in ('SB') and Movement.PigTypeID is null and (Movement.PigGradeCatTypeID not in ('02','03') or Movement.PigGradeCatTypeID is null))
	or (GFlow.Phase in ('SB') and Movement.PigTypeID in ('04','06','10','12') and (Movement.PigGradeCatTypeID not in ('02','03') or Movement.PigGradeCatTypeID is null)))
	and ((GFlow.Source <> 'M2' and Movement.PigGradeCatTypeID not in ('02','03','06'))
	or (GFlow.Source = 'M2' and Movement.PigGradeCatTypeID not in ('02','03')))
	and (GFlow.SiteID <> DGFlow.SiteID or GFlow.SiteID <> Movement.DSite or DGFlow.SiteID is null or Movement.DSite is null)
	
	Group by
	
	GFlow.Source,
	GFlow.Phase,
	GFlow.SiteId,
	GFlow.ContactName,
	GFlow.FlowName

	Select 
	
	Rtrim(GFlow.Contactname) as ContactName,
	Rtrim(GFlow.FlowName) as FlowName,
	Rtrim(GFlow.Phase) as Phase,
	Rtrim(GFlow.Source) as Source,
	Case when GFlow.Source in ('M3/M4','M5/M6') then 'Total (M3/M4 & M5/M6)' else '' end as Source2,
	GL.Descr,
	GL.TranDesc,
	Sum(GL.Amt) AS 'Amt',
	GMove.Movement,
	GTGMove.GTGMovement,
	Case when GFlow.Phase in ('SG','SB') then GMove.AvgWgt else '0' end as AvgWgt,
	Case when GFlow.SiteID = 6430 then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source = 'M3/M4')
	when GFlow.SiteID = 5321 then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source = 'M5/M6')
	else Sum(GL.Amt)/GMove.Movement end as 'AmtMove',
	FMove.FMovement,
	GTFMove.GTFMovement,
	Case when GFlow.Phase in ('SG','SB') then FMove.FAvgWgt else '0' end as FAvgWgt,
	Case when GFlow.SiteID = 6430 then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source = 'M3/M4')
	when GFlow.SiteID = 5321 then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source = 'M5/M6')
	else Sum(GL.Amt)/FMove.FMovement end as 'AmtFMove',
	SMove.SMovement,
	GTSMove.GTSMovement,
	Case when GFlow.Phase in ('SB','SG') then SMove.SAvgWgt else '0' end as SAvgWgt,
	Case when GFlow.SiteID = 6430 then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source = 'M3/M4')
	when GFlow.SiteID = 5321 then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source = 'M5/M6')
	else Sum(GL.Amt)/SMove.SMovement end as 'AmtSMove',
	TMove.TMovement,
	GTTMove.GTTMovement,
	Case when GFlow.Phase in ('SB','SG') then TMove.TAvgWgt else '0' end as TAvgWgt,
	Case when GFlow.SiteID in (6430,5321) then Sum(GL.Amt)/
	(Select Sum(Movement)
	From @Movement
	Where Phase = 'WP' and Source in ('M3/M4','M5/M6'))
	else Sum(GL.Amt)/TMove.TMovement end as 'AmtTMove'
		
	from (Select
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
	
	on Flow.EPRecord = EP.Record) GFlow
	
	left join @GL GL
	on right(rtrim(GL.Sub),4) = GFlow.SiteID
	and GL.PerPost between Case when GFlow.StartPeriod <= @StartPeriod then @StartPeriod else GFlow.Startperiod end 
	and Case when GFlow.EndPeriod <= @EndPeriod then GFlow.EndPeriod else @EndPeriod end
	
	left join
	(Select SiteID, ContactName, FlowName, Sum(Movement) as Movement, Avg(AvgWgt) as AvgWgt
	From @Movement
	Group By SiteID, ContactName, FlowName) GMove
	on GFlow.ContactName = GMove.ContactName
	and GFlow.FlowName = GMove.FlowName
	
	left join
	(Select FlowName, Phase, Sum(Movement) as FMovement, Avg(AvgWgt) as FAvgWgt
	From @Movement
	Group By FlowName, Phase) FMove
	on GFlow.FlowName = FMove.FlowName
	and GFlow.Phase = FMove.Phase
	
	left join
	(Select Source, Phase, Sum(Movement) as SMovement, Avg(AvgWgt) as SAvgWgt
	From @Movement
	Group By Source, Phase) SMove
	on GFlow.Source = SMove.Source
	and GFlow.Phase = SMove.Phase
	
	left join
	(Select SRC.Source, MVE.Phase, MVE.TMovement, MVE.TAvgWgt
	From (Select Phase, Sum(Movement) as TMovement, Avg(AvgWgt) as TAvgWgt
	From @Movement Where Source in ('M3/M4','M5/M6')
	Group By Phase) MVE
	cross join 
	(Select Distinct Source
	from  dbo.cfv_SELECTED_GILT_FLOW
	where Source in ('M3/M4','M5/M6')) SRC) TMove
	on GFlow.Source = TMove.Source
	and GFlow.Phase = TMove.Phase
	
	left join
	(Select SiteID, ContactName, FlowName, Sum(Movement) as GTGMovement, Avg(AvgWgt) as AvgWgt
	From @GTMovement
	Group By SiteID, ContactName, FlowName) GTGMove
	on GFlow.ContactName = GTGMove.ContactName
	and GFlow.FlowName = GTGMove.FlowName
	
	left join
	(Select FlowName, Phase, Sum(Movement) as GTFMovement, Avg(AvgWgt) as FAvgWgt
	From @GTMovement
	Group By FlowName, Phase) GTFMove
	on GFlow.FlowName = GTFMove.FlowName
	and GFlow.Phase = GTFMove.Phase
	
	left join
	(Select Source, Phase, Sum(Movement) as GTSMovement, Avg(AvgWgt) as SAvgWgt
	From @GTMovement
	Group By Source, Phase) GTSMove
	on GFlow.Source = GTSMove.Source
	and GFlow.Phase = GTSMove.Phase
	
	left join
	(Select SRC.Source, MVE.Phase, MVE.TMovement as GTTMovement, MVE.TAvgWgt
	From (Select Phase, Sum(Movement) as TMovement, Avg(AvgWgt) as TAvgWgt
	From @GTMovement Where Source in ('M3/M4','M5/M6')
	Group By Phase) MVE
	cross join 
	(Select Distinct Source
	from  dbo.cfv_SELECTED_GILT_FLOW
	where Source in ('M3/M4','M5/M6')) SRC) GTTMove
	on GFlow.Source = GTTMove.Source
	and GFlow.Phase = GTTMove.Phase

	Where
	GFlow.Source like @TempSource
	and GFlow.FlowName like @TempFlowName
	and GFlow.Phase like @TempPhase
	and GFlow.SiteID like @TempSiteID

	Group by
	GFlow.Contactname,
	GFlow.Siteid,
	GFlow.FlowName,
	GFlow.Phase,
	GFlow.Source,
	GL.Descr,
	GL.TranDesc,
	GMove.Movement,
	GTGMove.GTGMovement,
	GMove.AvgWgt,
	FMove.FMovement,
	GTFMove.GTFMovement,
	FMove.FAvgWgt,
	SMove.SMovement,
	GTSMove.GTSMovement,
	SMove.SAvgWgt,
	TMove.TMovement,
	GTTMove.GTTMovement,
	TMove.TAvgWgt
	
	Order by
	GFlow.Contactname
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SELECTED_GILT] TO [db_sp_exec]
    AS [dbo];

