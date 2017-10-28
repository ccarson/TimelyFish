




-- =============================================
-- Author:		Doran Dahle
-- Create date: 4/18/14
-- Description:	Used for finding sites that have HAT schedules.
-- =============================================
CREATE PROCEDURE [dbo].[pXT300HATSiteList] 
	@StartDate datetime,
	@EndDate datetime
	
AS
BEGIN
DECLARE @listStr VARCHAR(MAX)
Select @listStr = COALESCE(@listStr+',' ,'') + hat.ContactID 
	from (Select distinct SiteContactID  as ContactID
	from [dbo].[cfv_HAT_Site_Schedule]
	     Where [TestDate] between DATEADD(day, -4,@StartDate) and @EndDate ) as hat
 SELECT @listStr as ContactIDs
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300HATSiteList] TO [MSDSL]
    AS [dbo];

