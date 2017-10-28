
create PROCEDURE [dbo].[usp_ProcessLog] 
	@ProcessName varchar (50),
	@ProcessStatus Tinyint,
	@StartTime DateTime,
	@EndTime DateTime = null,
	@Records_Processed Bigint,
	@Comments varchar (2000),
	@Error int,
	@Criteria varchar (2000) = NULL

AS
/*
===============================================================================
Purpose:	Generic proc to make standard logging easier.

Inputs:	@ProcessName		- 
		@ProcessStatus		- 
		@StartTime			- 
		@EndTime			- 
		@Records_Processed	- 
		@Comments			- 
		@Error				- 
		@Criteria			- 

Environ:	Test or Production

Change Log:
Date		Who			Change
-----------	-----------	-------------------------------------------------------
2011-08-04	Dan Bryskin			Initial creation.

===============================================================================
*/
DECLARE @InsertError INT

INSERT INTO dbo.ProcessLog (ProcessName, ProcessStatus, StartTime, EndTime, Records_Processed,
							Comments, Error, Criteria)
Select
@ProcessName,
@ProcessStatus,
@StartTime,
@EndTime,
@Records_Processed,
@Comments,
@Error,
@Criteria

SELECT @InsertError = @@ERROR
RETURN @InsertError