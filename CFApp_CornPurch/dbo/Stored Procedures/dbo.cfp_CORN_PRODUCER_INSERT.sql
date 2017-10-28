-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/03/2008
-- Description:	Inserts a record into cfp_CORN_PRODUCER_INSERT
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_INSERT]
(
		@CornProducerID				varchar(15)
		,@ContactID					int
		,@DefaultFeedMillID			char(10)
		,@DefaultCornMarketerID		int
		,@Active					bit
		,@Comments					varchar(5000)
		,@TicketReminderNote		varchar(2000)
		,@CornCheckoff				bit
		,@EthanolCheckoff			bit
		,@ReceiveCornBidSheet		bit
		,@HasLien					bit
		,@Elevator					bit
		,@CreatedBy					varchar(50)
		,@CanBeInactive				bit	OUT
)
AS
BEGIN
INSERT INTO [cft_CORN_PRODUCER]
(
		[CornProducerID]
	   ,[ContactID]
	   ,[DefaultFeedMillID]
	   ,[DefaultCornMarketerID]
	   ,[Active]
	   ,[Comments]
	   ,[TicketReminderNote]
	   ,[CornCheckoff]
	   ,[EthanolCheckoff]
	   ,[ReceiveCornBidSheet]
	   ,[HasLien]
	   ,[Elevator]
	   ,[CreatedBy]
)
VALUES
(
		@CornProducerID
		,@ContactID
		,@DefaultFeedMillID
		,@DefaultCornMarketerID
		,@Active
		,@Comments
		,@TicketReminderNote
		,@CornCheckoff
		,@EthanolCheckoff
		,@ReceiveCornBidSheet
		,@HasLien
		,@Elevator
		,@CreatedBy
)
END

SELECT @CanBeInactive = dbo.cffn_CAN_CORN_PRODUCER_BE_INACTIVE(@CornProducerID)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_INSERT] TO [db_sp_exec]
    AS [dbo];

