
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaTestWeightDetail record by date,range and feed mill id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_SELECT_BY_DATE_AND_RANGE
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL TWD
           INNER JOIN dbo.cft_GPA_TEST_WEIGHT TW ON TW.GPATestWeightID = TWD.GPATestWeightID
           WHERE TW.Active = 1 
                 AND TW.[Default] = 0 
                 AND TW.FeedMillID = @FeedMillID
                 AND @Date BETWEEN TW.EffectiveDateFrom AND TW.EffectiveDateTo
                 AND @Range BETWEEN TWD.RangeFrom AND TWD.RangeTo
          )
BEGIN

SELECT TWD.[GPATestWeightDetailID],
       TWD.[GPATestWeightID],
       TWD.[Increment],
       TWD.[RangeFrom],
       TWD.[RangeTo],
       TWD.[Value],
       TWD.[CreatedDateTime],
       TWD.[CreatedBy],
       TWD.[UpdatedDateTime],
       TWD.[UpdatedBy]
FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL TWD
INNER JOIN dbo.cft_GPA_TEST_WEIGHT TW ON TW.GPATestWeightID = TWD.GPATestWeightID
WHERE TW.Active = 1 
      AND TW.[Default] = 0 
      AND TW.FeedMillID = @FeedMillID
      AND @Date BETWEEN TW.EffectiveDateFrom AND TW.EffectiveDateTo
      AND @Range BETWEEN TWD.RangeFrom AND TWD.RangeTo

END ELSE BEGIN

SELECT TWD.[GPATestWeightDetailID],
       TWD.[GPATestWeightID],
       TWD.[Increment],
       TWD.[RangeFrom],
       TWD.[RangeTo],
       TWD.[Value],
       TWD.[CreatedDateTime],
       TWD.[CreatedBy],
       TWD.[UpdatedDateTime],
       TWD.[UpdatedBy]
FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL TWD
INNER JOIN dbo.cft_GPA_TEST_WEIGHT TW ON TW.GPATestWeightID = TWD.GPATestWeightID
WHERE TW.Active = 1 
      AND TW.[Default] = 1 
      AND TW.FeedMillID = @FeedMillID
      AND @Date BETWEEN TW.EffectiveDateFrom AND isnull(TW.EffectiveDateTo,'12/31/2050')
      AND @Range BETWEEN TWD.RangeFrom AND TWD.RangeTo

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

