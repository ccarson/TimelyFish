-- =============================================
-- Author:		Matt Brandt, dbo.cfp_Report_Capacity_Utilization
-- Create date: 08/03/2010
-- Description:	This procedure creates the dataset for the Capacity Utilization Report
-- The user can specify the number of days the report should lookback as a parameter.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_SITE_CAPACITY_UTILIZATION 
	-- Add the parameters for the stored procedure here
	(@LookbackDays Float = 140,
	@PigSystem VarChar(8000),
	@Description VarChar(8000))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @TempPigSystem VarChar(30)

	IF @PigSystem = '%' 

	BEGIN
		SET @TempPigSystem = '%'
	END
	
	ELSE
	BEGIN
		SET @TempPigSystem = @PigSystem
	END

	DECLARE @TempDescription VarChar(30)

	IF @Description = '%' 

	BEGIN
		SET @TempDescription = '%'
	END
	
	ELSE
	BEGIN
		SET @TempDescription = @Description
	END

    -- Insert statements for procedure here
    
SET @LookbackDays = Case When ABS(@LookbackDays) > 728 Then -728
	When ABS(@LookbackDays) < 28 Then -28 Else -CEILING(ABS(@LookbackDays)/7)*7 End

------------------------------
--Active Site Query By Week
------------------------------

Select 
	a.Project, 
	a.ActiveDate, 
	a.PigSystem, 
	Pj.Project_desc, 
	f.Description, 
	Sum(t.Qty * t.InvEffect) as CurrentInv, 
	Case When Sum(t.Qty * t.InvEffect) > b.MaxCapacity
	then b.MaxCapacity Else Sum(t.Qty * t.InvEffect) End as CappedInv, 
	b.MaxCapacity
	
	From  dbo.cft_ACTIVE_SITE_LIST a
	
	left join (Select Distinct PigGroupID, ProjectID from [$(SolomonApp)].dbo.cftPigGroup) Pg 
	on a.Project = Pg.ProjectID
	
	left join (Select PigGroupID, Qty, InvEffect, TranDate 
	from [$(SolomonApp)].dbo.cftPGInvTran Where Reversal != 1) t 
	on Pg.PigGroupID = t.PigGroupID 
	and a.ActiveDate >= t.TranDate
	
	left join [$(SolomonApp)].dbo.PjProj Pj (NoLock) 
	on a.Project = pj.Project
	
	left join [$(SolomonApp)].dbo.cftSite Site(NoLock) 
	on a.Project = Site.SolomonProjectID
	
	left join (Select ContactID, Sum(MaxCap) as MaxCapacity 
	from [$(SolomonApp)].dbo.cftBarn Group by ContactID) b 
	on Site.ContactID = b.ContactID 
	
	left join [$(SolomonApp)].dbo.cftFacilityType f (NoLock) 
	on Site.FacilityTypeID = f.FacilityTypeID
	
	Where a.ActiveDate >= DATEADD(dd,@LookbackDays,Dateadd(dd,-Datepart(dw,GetDate()),DateAdd(dd,Datediff(dd,0,GetDate()),0)))
	and Site.SiteID not In (9999,0210,8101,8145,8122,0220,8102,7980,7010,7020,7030,7040,7050,7060)
	and f.Description not in ('Sow Farm','Gilt Isolation','Gilt Dev','TE')
	and a.PigSystem like @TempPigSystem 
	and f.Description like @TempDescription 
	
	Group by
	a.Project, 
	a.ActiveDate, 
	a.PigSystem, 
	Pj.Project_desc, 
	f.Description,
	b.MaxCapacity


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CAPACITY_UTILIZATION] TO [db_sp_exec]
    AS [dbo];

