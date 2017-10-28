-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 10/23/2008
-- Description:	Inserts a record into cft_UNSETTLED_DRYING_CHARGE
-- ============================================================
CREATE PROCEDURE dbo.cfp_UNSETTLED_DRYING_CHARGE_INSERT
(
		@CornProducerID				varchar(15)
		,@CornProducerName			varchar(30)
		,@DeliveryDate				datetime
		,@DryingChargesAmount		decimal(18, 4)
		,@TicketNumber				varchar(20)
		,@WetBushels				decimal(18, 4)
)
AS
BEGIN
INSERT INTO [cft_UNSETTLED_DRYING_CHARGE]
(
		[CornProducerID]
	   ,[CornProducerName]
	   ,[DeliveryDate]
	   ,[DryingChargesAmount]
	   ,[TicketNumber]
	   ,[WetBushels] 
)
VALUES
(
		@CornProducerID
		,@CornProducerName
		,@DeliveryDate
		,@DryingChargesAmount
		,@TicketNumber
		,@WetBushels
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_UNSETTLED_DRYING_CHARGE_INSERT] TO [db_sp_exec]
    AS [dbo];

