




CREATE PROC [dbo].[cfp_Build_SowCube_PigFlow]
	AS	

	SET NOCOUNT ON

Begin Transaction
INSERT INTO dbo.EssbaseUploadPigFlowTemp (FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, pigflow)
  SELECT f.[farm_name], dw.weekofdate, null as 'SowGenetics', null as 'SowParity', dw.picweek, dw.picyear, dw.fiscalperiod, dw.fiscalyear, pf.PigFlowDescription
  FROM [careglobal].[FARMS] f (nolock)
  inner join [$(SolomonApp_dw)].[dbo].[cft_RPT_PIG_GROUP_DW] dw (nolock)
	on dw.sitecontactid = '00'+f.farm_number
  left join [$(CFApp_PigManagement)].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pf.pigflowid = dw.pigflowid
  JOIN WeekDefinitionTemp wd ON dw.WeekOfDate = wd.WeekOfDate
Commit

	
	-- TURN BACK ON SQL's returning of affected row count
	SET NOCOUNT OFF





