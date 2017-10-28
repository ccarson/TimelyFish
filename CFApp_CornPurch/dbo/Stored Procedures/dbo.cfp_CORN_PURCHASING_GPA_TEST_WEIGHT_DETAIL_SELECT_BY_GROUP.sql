
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaTestWeightDetail record by group id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_SELECT_BY_GROUP]
(
    @GPATestWeightID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPATestWeightDetailID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL
WHERE GPATestWeightID = @GPATestWeightID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_SELECT_BY_GROUP] TO [db_sp_exec]
    AS [dbo];

