
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaTestWeightDetail record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_SELECT_BY_ID]
(
    @GPATestWeightDetailID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPATestWeightID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL
WHERE GPATestWeightDetailID = @GPATestWeightDetailID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

