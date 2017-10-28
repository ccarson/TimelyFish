
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Selects all ElevatorSaleBasis records for Feed Mill
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_SELECT_BY_FEED_MILL
(
    @FeedMillID 	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT ElevatorSaleBasisID,
       [Date],
       [Amount]
FROM dbo.cft_ELEVATOR_SALE_BASIS
WHERE FeedMillID = @FeedMillID
ORDER BY Date DESC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

