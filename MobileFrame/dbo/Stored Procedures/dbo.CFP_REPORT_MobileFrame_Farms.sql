




-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame active Farms
-- Parameters: 	None
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
10/11/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
Create PROCEDURE [dbo].[CFP_REPORT_MobileFrame_Farms] 

AS

SELECT [NAME]
  FROM [dbo].[CFT_FARM]
  where PIGCHAMP_ID <> -1
  and Status = 1
  order by NAME
		
		

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_REPORT_MobileFrame_Farms] TO [CorpReports]
    AS [dbo];

