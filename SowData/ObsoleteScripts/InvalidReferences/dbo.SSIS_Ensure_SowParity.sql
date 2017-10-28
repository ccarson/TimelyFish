--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/12/2013
--	Usage: SSIS Pig Champ to Sowdata.SowParity, 		 
-- exec SSIS_Ensure_SowParity ?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowParity]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
    @SowParity int

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowParity](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EffectiveDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowParity]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
      ,[EffectiveDate] = @EventDate
      ,[EffectiveWeekOfDate] = @WeekOfDate
      ,[Parity] = @SowParity
      
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EffectiveDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowParity]
           ([FarmID]
           ,[SowID]
           ,[EffectiveDate]
           ,[EffectiveWeekOfDate]
           ,[Parity])
     VALUES
           (@FarmID
           ,@SowID
		   ,@EventDate
           ,@WeekOfDate
           ,@SowParity)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowParity] TO [db_sp_exec]
    AS [dbo];

