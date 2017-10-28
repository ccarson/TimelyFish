
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 10/11/2010
-- Description:	Returns alL Sites in Selected Gilt System
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SELECTED_GILT_SITE]
(
	@StartPeriod		int
	,@EndPeriod			int
	,@Source			varchar(8)
	,@FlowName			varchar(20)
	,@Phase				varchar(8)
	   
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TempSource varchar(8)

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
	
	DECLARE @TempPhase varchar(8)

	IF @Phase = '%' 

	BEGIN
		SET @TempPhase = '%'
	END
	
	ELSE
	BEGIN
		SET @TempPhase = @Phase
	END

	SELECT	-1 as SiteID, '--All--' as Contactname
	UNION ALL
	SELECT	DISTINCT

	Rtrim(GF.SiteID) as Site, 
	Rtrim(GF.Contactname) as ContactName

	from (Select 
	GF.SiteID,
	Case when GF.SiteID = 1 then 'M001Lr'
	when GF.SiteID = 2 then 'M001' else C.ContactName end as ContactName,
	GF.Source,
	GF.Phase,
	GF.FlowName,
	Case when SP.FiscalPeriod < 10 
	then Rtrim(CAST(SP.FiscalYear AS char)) + '0' + Rtrim(CAST(SP.FiscalPeriod AS char)) 
	else Rtrim(CAST(SP.FiscalYear AS char)) + Rtrim(CAST(SP.FiscalPeriod AS char)) end as StartPeriod,

	Case when (Case when EP.FiscalPeriod < 10 
	then Rtrim(CAST(EP.FiscalYear AS char)) + '0' + Rtrim(CAST(EP.FiscalPeriod AS char)) 
	else Rtrim(CAST(EP.FiscalYear AS char)) + Rtrim(CAST(EP.FiscalPeriod AS char)) end) is null then 

	(Select Case when WD.FiscalPeriod < 10 
	then Rtrim(CAST(WD.FiscalYear AS char)) + '0' + Rtrim(CAST(WD.FiscalPeriod AS char)) 
	else Rtrim(CAST(WD.FiscalYear AS char)) + Rtrim(CAST(WD.FiscalPeriod AS char)) end 
	from [$(SolomonApp)].dbo.cftDayDefinition DD 
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate 
	Where rtrim(DD.DayDate) = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) else

	Case when EP.FiscalPeriod < 10 
	then Rtrim(CAST(EP.FiscalYear AS char)) + '0' + Rtrim(CAST(EP.FiscalPeriod AS char)) 
	else Rtrim(CAST(EP.FiscalYear AS char)) + Rtrim(CAST(EP.FiscalPeriod AS char)) end end as EndPeriod

	from (Select Distinct SiteID, Source, Phase, FlowName from  dbo.cft_SOW_SELECTED_GILT_FLOW) GF

	left join [$(SolomonApp)].dbo.cftSite S
	on GF.SiteID = S.SiteID

	left join [$(SolomonApp)].dbo.cftContact C
	on S.ContactID = C.ContactID 

	left join (Select SiteID, Source, Phase, FlowName, FiscalYear, FiscalPeriod, Max(Record) as Record 
	from  dbo.cft_SOW_SELECTED_GILT_FLOW Where MovementType = 'Entry'
	Group by SiteID, Source, Phase, FlowName, FiscalYear, FiscalPeriod) SP
	on GF.SiteID = SP.SiteID
	and GF.Source = SP.Source
	and GF.Phase = SP.Phase
	and GF.FlowName = SP.FlowName

	left join (Select SiteID, Source, Phase, FlowName, FiscalYear, FiscalPeriod, Max(Record) as Record 
	from  dbo.cft_SOW_SELECTED_GILT_FLOW Where MovementType = 'Exit'
	Group by SiteID, Source, Phase, FlowName, FiscalYear, FiscalPeriod) EP
	on GF.SiteID = EP.SiteID
	and GF.Source = EP.Source
	and GF.Phase = EP.Phase
	and GF.FlowName = EP.FlowName) GF

	Where
	GF.StartPeriod <= @EndPeriod 
	and GF.EndPeriod >= @StartPeriod 
	and GF.Source like @TempSource
	and GF.FlowName like @TempFlowName
	and GF.Phase like @TempPhase
	
	Order by
	GF.ContactName
			
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SELECTED_GILT_SITE] TO [db_sp_exec]
    AS [dbo];

