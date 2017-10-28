

CREATE PROCEDURE dbo.cfp_ACTIVE_SITE_LIST_INSERT

AS
BEGIN

	SET NOCOUNT ON;
	
	
	
Truncate Table  dbo.cft_ACTIVE_SITE_LIST

---------------------------------------------------------------------------------------------------------------------------------------
--Set Variables
DECLARE @Rundate datetime
	, @ShortRundateaddition int
	, @ShortRundatesubtraction int
	, @LongRundateaddition int
	, @LongRundatesubtraction int
	, @ShortEndDate datetime
	, @LongEndDate datetime
	
SELECT @Rundate = Dateadd(dd,-Datepart(dw,GetDate()),DateAdd(dd,Datediff(dd,0,GetDate()),0))
	, @ShortRundateaddition = 40
	, @ShortRundatesubtraction = -40
	, @LongRundateaddition = 30
	, @LongRundatesubtraction = -30

SELECT @ShortEndDate = DATEADD(dd,-28,@RunDate)
	, @LongEndDate = DATEADD(dd,-728,@RunDate)
---------------------------------------------------------------------------------------------------------------------------------------

------------------------------
--Find Inventory Transactions
------------------------------

Declare @SiteInvTran Table
(Project CHAR(16), InvTranDate DATETIME, PigSystemID Char(10) )

INSERT INTO @SiteInvTran

Select Distinct pj.Project, t.trandate, pg.PigSystemID
From [$(SolomonApp)].dbo.PjProj Pj WITH (NOLOCK)
	Inner join [$(SolomonApp)].dbo.cftsite site WITH (NOLOCK) on pj.project=site.solomonprojectid
	Inner join [$(SolomonApp)].dbo.cftcontact c WITH (NOLOCK) on site.contactid=c.contactid
	inner join [$(SolomonApp)].dbo.cftpiggroup pg WITH (NOLOCK) on pg.projectid = pj.Project
	Inner join [$(SolomonApp)].dbo.cftpginvtran t WITH (NOLOCK) on t.piggroupid=pg.piggroupid
Where t.reversal<>'1' and t.rlsed='1' and c.contacttypeid='04'
Order By pj.Project, t.trandate

------------------------------
--Find Feed Transactions
------------------------------

Declare @SiteFeedTran Table
(Project CHAR(16), FeedTranDate DATETIME, PigSystemID Char(10))

Insert Into @SiteFeedTran

Select Distinct pj.Project, fo.datedel, pg.PigSystemID
From [$(SolomonApp)].dbo.PjProj Pj WITH (NOLOCK)
	Inner join [$(SolomonApp)].dbo.cftsite site WITH (NOLOCK) on pj.project=site.solomonprojectid
	Inner join [$(SolomonApp)].dbo.cftcontact c WITH (NOLOCK) on site.contactid=c.contactid
	inner join [$(SolomonApp)].dbo.cftpiggroup pg WITH (NOLOCK) on pg.projectid = pj.Project
	Inner Join [$(SolomonApp)].dbo.cftfeedorder fo WITH (NOLOCK) on fo.taskid=pg.taskid
Where reversal<>'1' and fo.status='c' and c.contacttypeid='04'
Order By pj.Project, fo.datedel

Declare @ActiveSite Table
(Project CHAR(16), ActiveDate DATETIME, Pigsystem CHAR(15)
, Project_desc CHAR(30)
, Description CHAR(20)
, CurrentInv FLOAT
, CappedInv FLOAT
, MaxCapacity FLOAT)

---------------------------------------
--Recent Active Sites
---------------------------------------

WHILE @RunDate >= @ShortEndDate
BEGIN
INSERT INTO  dbo.cft_ACTIVE_SITE_LIST

Select Pj.Project, @RunDate AS ActiveDate
, Case When Exists 
	(Select Distinct i.PigSystemID, Min(i.InvTranDate) 
	From @SiteInvTran i
	Where i.Project = pj.Project
		and i.InvTranDate Between @RunDate and DateAdd(day,@ShortRundateaddition,@Rundate)
		and i.PigSystemID = '00' Group by i.PigSystemID) Then 'Commercial'
When Exists 
	(Select Distinct f.PigSystemID, Min(f.FeedTranDate) 
	From @SiteFeedTran f
	Where f.Project = pj.Project
		and f.FeedTranDate Between @RunDate and DateAdd(day,@ShortRundateaddition,@Rundate)
		and f.PigSystemID = '00' Group by f.PigSystemID) Then 'Commercial'
When Exists 
	(Select Distinct i.PigSystemID, Max(i.InvTranDate) 
	From @SiteInvTran i
	Where i.Project = pj.Project
		and i.InvTranDate Between DateAdd(day,@ShortRundatesubtraction,@Rundate) and @RunDate
		and i.PigSystemID = '00' Group by i.PigSystemID) Then 'Commercial'
When Exists 
	(Select Distinct f.PigSystemID, Max(f.FeedTranDate) 
	From @SiteFeedTran f
	Where f.Project = pj.Project
		and f.FeedTranDate Between DateAdd(day,@ShortRundatesubtraction,@Rundate) and @RunDate
		and f.PigSystemID = '00' Group by f.PigSystemID) Then 'Commercial'
Else 'Multiplication' End As Pigsystem

From [$(SolomonApp)].dbo.PjProj Pj WITH (NOLOCK)
	
Where	Exists (Select s.Project 
		From @SiteInvTran s
		Where s.Project = Pj.Project
			And s.InvTranDate Between DateAdd(day,@ShortRundatesubtraction,@Rundate) And @RunDate)
		OR
		Exists (Select f.Project 
		From @SiteFeedTran f
		Where f.Project = Pj.Project
			And f.FeedTranDate Between DateAdd(day,@ShortRundatesubtraction,@Rundate) And @RunDate)
		OR
		Exists (Select s.Project 
		From @SiteInvTran s
		Where s.Project = Pj.Project
			And s.InvTranDate Between @RunDate AND DateAdd(day,@ShortRundateaddition,@Rundate))
		OR
		Exists (Select f.Project 
		From @SiteFeedTran f
		Where f.Project = Pj.Project
			And f.FeedTranDate Between @RunDate AND DateAdd(day,@ShortRundateaddition,@Rundate))
		
Set @RunDate = DATEADD(dd,-7,@RunDate)

END



---------------------------------------
--Historical Active Sites
---------------------------------------

WHILE @RunDate >= @LongEndDate
BEGIN
INSERT INTO  dbo.cft_ACTIVE_SITE_LIST

Select Pj.Project, @RunDate AS ActiveDate
, Case When Exists 
	(Select Distinct i.PigSystemID, Min(i.InvTranDate) 
	From @SiteInvTran i
	Where i.Project = pj.Project
		and i.InvTranDate Between @RunDate and DateAdd(day,@LongRundateaddition,@Rundate)
		and i.PigSystemID = '00' Group by i.PigSystemID) Then 'Commercial'
When Exists 
	(Select Distinct f.PigSystemID, Min(f.FeedTranDate)
	From @SiteFeedTran f
	Where f.Project = pj.Project
		and f.FeedTranDate Between @RunDate and DateAdd(day,@LongRundateaddition,@Rundate)
		and f.PigSystemID = '00' Group by f.PigSystemID) Then 'Commercial'
Else 'Multiplication' End As Pigsystem

From [$(SolomonApp)].dbo.PjProj Pj WITH (NOLOCK)
	
Where	(
		Exists (Select s.Project 
		From @SiteInvTran s
		Where s.Project = Pj.Project
			And s.InvTranDate Between DateAdd(day,@LongRundatesubtraction,@Rundate) And @RunDate)
		OR
		Exists (Select f.Project 
		From @SiteFeedTran f
		Where f.Project = Pj.Project
			And f.FeedTranDate Between DateAdd(day,@LongRundatesubtraction,@Rundate) And @RunDate)
		)
		AND
		(
		Exists (Select s.Project 
		From @SiteInvTran s
		Where s.Project = Pj.Project
			And s.InvTranDate Between @RunDate AND DateAdd(day,@LongRundateaddition,@Rundate))
		OR
		Exists (Select f.Project 
		From @SiteFeedTran f
		Where f.Project = Pj.Project
			And f.FeedTranDate Between @RunDate AND DateAdd(day,@LongRundateaddition,@Rundate))
		)
		
Set @RunDate = DATEADD(dd,-7,@RunDate)

END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ACTIVE_SITE_LIST_INSERT] TO [db_sp_exec]
    AS [dbo];

