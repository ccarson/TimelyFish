--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/12/2013
--	Usage: SSIS Pig Champ to Sowdata.SowFarrowEvent, 		 
-- exec SSIS_Ensure_SowFarrowEvent ?,?,?,?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowFarrowEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@QtyBornAlive float,
    @QtyStillBorn float,
    @QtyMummy float,
    @Induced [varchar](3),
    @Assisted [varchar](3),
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowFarrowEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowFarrowEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
	  ,[QtyBornAlive] = @QtyBornAlive
      ,[QtyStillBorn] = @QtyStillBorn
      ,[QtyMummy] = @QtyMummy
      ,[Induced] = @Induced
      ,[Assisted] = @Assisted
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowFarrowEvent]
           ([FarmID]
           ,[SowID]
           ,[EventDate]
           ,[WeekOfDate]
		   ,[QtyBornAlive]
           ,[QtyStillBorn]
           ,[QtyMummy]
           ,[Induced]
           ,[Assisted]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
		   ,@EventDate
           ,@WeekOfDate
		   ,@QtyBornAlive
           ,@QtyStillBorn
           ,@QtyMummy
           ,@Induced
           ,@Assisted
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowFarrowEvent] TO [db_sp_exec]
    AS [dbo];

