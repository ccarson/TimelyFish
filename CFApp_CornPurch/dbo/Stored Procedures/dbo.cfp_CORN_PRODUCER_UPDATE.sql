-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/03/2008
-- Description:	Updates a record in cfp_CORN_PRODUCER_INSERT
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_UPDATE]
(
		@CornProducerID				varchar(15)
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
		,@UpdatedBy					varchar(50)
		,@CanBeInactive				bit	OUT
)
AS
BEGIN

UPDATE dbo.cft_CORN_PRODUCER
   SET [DefaultFeedMillID] = @DefaultFeedMillID
		,[DefaultCornMarketerID] = @DefaultCornMarketerID
		,[Active] = @Active
		,[Comments] = @Comments
		,[TicketReminderNote] = @TicketReminderNote
		,[CornCheckoff] = @CornCheckoff
		,[EthanolCheckoff] = @EthanolCheckoff
		,[ReceiveCornBidSheet] = @ReceiveCornBidSheet
		,[HasLien] = @HasLien
		,[Elevator] = @Elevator
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[CornProducerID] = @CornProducerID

SELECT @CanBeInactive = dbo.cffn_CAN_CORN_PRODUCER_BE_INACTIVE(@CornProducerID)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_UPDATE] TO [db_sp_exec]
    AS [dbo];

