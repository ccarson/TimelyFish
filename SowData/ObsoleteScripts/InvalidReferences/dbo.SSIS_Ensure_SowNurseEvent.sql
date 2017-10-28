--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/12/2013
--	Usage: SSIS Pig Champ to Sowdata.SowNurseEvent, 		 
-- exec SSIS_Ensure_SowNurseEvent ?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowNurseEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventType [varchar](20),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@Qty float,
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowNurseEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowNurseEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
	  ,[EventType] = @EventType
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
	  ,[Qty] = @Qty
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowNurseEvent]
           ([FarmID]
           ,[SowID]
		   ,[EventType]
           ,[EventDate]
           ,[WeekOfDate]
		   ,[Qty]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
		   ,@EventType
		   ,@EventDate
           ,@WeekOfDate
		   ,@Qty
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowNurseEvent] TO [db_sp_exec]
    AS [dbo];

