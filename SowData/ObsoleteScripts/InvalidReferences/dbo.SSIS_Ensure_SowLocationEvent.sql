--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/07/2013
--	Usage: SSIS Pig Champ to Sowdata.SowMatingEvent, 		 
-- exec SSIS_Ensure_SowLocationEvent ?,?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowLocationEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@Barn [varchar](10),
    @Room [varchar](10),
    @Crate [varchar](10),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowLocationEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowLocationEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
	  ,[Barn] = @Barn
      ,[Room] = @Room
      ,[Crate] = @Crate
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowLocationEvent]
           ([FarmID]
           ,[SowID]
           ,[Barn]
           ,[Room]
           ,[Crate]
           ,[EventDate]
           ,[WeekOfDate]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
		   ,@Barn
		   ,@Room
		   ,@Crate 
		   ,@EventDate
           ,@WeekOfDate
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowLocationEvent] TO [db_sp_exec]
    AS [dbo];

