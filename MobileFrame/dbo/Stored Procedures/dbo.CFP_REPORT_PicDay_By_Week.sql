
-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Device Gets Pic Day number for a given week number
-- Parameters: 	@GroupName, 
--		
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
09/26/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
CREATE PROCEDURE [dbo].[CFP_REPORT_PicDay_By_Week] 
@GroupName nvarchar(4)

AS
DECLARE @startdate datetime
DECLARE @enddate datetime

create table #Temp
(
	PicDay int,
	CalDate DateTime
)

select top 1 @startdate = G.WEEKOFDATE, @enddate = G.WEEKENDDATE FROM dbo.CFT_WEEKDEFINITION G where G.GROUPNAME = @GroupName 

WHILE @enddate >= @startdate
	BEGIN
	Insert into #Temp 
		Select DATEDIFF(DAY, '9/27/1971', @startdate) % 1000 as 'PicDay', @startdate
	SET @startdate = @startdate + 1;
	
END;

select * from #Temp 

Drop table #Temp


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_REPORT_PicDay_By_Week] TO [CorpReports]
    AS [dbo];

