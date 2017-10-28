



-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Device Sync By Farm
-- Parameters: 	@TableName, 
--		@FarmName,
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
09/26/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
CREATE PROCEDURE [dbo].[CFP_REPORT_Device_Sync_By_Farm] 
@FarmName nvarchar(50)

AS
DECLARE @TableName nvarchar(30);
SET @TableName = 'CFT_ANIMALEVENTS'; 
SELECT  
  
	  @FarmName as 'Farm Name'
	 ,U.[NAME] as 'User Device'
 
      ,U.DEPARTMENT as Farmname
      --,count ([INSTANCEIDGUID]) as 'Nbr Items Synced'
	   ,IsNull(DATEDIFF(minute, U.[SERVERCOUNTDATE], GETDATE()), 9999) as 'SyncMinutes'
      ,U.[SERVERCOUNTDATE] as 'Last Sync'
      
  FROM [MobileFrame].[dbo].[MF_USER] U (NOLOCK) 
 
 where U.DEPARTMENT Like @FarmName
 and U.DELETED_BY = -1
 
 Group by U.[NAME]
      ,U.DEPARTMENT
	  ,u.SERVERCOUNTDATE
  order by  U.[NAME],  U.[SERVERCOUNTDATE] desc
  


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_REPORT_Device_Sync_By_Farm] TO [CorpReports]
    AS [dbo];

