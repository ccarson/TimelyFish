
-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Device Sync By Farm BY Device
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
create PROCEDURE [dbo].[CFP_REPORT_Device_Sync_By_Farm_By_Device] 
@FarmName nvarchar(50),
@DeviceName nvarchar(80)

AS
DECLARE @TableName nvarchar(30);
SET @TableName = 'CFT_ANIMALEVENTS'; 
SELECT  @FarmName as 'Farm Name'
	  ,U.[NAME] as 'Device'
      ,count (ms.[INSTANCEIDGUID]) as '# of Items Synced'
      ,SI.[SYNCDATE] as 'SyncDate'
      
  FROM [MobileFrame].[dbo].[MF_SYNC_INFO] SI (NOLOCK)
 Join  [MobileFrame].[dbo].[MF_USER] U (NOLOCK) on SI.[DBID] = U.[REMOTEDBID]
 Join [MobileFrame].[dbo].[MF_META_OBJECT] t (Nolock) on SI.tableID = T.id
 Join [MobileFrame].[dbo].[MF_SYNC_INFO] as MS WITH (NOLOCK) on SI.DBID = MS.DBID AND SI.[SYNCDATE] = MS.[SYNCDATE] AND SI.[TABLEID] = MS.[TABLEID]
 where U.DEPARTMENT = @FarmName
 and T.NAME = @TableName
 and U.NAME like @DeviceName
 Group by U.[NAME]
     ,T.[NAME]
      ,T.[DESCRIPTION]
      ,SI.[SYNCDATE]
  order by   U.[NAME],SI.[SYNCDATE] desc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_REPORT_Device_Sync_By_Farm_By_Device] TO [CorpReports]
    AS [dbo];

