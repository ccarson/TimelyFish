-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/13/2008
-- Description:	Updates a record into cft_DRIVER_DAY_OFF
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_DAY_OFF_UPDATE]
	  @DriverDayOffID					int
	, @DayOff							smalldatetime
	, @DayOffType					    varchar(10)
	, @UpdatedBy					    varchar(50)
AS
BEGIN
	UPDATE dbo.cft_DRIVER_DAY_OFF
	SET DayOff = @DayOff, 
		DayOffType = @DayOffType,
		UpdatedBy = @UpdatedBy,
		UpdatedDateTime = getdate()
	WHERE 
		DriverDayOffID = @DriverDayOffID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_DAY_OFF_UPDATE] TO [db_sp_exec]
    AS [dbo];

