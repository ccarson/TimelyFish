
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/13/2008
-- Description:	Updates the Quote record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_QUOTE_UPDATE
(
    @QuoteID			int,
    @CornProducerID		varchar(15),
    @Price			money,
    @Active			bit,
    @NumberOfLoads		int,
    @EffectiveDate		datetime,
    @EffectiveDateTo		datetime,
    @Futures			decimal(18,4),
    @Basis			decimal(18,4),
    @UpdatedBy			varchar(50),
    @CornProducerBusinessName	varchar(30)	OUT,
    @Result			int		OUT,
    @FeedMillID			char(10)
)
AS
BEGIN
  SET NOCOUNT ON
  SET @Result = 0

  --A quote can NOT be marked inactive if tickets are applied to the quote and have not been paid.
  
  DECLARE @IsActive bit
  --if target quote is active and we try to make it inactive, check if there are unpaid ticket applied to it.
  IF ISNULL(@Active, 0) = 0 BEGIN

    SELECT @IsActive = Active
    FROM dbo.cft_QUOTE 
    WHERE QuoteID = @QuoteID

    IF @IsActive = 1 BEGIN

      IF EXISTS (SELECT 1 
                 FROM dbo.cft_PARTIAL_TICKET 
                 WHERE QuoteID = @QuoteID AND ISNULL(SentToAccountsPayable, 0) = 0) BEGIN

      SET @Result = 4 --business rule failed 
      RETURN

      END

    END
  
  END  

  UPDATE dbo.cft_QUOTE SET
    CornProducerID = @CornProducerID,
    Price = @Price,
    Active = @Active,
    NumberOfLoads = @NumberOfLoads,
    EffectiveDate = @EffectiveDate,
    EffectiveDateTo = @EffectiveDateTo,
    Futures = @Futures,
    Basis = @Basis,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate(),
    FeedMillID = @FeedMillID
  WHERE QuoteID = @QuoteID

  SELECT @CornProducerBusinessName = V.RemitName
  FROM dbo.cft_QUOTE Q
  INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendID = Q.CornProducerID
  WHERE Q.QuoteID = @QuoteID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_QUOTE_UPDATE] TO [db_sp_exec]
    AS [dbo];

