-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/13/2008
-- Description:	Inserts a record into cft_DRIVER_DAY_OFF
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_DAY_OFF_INSERT]
	-- Add the parameters for the stored procedure here
	@DriverID							int
	, @DayOff							smalldatetime
	, @DayOffType					    varchar(10)
	, @CreatedBy					    varchar(50)
AS
BEGIN
INSERT INTO dbo.cft_DRIVER_DAY_OFF
	(   
		[DriverID],
		[DayOff],
		[DayOffType],
		[CreatedBy]
	)
	VALUES 
	(	
		@DriverID,
		@DayOff,
		@DayOffType,
		@CreatedBy
	)
END














GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_DAY_OFF_INSERT] TO [db_sp_exec]
    AS [dbo];

