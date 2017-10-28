--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/12/2013
--	Usage: SSIS Pig Champ to Sowdata.SowNonServiceEvent, 		 
-- exec SSIS_Ensure_SowNonServiceEvent ?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowNonServiceEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventType [varchar](20),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowNonServiceEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowNonServiceEvent]
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
INSERT INTO [SowData].[dbo].[SowNonServiceEvent]
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
    ON OBJECT::[dbo].[SSIS_Ensure_SowNonServiceEvent] TO [db_sp_exec]
    AS [dbo];

