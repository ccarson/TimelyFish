
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaMoistureChargeDetail record by date,range and feed mill id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT_BY_DATE_AND_RANGE
(
    @Date	datetime,
    @Range	decimal(18,4),
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

IF EXISTS (SELECT 1 
           FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL MCD
           INNER JOIN dbo.cft_GPA_MOISTURE_CHARGE MC ON MC.GPAMoistureChargeID = MCD.GPAMoistureChargeID
           WHERE MC.Active = 1 
                 AND MC.[Default] = 0 
                 AND MC.FeedMillID = @FeedMillID
                 AND @Date BETWEEN MC.EffectiveDateFrom AND MC.EffectiveDateTo
                 AND @Range BETWEEN MCD.RangeFrom AND MCD.RangeTo
          )
BEGIN

  SELECT MCD.[GPAMoistureChargeDetailID],
         MCD.[GPAMoistureChargeID],
         MCD.[Increment],
         MCD.[RangeFrom],
         MCD.[RangeTo],
         MCD.[Value],
         MCD.[CreatedDateTime],
         MCD.[CreatedBy],
         MCD.[UpdatedDateTime],
         MCD.[UpdatedBy]
  FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL MCD
  INNER JOIN dbo.cft_GPA_MOISTURE_CHARGE MC ON MC.GPAMoistureChargeID = MCD.GPAMoistureChargeID
  WHERE MC.Active = 1 
        AND MC.[Default] = 0 
        AND MC.FeedMillID = @FeedMillID
        AND @Date BETWEEN MC.EffectiveDateFrom AND MC.EffectiveDateTo
        AND @Range BETWEEN MCD.RangeFrom AND MCD.RangeTo
  
END ELSE BEGIN

  SELECT MCD.[GPAMoistureChargeDetailID],
         MCD.[GPAMoistureChargeID],
         MCD.[Increment],
         MCD.[RangeFrom],
         MCD.[RangeTo],
         MCD.[Value],
         MCD.[CreatedDateTime],
         MCD.[CreatedBy],
         MCD.[UpdatedDateTime],
         MCD.[UpdatedBy]
  FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL MCD
  INNER JOIN dbo.cft_GPA_MOISTURE_CHARGE MC ON MC.GPAMoistureChargeID = MCD.GPAMoistureChargeID
  WHERE MC.Active = 1 
        AND MC.[Default] = 1 
        AND MC.FeedMillID = @FeedMillID
        AND @Date BETWEEN MC.EffectiveDateFrom AND ISNULL(MC.EffectiveDateTo, '2099/12/12')
        AND @Range BETWEEN MCD.RangeFrom AND MCD.RangeTo
  
END  

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

