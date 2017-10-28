

-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 12/03/2008
-- Description:	Creates new contract record and returns it's ID and number.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_INSERT_old]
(
	@ContractID					int		OUT,
	@FeedMillID					char(10),
	@CornProducerID				varchar(30),
	@ContractNumber				varchar(100)	OUT,
	@SequenceNumber				int		OUT,
	@CommodityID 				tinyint,
	@Priority 					int,
	@DateEstablished 			smalldatetime,
	@PricingStartDate 			smalldatetime,
	@DueDateFrom 				smalldatetime,
	@DueDateTo 					smalldatetime,
	@Bushels 					decimal(18,4),
	@Cash 						money,
	@Premium_Deduct 			money,
	@PricedBasis 				money,
	@FuturesBasis 				money,
	@Comments 					varchar(60),
	@PayToCornProducerID		varchar(15),
	@Returned 					bit,
	@ContractStatusID 			tinyint,
	@ContractTypeID 			tinyint,
	@Futures 					money,
	@BasisYear 					smallint,
	@BasisMonth 				tinyint,
	@FuturesYear 				smallint,
	@FuturesMonth 				tinyint,
	@CRMContractID 				varchar(10),
	@_RowVersion				int		OUT,
	@ContractTypeName			varchar(50)	OUT,
	@ReturnValue				int		OUT,
	@ChangeReasonID				tinyint,
	@ContractAdjustment			money,
	@SettlementDate				datetime,
	@Offer						money,
	@CreatedBy					varchar(50),
	@DeferredPaymentDate		datetime,
    @LastContractTypeID			int,
	@ContractTypeChangeDate		datetime,
	@OriginalContractNumber		varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

SET @ReturnValue = 0

IF EXISTS(SELECT TOP 1 1 
          FROM dbo.cft_CONTRACT
          WHERE DueDateFrom = @DueDateFrom 
            AND DueDateTo = @DueDateTo 
            AND CornProducerID = @CornProducerID 
            AND Priority = @Priority 
            AND SubsequenceNumber IS NULL)
BEGIN
  
  SET @ReturnValue = 2 --Priority is not unique


END ELSE BEGIN
  
  SELECT @SequenceNumber = ISNULL(MAX(SequenceNumber), 0) + 1 
  FROM dbo.cft_CONTRACT 
  WHERE FeedMillID = @FeedMillID

  INSERT INTO [dbo].[cft_CONTRACT] 
  (
      [FeedMillID], 
      [CornProducerID], 
      [SequenceNumber], 
      [SubsequenceNumber], 
      [CommodityID], 
      [Priority], 
      [DateEstablished], 
      [PricingStartDate], 
      [DueDateFrom], 
      [DueDateTo], 
      [Bushels], 
      [Cash], 
      [Premium_Deduct], 
      [PricedBasis], 
      [FuturesBasis], 
      [Comments], 
      [PayToCornProducerID], 
      [Returned], 
      [ContractStatusID], 
      [ContractTypeID], 
      [Futures], 
      [BasisYear], 
      [BasisMonth], 
      [FuturesYear], 
      [FuturesMonth], 
      [CRMContractID],
      [ChangeReasonID],
      [ContractAdjustment],
      [SettlementDate],
      [Offer],
      [CreatedBy],
      [DeferredPaymentDate],
      [LastContractTypeID],
      [ContractTypeChangeDate],
      [OriginalContractNumber]
  ) 
  VALUES 
  (
      @FeedMillID, 
      @CornProducerID, 
      @SequenceNumber, 
      NULL, --SubsequenceNumber
      @CommodityID, 
      @Priority, 
      @DateEstablished, 
      @PricingStartDate, 
      @DueDateFrom, 
      @DueDateTo, 
      @Bushels, 
      @Cash, 
      @Premium_Deduct, 
      @PricedBasis, 
      @FuturesBasis, 
      @Comments, 
      @PayToCornProducerID, 
      @Returned, 
      @ContractStatusID, 
      @ContractTypeID, 
      @Futures, 
      @BasisYear, 
      @BasisMonth, 
      @FuturesYear, 
      @FuturesMonth, 
      @CRMContractID,
      @ChangeReasonID,
      @ContractAdjustment,
      @SettlementDate,
      @Offer,
      @CreatedBy,
      @DeferredPaymentDate,
      @LastContractTypeID,
      @ContractTypeChangeDate,
      @OriginalContractNumber
  )

  SELECT @ContractID = C.ContractID, 
         @ContractNumber = C.ContractNumber,
         @SequenceNumber = C.SequenceNumber,
         @_RowVersion = C._RowVersion,
         @ContractTypeName = CT.Name
  FROM dbo.cft_CONTRACT C
  INNER JOIN dbo.cft_CONTRACT_TYPE CT ON C.ContractTypeID = CT.ContractTypeID
  WHERE ContractID = SCOPE_IDENTITY() 
END
END

