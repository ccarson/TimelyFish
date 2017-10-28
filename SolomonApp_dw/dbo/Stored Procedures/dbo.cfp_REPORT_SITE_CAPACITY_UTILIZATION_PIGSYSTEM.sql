-- =============================================
-- Author:		Mike Zimanski, dbo.cfp_Report_Capacity_Utilization_PigSystem
-- Create date: 03/22/2011
-- Description:	This procedure populates the dropdown options.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_SITE_CAPACITY_UTILIZATION_PIGSYSTEM 
	-- Add the parameters for the stored procedure here
	(@LookbackDays Float = 140)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    
SET @LookbackDays = Case When ABS(@LookbackDays) > 728 Then -728
	When ABS(@LookbackDays) < 28 Then -28 Else -CEILING(ABS(@LookbackDays)/7)*7 End

------------------------------
--Active Site Query By Week
------------------------------

Select Distinct 
PigSystem = Case When Exists (Select pg.PigGroupID
	From [$(SolomonApp)].dbo.cftPigGroup pg
	Where pg.projectid = a.Project
		And a.ActiveDate Between pg.ActStartDate And pg.ActCloseDate
		And pg.PigSystemID = '01') Then 'Multiplication' Else 'Commercial' End
, f.Description
From  dbo.cft_ACTIVE_SITE_LIST a
	Inner join [$(SolomonApp)].dbo.PjProj Pj WITH (NoLock) on a.Project = pj.Project
	Inner join [$(SolomonApp)].dbo.cftsite site WITH (NOLOCK) on a.project=site.solomonprojectid
	Inner join [$(SolomonApp)].dbo.cftfacilitytype f WITH (NOLOCK) on site.facilitytypeid=f.facilitytypeid
Where a.ActiveDate >= DATEADD(dd,@LookbackDays,Dateadd(dd,-Datepart(dw,GetDate()),DateAdd(dd,Datediff(dd,0,GetDate()),0)))
	And site.SiteID Not In (9999,0210,8101,8145,8122,0220,8102,7980,7010,7020,7030,7040,7050,7060)
	And f.Description Not In('Sow Farm','Gilt Isolation','Gilt Dev','TE')

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CAPACITY_UTILIZATION_PIGSYSTEM] TO [db_sp_exec]
    AS [dbo];

