
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/16/2015
-- Description:	Calculates the moisture charge ID
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE]
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)    
)
RETURNS int
AS
BEGIN
    
DECLARE @GPAMoistureChargeID int

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

  SELECT @GPAMoistureChargeID = MCD.GPAMoistureChargeID
  FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL MCD
  INNER JOIN dbo.cft_GPA_MOISTURE_CHARGE MC ON MC.GPAMoistureChargeID = MCD.GPAMoistureChargeID
  WHERE MC.Active = 1 
        AND MC.[Default] = 0 
        AND MC.FeedMillID = @FeedMillID
        AND @Date BETWEEN MC.EffectiveDateFrom AND MC.EffectiveDateTo
        AND @Range BETWEEN MCD.RangeFrom AND MCD.RangeTo
  
END ELSE BEGIN

  SELECT @GPAMoistureChargeID = MCD.GPAMoistureChargeID
  FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL MCD
  INNER JOIN dbo.cft_GPA_MOISTURE_CHARGE MC ON MC.GPAMoistureChargeID = MCD.GPAMoistureChargeID
  WHERE MC.Active = 1 
        AND MC.[Default] = 1 
        AND MC.FeedMillID = @FeedMillID
        AND @Date BETWEEN MC.EffectiveDateFrom AND ISNULL(MC.EffectiveDateTo, '2099/12/12')
        AND @Range BETWEEN MCD.RangeFrom AND MCD.RangeTo
  
END  

RETURN @GPAMoistureChargeID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

