--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/07/2013
--	Usage: SSIS Pig Champ to Sowdata.SowGroupEvent, 		 
-- exec SSIS_Ensure_SowGroupEvent ?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowGroupEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@GroupID varchar(8),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowGroupEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowGroupEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
	  ,[GroupID] = @GroupID
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowGroupEvent]
           ([FarmID]
           ,[SowID]
           ,[GroupID]
           ,[EventDate]
           ,[WeekOfDate]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
           ,@GroupID
		   ,@EventDate
           ,@WeekOfDate
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowGroupEvent] TO [db_sp_exec]
    AS [dbo];

