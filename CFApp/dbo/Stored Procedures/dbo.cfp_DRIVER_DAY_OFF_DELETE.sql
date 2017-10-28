-- ==================================================
-- Author:	Brian Cesafsky
-- Create date: 01/14/2008
-- Description:	Deletes Days off
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_DAY_OFF_DELETE]
(
	@DriverDayOffID				int
)	
AS
BEGIN
	DELETE dbo.cft_DRIVER_DAY_OFF
	WHERE	DriverDayOffID = @DriverDayOffID
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_DAY_OFF_DELETE] TO [db_sp_exec]
    AS [dbo];

