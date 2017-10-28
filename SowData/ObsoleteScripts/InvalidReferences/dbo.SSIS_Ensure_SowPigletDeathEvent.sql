--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/12/2013
--	Usage: SSIS Pig Champ to Sowdata.SowPigletDeathEvent, 		 
-- exec SSIS_Ensure_SowPigletDeathEvent ?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowPigletDeathEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@Qty float,
    @Reason [varchar](20),
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowPigletDeathEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowPigletDeathEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
	  ,[Qty] = @Qty
      ,[Reason] = @Reason
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowPigletDeathEvent]
           ([FarmID]
           ,[SowID]
           ,[EventDate]
           ,[WeekOfDate]
		   ,[Qty]
           ,[Reason]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
		   ,@EventDate
           ,@WeekOfDate
		   ,@Qty
           ,@Reason
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowPigletDeathEvent] TO [db_sp_exec]
    AS [dbo];

