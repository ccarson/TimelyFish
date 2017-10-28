--*************************************************************
--	Purpose:Insert or update the RECORD
--	Author: Doran Dahle
--	Date: 03/07/2013
--	Usage: SSIS Pig Champ to SowPregExamEvent, 		 
-- exec SSIS_Ensure_SowPregExamEvent ?,?,?,?,?,?,?
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[SSIS_Ensure_SowPregExamEvent]
	@FarmID [varchar](8),
	@SowID [varchar](12),
	@EventDate [smalldatetime],
	@WeekOfDate [smalldatetime],
	@ExamResult [varchar](20),
	@SowParity [smallint],
	@SowGenetics [varchar](20)

AS

IF (EXISTS (SELECT * FROM [dbo].[SowPregExamEvent](NOLOCK) WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate ))
begin
UPDATE [dbo].[SowPregExamEvent]
   SET 
       [FarmID] = @FarmID
      ,[SowID] = @SowID
      ,[EventDate] = @EventDate
      ,[WeekOfDate] = @WeekOfDate
      ,[ExamResult] = @ExamResult
      ,[SowParity] = @SowParity
      ,[SowGenetics] = @SowGenetics
 WHERE [FarmID] = @FarmID and [SowID] = @SowID and EventDate = @EventDate
 
 end
else
begin
INSERT INTO [dbo].[SowPregExamEvent]
            ([FarmID]
           ,[SowID]
           ,[EventDate]
           ,[WeekOfDate]
           ,[ExamResult]
           ,[SowParity]
           ,[SowGenetics])
     VALUES
           (@FarmID
           ,@SowID
           ,@EventDate
           ,@WeekOfDate
		   ,@ExamResult
           ,@SowParity
           ,@SowGenetics)           

end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SSIS_Ensure_SowPregExamEvent] TO [db_sp_exec]
    AS [dbo];

