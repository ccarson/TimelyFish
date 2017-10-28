-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/01/2009
-- Description:	Returns all Delievery Types for Transportation Schedule
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_TRANSPORTATION_SCHEDULE_DELIVERY_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT ScheduleDeliveryTypeID
	  ,ScheduleDeliveryTypeDescription
FROM dbo.cft_TRANSPORTATION_SCHEDULE_DELIVERY_TYPE (NOLOCK)
Order By ScheduleDeliveryTypeID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_SCHEDULE_DELIVERY_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

