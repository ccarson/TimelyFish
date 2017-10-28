--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/07/2013
--	Usage: SSIS Pig Champ to Sowdata.SowFalloutEvent, 		 
-- exec SSIS_Ensure_SowFalloutEvent ?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowFalloutEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventType [varchar](20),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@SowParity [smallint],
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowFalloutEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowFalloutEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
      ,[EventType] = @EventType
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowFalloutEvent]
           ([FarmID]
           ,[SowID]
           ,[EventType]
           ,[EventDate]
           ,[WeekOfDate]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
           ,@EventType
           ,@EventDate
           ,@WeekOfDate
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowFalloutEvent] TO [db_sp_exec]
    AS [dbo];

