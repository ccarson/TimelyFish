
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/01/2008
-- Description:	Updates the PartialTicket record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PARTIAL_TICKET_UPDATE
(
    @PartialTicketID		int,
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
    @DryingRateAdj 		money,
    @HandlingRateAdj  		money,
    @DeferredPaymentRateAdj 	money,
    @MiscAdj			money,
    @MiscAdjNote		varchar(60),
    @TicketAdjNote		varchar(1000),
    @GrainTransportRate		money,
    @PaymentTypeID		int,
    @QuoteID			int,
    @PaymentTermsID		varchar(2),
    @UpdatedBy			varchar(50),
    @ContractNumber             varchar(100)	OUT,
    @CornProducerName		varchar(30)	OUT,
    @CanBeReleasedForPayment	bit		OUT,
    @ReadyToBeReleased		bit,
    @WetBushels			decimal(20,4)

)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_PARTIAL_TICKET SET
	PartialTicketStatusID = @PartialTicketStatusID,
    TicketNumber = @TicketNumber,
    FullTicketID = @FullTicketID,
    ContractID = @ContractID,
    CornProducerID = @CornProducerID,
    DeliveryCornProducerID = @DeliveryCornProducerID,
    DeliveryDate = @DeliveryDate,
    DryBushels = @DryBushels,
    MoistureRateAdj = @MoistureRateAdj,
    ForeignMaterialRateAdj = @ForeignMaterialRateAdj,
    TestWeightRateAdj = @TestWeightRateAdj,
    DryingRateAdj = @DryingRateAdj,
    HandlingRateAdj = @HandlingRateAdj,
    DeferredPaymentRateAdj = @DeferredPaymentRateAdj,
    MiscAdj = @MiscAdj,
    MiscAdjNote = @MiscAdjNote,
    TicketAdjNote = @TicketAdjNote,
    GrainTransportRate = @GrainTransportRate,
    PaymentTypeID = @PaymentTypeID,
    QuoteID = @QuoteID,
    PaymentTermsID = @PaymentTermsID,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate(),
    ReadyToBeReleased = @ReadyToBeReleased,
    WetBushels = @WetBushels
  WHERE PartialTicketID = @PartialTicketID

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
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PARTIAL_TICKET_UPDATE] TO [db_sp_exec]
    AS [dbo];

