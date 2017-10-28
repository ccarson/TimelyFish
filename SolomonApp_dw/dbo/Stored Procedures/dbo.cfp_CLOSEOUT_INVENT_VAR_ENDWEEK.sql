

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 7/1/2011
-- Description:	Returns Inventory Var by Site for a Single Week
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CLOSEOUT_INVENT_VAR_ENDWEEK]
(
	
	 @EndPICYrWeek		varchar(8000)
   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select 
	rtrim(C.ContactName) as ContactName,
	PGR.Phase,
	PGR.SvcManager,
	PGR.SrSvcManager,
	Sum(PGR.InventoryAdjustment_Qty) as 'InvVar',
	Sum(PGR.TotalHeadProduced) as 'TotalHeadProduced',
	Case when Sum(PGR.InventoryAdjustment_Qty)*1.00/Sum(PGR.TotalHeadProduced)*1.00 >= 0.002 then 1
	when Sum(PGR.InventoryAdjustment_Qty)*1.00/Sum(PGR.TotalHeadProduced)*1.00 <= -0.002 then 1
	else 0 end as 'Compliance',
	rtrim(DW.PICYear_Week) as PICYear_Week

	From  dbo.cft_PIG_GROUP_ROLLUP PGR

	left join [$(SolomonApp)].dbo.cftContact C
	on PGR.SiteContactID = C.ContactID 

	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DW
	on PGR.ActCloseDate = DW.DayDate

	Where DW.PICYear_Week = @EndPICYrWeek
	and PGR.Phase in ('NUR','WTF','FIN')

	Group by
	C.ContactName,
	PGR.Phase,
	PGR.SvcManager,
	PGR.SrSvcManager,
	DW.PICYear_Week

	Order by
	C.ContactName,
	DW.PICYear_Week
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CLOSEOUT_INVENT_VAR_ENDWEEK] TO [db_sp_exec]
    AS [dbo];

