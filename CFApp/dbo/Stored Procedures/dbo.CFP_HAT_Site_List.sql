




-- =============================================
-- Author:		Doran Dahle
-- Create date: 4/18/14
-- Description:	Used for finding sites that have HAT schedules.
-- =============================================
Create PROCEDURE [dbo].[CFP_HAT_Site_List] 
	@StartDate datetime,
	@EndDate datetime
	
AS
BEGIN
DECLARE @listStr VARCHAR(MAX)
Select @listStr = COALESCE(@listStr+',' ,'') + hat.ContactID 
	from (Select distinct SiteContactID  as ContactID
	from [$(SolomonApp)].[dbo].[cfv_HAT_Site_Schedule]
	     Where [TestDate] between DATEADD(day, -4,@StartDate) and @EndDate ) as hat
 SELECT @listStr as ContactIDs
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_HAT_Site_List] TO [ApplicationCenter]
    AS [dbo];

