

-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaMoistureCharge record by feed mill id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_SELECT_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT MC.[GPAMoistureChargeID],
       MC.[EffectiveDateFrom],
       MC.[EffectiveDateTo],
       MC.[Default],
       MC.[Active],
       MC.[CreatedDateTime],
       MC.[CreatedBy],
       MC.[UpdatedDateTime],
       MC.[UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_CHARGE MC
WHERE MC.Active = 1 
      AND MC.[Default] = 0 
      AND MC.FeedMillID = @FeedMillID
      AND @Date BETWEEN MC.EffectiveDateFrom AND MC.EffectiveDateTo

UNION ALL

SELECT MC.[GPAMoistureChargeID],
       MC.[EffectiveDateFrom],
       MC.[EffectiveDateTo],
       MC.[Default],
       MC.[Active],
       MC.[CreatedDateTime],
       MC.[CreatedBy],
       MC.[UpdatedDateTime],
       MC.[UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_CHARGE MC
WHERE
       MC.Active = 1 
       AND MC.[Default] = 1 
       AND MC.FeedMillID = @FeedMillID
       AND @Date BETWEEN MC.EffectiveDateFrom AND ISNULL(MC.EffectiveDateTo,'12/31/2050')


--ORDER BY MC.[Default] -- non-default rates should override default ones.

/*

SELECT MC.[GPAMoistureChargeID],
       MC.[EffectiveDateFrom],
       MC.[EffectiveDateTo],
       MC.[Default],
       MC.[Active],
       MC.[CreatedDateTime],
       MC.[CreatedBy],
       MC.[UpdatedDateTime],
       MC.[UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_CHARGE MC
LEFT OUTER JOIN dbo.cft_GPA_MOISTURE_CHARGE MC2 ON MC.GPAMoistureChargeID = MC2.GPAMoistureChargeID
                                               AND MC2.Active = 1 
                                               AND MC2.[Default] = 1 
                                               AND MC2.FeedMillID = @FeedMillID
                                               AND @Date BETWEEN MC2.EffectiveDateFrom AND ISNULL(MC2.EffectiveDateTo,'12/31/2050')
WHERE MC.Active = 1 
      AND MC.[Default] = 0 
      AND MC.FeedMillID = @FeedMillID
      AND @Date BETWEEN MC.EffectiveDateFrom AND MC.EffectiveDateTo

ORDER BY MC.[Default] -- non-default rates should override default ones.
*/
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_SELECT_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

