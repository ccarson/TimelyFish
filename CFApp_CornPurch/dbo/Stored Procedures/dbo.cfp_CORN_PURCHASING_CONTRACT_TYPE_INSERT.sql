
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/03/2008
-- Description:	Inserts a contract type record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CONTRACT_TYPE_INSERT
(
    @ContractTypeID		int	OUT,
    @Name			varchar(50),
    @ContractTypeStatusID	int,
    @Template			image,
    @TemplateFields		varchar(2000),
    @TemplateFileName		varchar(256),
    @PriceLater			bit,
    @DeferredPayment		bit,
    @CRM			bit,
    @CreatedBy			varchar(50),
    @FeedMIllIDs		varchar(4000)
)
AS
BEGIN
SET NOCOUNT ON;

BEGIN TRAN

INSERT dbo.cft_CONTRACT_TYPE
(
    Name,
    ContractTypeStatusID,
    Template,
    TemplateFields,
    TemplateFileName,
    PriceLater,
    DeferredPayment,
    CRM,
    CreatedBy 
)
VALUES
(
    @Name,
    @ContractTypeStatusID,
    @Template,
    @TemplateFields,
    @TemplateFileName,
    @PriceLater,
    @DeferredPayment,
    @CRM,
    @CreatedBy
)

SET @ContractTypeID = SCOPE_IDENTITY()

INSERT dbo.cft_CONTRACT_TYPE_FEED_MILL
(
   ContractTypeID,
   FeedMillID,
   CreatedBy
)
SELECT @ContractTypeID,
       Value,
       @CreatedBy
FROM dbo.cffn_SPLIT_STRING(@FeedMillIDs,',')


IF @PriceLater = 1 BEGIN

  UPDATE dbo.cft_CONTRACT_TYPE
  SET PriceLater = 0
  FROM dbo.cft_CONTRACT_TYPE CT
  INNER JOIN dbo.cft_CONTRACT_TYPE_FEED_MILL CTFM ON CT.ContractTypeID = CTFM.ContractTypeID 
  INNER JOIN dbo.cffn_SPLIT_STRING(@FeedMillIDs,',') FM ON CTFM.FeedMillID = FM.Value
  WHERE CT.ContractTypeID <> @ContractTypeID

END

COMMIT TRAN

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_INSERT] TO [db_sp_exec]
    AS [dbo];

