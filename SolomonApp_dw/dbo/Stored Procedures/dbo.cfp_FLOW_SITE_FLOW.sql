


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 02/23/2012
-- Description:	Site Flow Results
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FLOW_SITE_FLOW]
(
	
	 @StartPeriod		char(6),
	 @EndPeriod			char(6),
	 @Phase				char(4)
   
)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select Distinct
	pf.PigFlowDescription
	
	from  dbo.cft_PIG_GROUP_ROLLUP pgr
	left join [$(SolomonApp)].dbo.cftContact c
	on pgr.SiteContactID = c.ContactID
	left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
	on pgr.PigFlowID = pf.PigFlowID
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
	on pgr.ActCloseDate = dd.DayDate
	
	Where Case when dd.FiscalPeriod < 10 
	then Rtrim(CAST(dd.FiscalYear AS char)) + '0' + Rtrim(CAST(dd.FiscalPeriod AS char)) 
	else Rtrim(CAST(dd.FiscalYear AS char)) + Rtrim(CAST(dd.FiscalPeriod AS char)) end between @StartPeriod and @EndPeriod
	and pgr.Phase = @Phase
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FLOW_SITE_FLOW] TO [db_sp_exec]
    AS [dbo];

