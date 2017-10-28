
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/07/2008
-- Description: Creates new CornTicket record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CORN_TICKET_INSERT
(
    @TicketID 		int 		OUT,
    @TicketNumber	varchar(20),
    @FeedMillID		char(10),
    @CornProducerID	varchar(15),
    @DeliveryDate	datetime,
    @SourceFarm		varchar(20),
    @SourceFarmBin	varchar(20),
    @DestinationFarmBin	varchar(20),
    @TicketStatusID	int,
    @PaymentTypeID	int,
    @Commodity		varchar(20),
	@CommodityID	tinyint,
    @Moisture		money,
    @ForeignMaterial	money,
    @OilContent		money,
    @TestWeight		money,
    @Gross		money,
    @Net		money,
    @Comments		varchar(2000),
    @ManuallyEntered	bit,
    @SentToDryer	bit,
    @TicketReminderNote	varchar(2000),
    @CornProducerComments	varchar(2000),
    @CreatedBy  	varchar(50),
    @ReturnValue	int	OUT
)
AS
BEGIN
  SET NOCOUNT ON

  SET @ReturnValue = 0

  IF EXISTS (SELECT 1
             FROM dbo.cft_CORN_TICKET
             WHERE TicketNumber = @TicketNumber)
  BEGIN
 
    SET @ReturnValue = 2 -- TicketNumber is not unique
    RETURN

  END

  INSERT dbo.cft_CORN_TICKET
  (
      [TicketNumber],
      [FeedMillID],
      [CornProducerID],
      [DeliveryDate],
      [SourceFarm],
      [SourceFarmBin],
      [DestinationFarmBin],
      [Status],
      [PaymentTypeID],
      [Commodity],
      [CommodityID],
      [Moisture],
      [ForeignMaterial],
      [OilContent],
      [TestWeight],
      [Gross],
      [Net],
      [Comments],
      [ManuallyEntered],
      [SentToDryer],
      [TicketReminderNote],
      [CornProducerComments],
      [CreatedBy]
  )
  VALUES
  (
      @TicketNumber,
      @FeedMillID,
      @CornProducerID,
      @DeliveryDate,
      @SourceFarm,
      @SourceFarmBin,
      @DestinationFarmBin,
      @TicketStatusID,
      @PaymentTypeID,
      @Commodity,
      @CommodityID,
      @Moisture,
      @ForeignMaterial,
      @OilContent,
      @TestWeight,
      @Gross,
      @Net,
      @Comments,
      @ManuallyEntered,
      @SentToDryer,
      @TicketReminderNote,
      @CornProducerComments,
      @CreatedBy
  )

  SELECT @TicketID = TicketID
  FROM dbo.cft_CORN_TICKET
  WHERE TicketID = SCOPE_IDENTITY()


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CORN_TICKET_INSERT] TO [db_sp_exec]
    AS [dbo];

