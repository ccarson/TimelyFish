
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 12/03/2008
-- Description:	Updates the contract record
-- ===================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-07-31  Doran Dahle Added SubProducerName, HTAContract to the update.
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_UPDATE]
(
	@ContractID					int,
	@FeedMillID					char(10),
	@CornProducerID				varchar(30),
	@CommodityID 				tinyint,
	@Priority 					int,
	@DateEstablished 			smalldatetime,
	@PricingStartDate			smalldatetime,
	@DueDateFrom 				smalldatetime,
	@DueDateTo 					smalldatetime,
	@Bushels 					decimal(18,4),
	@Cash 						money,
	@Premium_Deduct 			money,
	@PricedBasis 				money,
	@FuturesBasis 				money,
	@Comments 					varchar(60),
	@PayToCornProducerID 		varchar(15),
	@Returned 					bit,
	@ContractStatusID 			tinyint,                 
	@ContractTypeID 			tinyint,
	@Futures 					money,
	@BasisYear 					smallint,
	@BasisMonth 				tinyint,
	@FuturesYear 				smallint,
	@FuturesMonth 				tinyint,
	@CRMContractID 				varchar(10),
	@_RowVersion				int,
	@ChangeReasonID				tinyint,
	@ContractAdjustment			money,
	@SettlementDate				datetime,
	@Offer						money,
	@New_RowVersion				int		OUT,
	@ContractTypeName			varchar(50)	OUT,
	@ReturnValue				int		OUT,
	@UpdatedBy					varchar(50),
	@DeferredPaymentDate		datetime,
    @LastContractTypeID			int,
	@ContractTypeChangeDate		datetime,
	@OriginalContractNumber		varchar(50),
	@HTAContract				bit,
	@SubProducerName			varchar(30)
)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @SequenceNumber int,
        @SubsequenceNumber int

SELECT @SequenceNumber = SequenceNumber, 
       @SubsequenceNumber = SubsequenceNumber 
FROM dbo.cft_CONTRACT
WHERE ContractID = @ContractID

SET @ReturnValue = 0

IF @SubsequenceNumber IS NULL BEGIN

  IF EXISTS(SELECT TOP 1 1 
            FROM dbo.cft_CONTRACT
            WHERE DueDateFrom = @DueDateFrom AND DueDateTo = @DueDateTo AND CornProducerID = @CornProducerID 
                  AND Priority = @Priority AND ContractID <> @ContractID)
  BEGIN
  
    SET @ReturnValue = 2 --Priority is not unique
    RETURN

  END
END ELSE BEGIN

  IF EXISTS(SELECT TOP 1 1 
            FROM dbo.cft_CONTRACT
            WHERE DueDateFrom = @DueDateFrom AND DueDateTo = @DueDateTo AND CornProducerID = @CornProducerID 
                  AND SequenceNumber = @SequenceNumber AND Priority = @Priority AND ContractID <> @ContractID)
  BEGIN
  
    SET @ReturnValue = 2 --Priority is not unique
    RETURN

  END
END

IF EXISTS(SELECT TOP 1 1 
          FROM dbo.cft_CONTRACT 
          WHERE ContractID = @ContractID AND _RowVersion > @_RowVersion)
BEGIN

  SET @ReturnValue = 1 --ConcurrentUpdate error
  RETURN

END

UPDATE dbo.cft_CONTRACT SET
      FeedMillID = @FeedMillID,
      CornProducerID = @CornProducerID,
      CommodityID = @CommodityID,
      Priority = @Priority,
      DateEstablished = @DateEstablished,
	  PricingStartDate = @PricingStartDate,
      DueDateFrom = @DueDateFrom,
      DueDateTo = @DueDateTo,
      Bushels = @Bushels,
      Cash = @Cash,
      Premium_Deduct = @Premium_Deduct,
      PricedBasis = @PricedBasis,
      FuturesBasis = @FuturesBasis,
      Comments = @Comments,
      PayToCornProducerID = @PayToCornProducerID,
      Returned = @Returned,
      ContractStatusID = @ContractStatusID,
      ContractTypeID = @ContractTypeID,
      Futures = @Futures,
      BasisYear = @BasisYear,
      BasisMonth = @BasisMonth,
      FuturesYear = @FuturesYear,
      FuturesMonth = @FuturesMonth,
      CrmContractID = @CrmContractID,
      _RowVersion = _RowVersion + 1,
      ChangeReasonID = @ChangeReasonID,
      ContractAdjustment = @ContractAdjustment,
      SettlementDate = @SettlementDate,
      Offer = @Offer,
      DeferredPaymentDate = @DeferredPaymentDate,
      LastContractTypeID = @LastContractTypeID,
      ContractTypeChangeDate = @ContractTypeChangeDate,
      OriginalContractNumber = @OriginalContractNumber,
      UpdatedBy = @UpdatedBy,
      UpdatedDateTime = getdate(),
	  HTAContract = @HTAContract,
      SubProducerName = @SubProducerName 
WHERE ContractID = @ContractID 

SELECT @New_RowVersion  = @_RowVersion + 1   

SELECT @ContractTypeName = CT.Name
FROM dbo.cft_CONTRACT_TYPE CT 
WHERE ContractTypeID = @ContractTypeID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_UPDATE] TO [db_sp_exec]
    AS [dbo];

