
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Creates new ElevatorSaleBasis record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_INSERT
(
    @ElevatorSaleBasisID	int	OUT,
    @Date			datetime,
    @FeedMillID			varchar(10),
    @Amount			decimal(10,4),
    @CreatedBy			varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_ELEVATOR_SALE_BASIS
  (
      [Date],
      [FeedMillID],
      [Amount],
      [CreatedBy]
  )
  VALUES
  (
      @Date,
      @FeedMillID,
      @Amount,
      @CreatedBy
  )

  SET @ElevatorSaleBasisID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_INSERT] TO [db_sp_exec]
    AS [dbo];

