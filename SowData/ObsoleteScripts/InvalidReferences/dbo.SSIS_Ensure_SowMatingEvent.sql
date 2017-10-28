--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/07/2013
--	Usage: SSIS Pig Champ to Sowdata.SowMatingEvent, 		 
-- exec SSIS_Ensure_SowMatingEvent ?,?,?,?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowMatingEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@MatingType varchar(6),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@SemenID varchar(10),
    @Observer varchar(30),
    @HourFlag int,
    @MatingNbr int,
    @SowParity int,
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [SowData].[dbo].[SowMatingEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [SowData].[dbo].[SowMatingEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
	  ,[MatingType] = @MatingType
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
      ,[SemenID] = @SemenID
      ,[Observer] = @Observer
      ,[HourFlag] = @HourFlag
      ,[MatingNbr] = @MatingNbr
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [SowData].[dbo].[SowMatingEvent]
           ([FarmID]
           ,[SowID]
           ,[MatingType]
           ,[EventDate]
           ,[WeekOfDate]
           ,[SemenID]
           ,[Observer]
           ,[HourFlag]
           ,[MatingNbr]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
           ,@MatingType
		   ,@EventDate
           ,@WeekOfDate
		   ,@SemenID
           ,@Observer
           ,@HourFlag
           ,@MatingNbr
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowMatingEvent] TO [db_sp_exec]
    AS [dbo];

