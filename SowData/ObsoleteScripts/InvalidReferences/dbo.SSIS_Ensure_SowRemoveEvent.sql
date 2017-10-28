--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/12/2013
--	Usage: SSIS Pig Champ to SowRemoveEvent, 		 
-- exec SSIS_Ensure_SowRemoveEvent ?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
CREATE PROC [dbo].[SSIS_Ensure_SowRemoveEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@RemovalType [varchar](20),
	@PrimaryReason [varchar](30),
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [dbo].[SowRemoveEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID ))
begin
UPDATE [dbo].[SowRemoveEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
	  ,[RemovalType] = @RemovalType
      ,[PrimaryReason] = @PrimaryReason
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [dbo].[SowRemoveEvent]
           ([FarmID]
           ,[SowID]
           ,[EventDate]
           ,[WeekOfDate]
		   ,[RemovalType]
           ,[PrimaryReason]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
		   ,@EventDate
           ,@WeekOfDate
		   ,@RemovalType
           ,@PrimaryReason
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowRemoveEvent] TO [db_sp_exec]
    AS [dbo];

