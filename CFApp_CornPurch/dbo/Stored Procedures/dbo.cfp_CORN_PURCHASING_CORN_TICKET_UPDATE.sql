
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/28/2008
-- Description:	Updates the CornTicket record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CORN_TICKET_UPDATE
(
    @TicketID		int,
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
    @UpdatedBy		varchar(50),
    @ReturnValue	int	OUT
)
AS
BEGIN
  SET NOCOUNT ON

  SET @ReturnValue = 0

  IF EXISTS (SELECT 1
             FROM dbo.cft_CORN_TICKET
             WHERE TicketNumber = @TicketNumber AND TicketID <> @TicketID)
  BEGIN
 
    SET @ReturnValue = 2 -- TicketNumber is not unique
    RETURN

  END


  UPDATE dbo.cft_CORN_TICKET SET
    TicketNumber = @TicketNumber,
    FeedMillID = @FeedMillID,
    CornProducerID = @CornProducerID,
    DeliveryDate = @DeliveryDate,
    SourceFarm = @SourceFarm,
    SourceFarmBin = @SourceFarmBin,
    DestinationFarmBin = @DestinationFarmBin,
    TicketStatusID = @TicketStatusID,
    PaymentTypeID = @PaymentTypeID,
    Commodity = @Commodity,
    CommodityID = @CommodityID,
    Moisture = @Moisture,
    ForeignMaterial = @ForeignMaterial,
    OilContent = @OilContent,
    TestWeight = @TestWeight,
    Gross = @Gross,
    Net = @Net,
    Comments = @Comments,
    ManuallyEntered = @ManuallyEntered,
    SentToDryer = @SentToDryer,
    TicketReminderNote = @TicketReminderNote,
    CornProducerComments = @CornProducerComments,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE TicketID = @TicketID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CORN_TICKET_UPDATE] TO [db_sp_exec]
    AS [dbo];

