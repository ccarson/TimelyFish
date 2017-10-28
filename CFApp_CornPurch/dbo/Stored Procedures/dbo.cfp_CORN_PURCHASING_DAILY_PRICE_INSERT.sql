
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/04/2008
-- Description:	Creates new DailyPrice record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_INSERT]
(
    @DailyPriceID	int	OUT,
    @Date	datetime,
    @FeedMillID	char(10),
    @Approved	bit,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_DAILY_PRICE
  (
      [Date],
      [FeedMillID],
      [Approved],
      [CreatedBy]
  )
  VALUES
  (
      @Date,
      @FeedMillID,
      @Approved,
      @CreatedBy
  )

  SELECT @DailyPriceID = DailyPriceID
  FROM dbo.cft_DAILY_PRICE
  WHERE DailyPriceID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_INSERT] TO [db_sp_exec]
    AS [dbo];

