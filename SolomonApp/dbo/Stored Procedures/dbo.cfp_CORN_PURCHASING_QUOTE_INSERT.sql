
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/13/2008
-- Description:	Creates new Quote record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_QUOTE_INSERT
(
    @QuoteID			int	OUT,
    @CornProducerID		varchar(15),
    @Price			money,
    @Active			bit,
    @NumberOfLoads		int,
    @EffectiveDate		datetime,
    @EffectiveDateTo		datetime,
    @Futures			decimal(18,4),
    @Basis			decimal(18,4),
    @CreatedBy			varchar(50),
    @CornProducerBusinessName	varchar(30)	OUT
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_QUOTE
  (
      [CornProducerID],
      [Price],
      [Active],
      [NumberOfLoads],
      [EffectiveDate],
      [EffectiveDateTo],
      [Futures],
      [Basis],
      [CreatedBy]
  )
  VALUES
  (
      @CornProducerID,
      @Price,
      @Active,
      @NumberOfLoads,
      @EffectiveDate,
      @EffectiveDateTo,
      @Futures,
      @Basis,
      @CreatedBy
  )

  SELECT @QuoteID = QuoteID,
         @CornProducerBusinessName = V.RemitName
  FROM dbo.cft_QUOTE Q
  INNER JOIN SolomonApp.dbo.Vendor V ON V.VendID = Q.CornProducerID
  WHERE Q.QuoteID = SCOPE_IDENTITY()

END
