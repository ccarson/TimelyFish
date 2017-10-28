

--*************************************************************

--	Author: Doran Dahle
--	Date: 11/12/13
--	Usage: Internal Tran 
--	Parms: @StartDate 
--	      
--*************************************************************

CREATE PROC [dbo].[cfp_REPORT_HAT_Conflict]
	@StartDate as datetime

	
AS
SELECT [SiteID]
      ,[SiteName]
      ,[Post_PMID]
      ,[Post_PMLoadID]
      ,[Post_MovementDate]
      ,[Post_Days]
      ,[Received_From]
      ,[Pre_PMID]
      ,[Pre_PMLoadID]
      ,[Pre_MovementDate]
      ,[Pre_days]
      ,[Ship_to]
  FROM [SolomonApp].[dbo].[cfv_HAT_Conflict_PMLoads]
   where [Post_MovementDate] >= @StartDate
union 
SELECT [SiteID]
      ,[SiteName]
      ,[Post_PMID]
      ,[Post_PMLoadID]
      ,[Post_MovementDate]
      ,[Post_Days]
      ,[Received_From]
      ,[Pre_PMID]
      ,[Pre_PMLoadID]
      ,[Pre_MovementDate]
      ,[Pre_days]
      ,[Ship_to]
  FROM [SolomonApp].[dbo].[cfv_HAT_Conflict_PMLoads]
   where [Pre_MovementDate] >= @StartDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_HAT_Conflict] TO [MSDSL]
    AS [dbo];

