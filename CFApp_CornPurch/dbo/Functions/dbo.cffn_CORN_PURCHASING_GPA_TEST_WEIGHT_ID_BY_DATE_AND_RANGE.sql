
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/02/2015
-- Description:	Returns GpaTestWeightID by date,range and feed mill id
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_TEST_WEIGHT_ID_BY_DATE_AND_RANGE]
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)
)
RETURNS int
AS
BEGIN

DECLARE @GPATestWeightID int

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

SELECT @GPATestWeightID = TWD.[GPATestWeightID]
FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL TWD
INNER JOIN dbo.cft_GPA_TEST_WEIGHT TW ON TW.GPATestWeightID = TWD.GPATestWeightID
WHERE TW.Active = 1 
      AND TW.[Default] = 0 
      AND TW.FeedMillID = @FeedMillID
      AND @Date BETWEEN TW.EffectiveDateFrom AND TW.EffectiveDateTo
      AND @Range BETWEEN TWD.RangeFrom AND TWD.RangeTo

END ELSE BEGIN

SELECT @GPATestWeightID = TWD.[GPATestWeightID]
FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL TWD
INNER JOIN dbo.cft_GPA_TEST_WEIGHT TW ON TW.GPATestWeightID = TWD.GPATestWeightID
WHERE TW.Active = 1 
      AND TW.[Default] = 1 
      AND TW.FeedMillID = @FeedMillID
      AND @Date BETWEEN TW.EffectiveDateFrom AND isnull(TW.EffectiveDateTo,'12/31/2050')
      AND @Range BETWEEN TWD.RangeFrom AND TWD.RangeTo

END

RETURN @GPATestWeightID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_TEST_WEIGHT_ID_BY_DATE_AND_RANGE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_TEST_WEIGHT_ID_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

