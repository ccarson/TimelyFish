-- =============================================
-- Author:		Matt Brandt, dbo.cfp_Report_Capacity_Utilization
-- Create date: 08/03/2010
-- Description:	This procedure creates the dataset for the Capacity Utilization Report
-- The user can specify the number of days the report should lookback as a parameter.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_SITE_CAPACITY_UTILIZATION 
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

Declare @ActiveSite Table
(Project CHAR(16), ActiveDate DATETIME, Pigsystem CHAR(15)
, Project_desc CHAR(30)
, Description CHAR(20)
, CurrentInv FLOAT
, CappedInv FLOAT
, MaxCapacity FLOAT)

INSERT INTO @ActiveSite

Select a.Project, a.ActiveDate, a.PigSystem
, Pj.Project_desc
, f.Description
, (Select SUM(t.Qty * t.InvEffect) 
	From dbo.cftPigGroup AS pg WITH (NOLOCK)
		inner join dbo.cftPGInvTran AS t WITH (NOLOCK) ON pg.PigGroupID = t.PigGroupID
	Where pg.projectid = a.Project
		and t.Reversal != 1
		and t.TranDate<=a.ActiveDate
	Group By a.Project) AS CurrentInv
, Null
, (Select sum(MaxCap)
	from cftbarn b WITH (NOLOCK)
		inner join cftsite s  WITH (NOLOCK) on b.contactid=s.contactid
	where s.solomonprojectid = a.project
	group by a.project) AS MaxCapacity
From SolomonApp_dw.dbo.cft_ACTIVE_SITE_LIST a
	Inner join PjProj Pj WITH (NoLock) on a.Project = pj.Project
	Inner join cftsite site WITH (NOLOCK) on a.project=site.solomonprojectid
	Inner join cftfacilitytype f WITH (NOLOCK) on site.facilitytypeid=f.facilitytypeid
Where a.ActiveDate >= DATEADD(dd,@LookbackDays,Dateadd(dd,-Datepart(dw,GetDate()),DateAdd(dd,Datediff(dd,0,GetDate()),0)))
	And site.SiteID Not In (9999,0210,8101,8145,8122,0220,8102,7980,7010,7020,7030,7040,7050,7060)

Delete From @ActiveSite Where Description In('Sow Farm','Gilt Isolation','Gilt Dev','TE')
	
Update a
Set CappedInv = Case When CurrentInv > MaxCapacity Then MaxCapacity Else CurrentInv End
From @ActiveSite a

Update a
Set a.PigSystem = Case When Exists (Select pg.PigGroupID
	From SolomonApp.dbo.cftPigGroup pg
	Where pg.projectid = a.Project
		And a.ActiveDate Between pg.ActStartDate And pg.ActCloseDate
		And pg.PigSystemID = '01') Then 'Multiplication' Else 'Commercial' End
From @ActiveSite a
Where Exists (Select pg.PigGroupID
	From SolomonApp.dbo.cftPigGroup pg
	Where pg.projectid = a.Project
		And a.ActiveDate Between pg.ActStartDate And pg.ActCloseDate)

Select *
From @ActiveSite


END
