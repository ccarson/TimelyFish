
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/01/2008
-- Description:	Creates new PartialTicket record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PARTIAL_TICKET_INSERT
(
    @PartialTicketID		int		OUT,
	@PartialTicketStatusID int,
    @TicketNumber		varchar(20),
    @FullTicketID		int,
    @ContractID			int,
    @CornProducerID		varchar(15),
    @DeliveryCornProducerID	varchar(15),
    @DeliveryDate		datetime,
    @DryBushels			decimal(18,4),
    @MoistureRateAdj  		money,
    @ForeignMaterialRateAdj 	money,
    @TestWeightRateAdj  	money,
    @DryingRateAdj 	 	money,
    @HandlingRateAdj  		money,
    @DeferredPaymentRateAdj 	money,
    @MiscAdj  			money,
    @MiscAdjNote  		varchar(60),
    @TicketAdjNote		varchar(1000),    
    @GrainTransportRate		money,
    @PaymentTypeID		int,
    @QuoteID			int,
    @PaymentTermsID		varchar(2),
    @CreatedBy			varchar(50),
    @ContractNumber             varchar(100)	OUT,
    @CornProducerName		varchar(30)	OUT,
    @CanBeReleasedForPayment	bit		OUT,
    @ReadyToBeReleased		bit,
    @WetBushels			decimal(20,4)	 
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_PARTIAL_TICKET
  (
      [PartialTicketStatusID],
      [TicketNumber],
      [FullTicketID],
      [ContractID],
      [CornProducerID],
      [DeliveryCornProducerID],
      [DeliveryDate],
      [DryBushels],
      [MoistureRateAdj],
      [ForeignMaterialRateAdj],
      [TestWeightRateAdj],
      [DryingRateAdj],
      [HandlingRateAdj],
      [DeferredPaymentRateAdj],
      [MiscAdj],
      [MiscAdjNote],
      [TicketAdjNote],
      [GrainTransportRate],
      [PaymentTypeID],
      [QuoteID],
      [PaymentTermsID],
      [CreatedBy],
      [ReadyToBeReleased],
      [WetBushels]
  )
  VALUES
  (
      @PartialTicketStatusID,
      @TicketNumber,
      @FullTicketID,
      @ContractID,
      @CornProducerID,
      @DeliveryCornProducerID,
      @DeliveryDate,
      @DryBushels,
      @MoistureRateAdj,
      @ForeignMaterialRateAdj,
      @TestWeightRateAdj,
      @DryingRateAdj,
      @HandlingRateAdj,
      @DeferredPaymentRateAdj,
      @MiscAdj,
      @MiscAdjNote,
      @TicketAdjNote,
      @GrainTransportRate,
      @PaymentTypeID,
      @QuoteID,
      @PaymentTermsID,
      @CreatedBy,
      @ReadyToBeReleased,
      @WetBushels
  )

  SELECT @PartialTicketID = PartialTicketID
  FROM dbo.cft_PARTIAL_TICKET
  WHERE PartialTicketID = SCOPE_IDENTITY()

  SELECT @ContractNumber = C.ContractNumber,
         @CornProducerName = V.RemitName,
         @CanBeReleasedForPayment = CASE WHEN PT.PaymentTypeID IN (3,4) 
                                               OR PT.ContractID IS NOT NULL AND C.DeferredPaymentDate IS NOT NULL AND DATEDIFF(day,C.DeferredPaymentDate,getdate()) > 0 
                                               OR PT.ContractID IS NOT NULL AND ISNULL(C.Cash,0) = 0 
                                         THEN 0 ELSE 1 END 

  FROM dbo.cft_PARTIAL_TICKET PT
  INNER JOIN [$(SolomonApp)].dbo.Vendor V ON PT.CornProducerID = V.VendID
  LEFT OUTER JOIN dbo.cft_CONTRACT C ON PT.ContractID = C.ContractID
  WHERE PT.PartialTicketID = @PartialTicketID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PARTIAL_TICKET_INSERT] TO [db_sp_exec]
    AS [dbo];

