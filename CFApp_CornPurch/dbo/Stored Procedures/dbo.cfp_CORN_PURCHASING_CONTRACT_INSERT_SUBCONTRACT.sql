﻿
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 12/03/2008
-- Description:	Creates new subcontract record and returns it's ID and number.
-- ===================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-07-31  Doran Dahle Added SubProducerName,HTAContract to the insert.
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_INSERT_SUBCONTRACT]
(
	@ContractID					int		OUT,
	@FeedMillID					char(10),
	@CornProducerID				varchar(30),
	@ContractNumber				varchar(100)	OUT,
	@SequenceNumber				int,
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
	@OriginalContractNumber		varchar(50),
	@HTAContract				bit,
	@SubProducerName			varchar(30)
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
            AND SequenceNumber = @SequenceNumber 
            AND SubsequenceNumber IS NOT NULL)
BEGIN
  
  SET @ReturnValue = 2 --Priority is not unique


END ELSE BEGIN
  
  DECLARE @SubsequenceNumber int  
 
  SELECT @SubsequenceNumber = ISNULL(MAX(SubsequenceNumber), 0) + 1 
  FROM dbo.cft_CONTRACT 
  WHERE FeedMillID = @FeedMillID AND SequenceNumber = @SequenceNumber

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
      [OriginalContractNumber],
      [HTAContract],
      [SubProducerName]
  ) 
  VALUES 
  (
      @FeedMillID, 
      @CornProducerID, 
      @SequenceNumber, 
      @SubsequenceNumber,
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
      @OriginalContractNumber,
      @HTAContract,
      @SubProducerName 
  )

  SELECT @ContractID = C.ContractID, 
         @ContractNumber = C.ContractNumber,
         @_RowVersion = C._RowVersion,
         @ContractTypeName = CT.Name
  FROM dbo.cft_CONTRACT C
  INNER JOIN dbo.cft_CONTRACT_TYPE CT ON C.ContractTypeID = CT.ContractTypeID
  WHERE ContractID = SCOPE_IDENTITY() 
END
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_INSERT_SUBCONTRACT] TO [db_sp_exec]
    AS [dbo];

