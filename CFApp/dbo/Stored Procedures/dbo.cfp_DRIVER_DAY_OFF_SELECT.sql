-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/13/2008
-- Description:	Returns all records from cft_DRIVER_DAY_OFF that match the DriverID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_DAY_OFF_SELECT]
	-- Add the parameters for the stored procedure here
	@DriverID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [DriverDayOffID]
		,[DriverID]
		,[DayOff]
		,[DayOffType]
  FROM dbo.cft_DRIVER_DAY_OFF (NOLOCK)
where [DriverID] = @DriverID
Order By DayOff
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_DAY_OFF_SELECT] TO [db_sp_exec]
    AS [dbo];

