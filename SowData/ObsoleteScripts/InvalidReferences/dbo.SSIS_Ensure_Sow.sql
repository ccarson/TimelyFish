--*************************************************************
--	Purpose:Insert or update Sow RECORD
--	Author: Doran Dahle
--	Date: 03/07/2013
--	Usage: SSIS Pig Champ to sow, 		 
-- exec SSIS_Ensure_Sow ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_Sow]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@AlternateID [varchar](20),
	@EntryDate [smalldatetime],
	@EntryWeekOfDate [smalldatetime],
	@Genetics [varchar](20),
	@InitialParity [smallint],
	@Origin [varchar](20),
	@Birthdate [smalldatetime],
	@Sire [varchar](12),
	@Dam [varchar](12),
	@RemovalDate [smalldatetime],
	@RemovalWeekOfDate [smalldatetime],
	@RemovalType [varchar](20),
	@PrimaryReason [varchar](30)

AS

IF (EXISTS (SELECT * FROM [dbo].[Sow](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID ))
begin
UPDATE [dbo].[Sow]
   SET 
       [AlternateID] = @AlternateID
      ,[EntryDate] = @EntryDate
      ,[EntryWeekOfDate] = @EntryWeekOfDate 
      ,[Genetics] = @Genetics
      ,[InitialParity] = @InitialParity
      ,[Origin] = @Origin
      ,[Birthdate] = @Birthdate
      ,[Sire] = @Sire
      ,[Dam] = @Dam
      ,[RemovalDate] = @RemovalDate
      ,[RemovalWeekOfDate] = @RemovalWeekOfDate
      ,[RemovalType] = @RemovalType
      ,[PrimaryReason] = @PrimaryReason
 WHERE [FarmID] = @FarmID and [SowID] = @SowID 
 
 end
else
begin
INSERT INTO [dbo].[Sow]
           ([FarmID]
           ,[SowID]
           ,[AlternateID]
           ,[EntryDate]
           ,[EntryWeekOfDate]
           ,[Genetics]
           ,[InitialParity]
           ,[Origin]
           ,[Birthdate]
           ,[Sire]
           ,[Dam]
           ,[RemovalDate]
           ,[RemovalWeekOfDate]
           ,[RemovalType]
           ,[PrimaryReason])
     VALUES
           (@FarmID
           ,@SowID
           ,@AlternateID
           ,@EntryDate
           ,@EntryWeekOfDate 
           ,@Genetics
           ,@InitialParity
           ,@Origin
           ,@Birthdate
           ,@Sire
           ,@Dam
           ,@RemovalDate
           ,@RemovalWeekOfDate
           ,@RemovalType
           ,@PrimaryReason)
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_Sow] TO [db_sp_exec]
    AS [dbo];

