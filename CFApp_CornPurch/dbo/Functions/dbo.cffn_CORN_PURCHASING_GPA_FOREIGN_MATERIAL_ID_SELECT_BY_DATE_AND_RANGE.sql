
-- ========================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/04/2015
-- Description:	Selects GpaForeignMaterialID by date,range and feed mill ID
-- ========================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_ID_SELECT_BY_DATE_AND_RANGE]
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)
)
RETURNS int
BEGIN

DECLARE @GPAForeignMaterialID int

IF EXISTS ( SELECT 1
            FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL FMD
            INNER JOIN dbo.cft_GPA_FOREIGN_MATERIAL FM ON FM.GPAForeignMaterialID = FMD.GPAForeignMaterialID
            WHERE FM.Active = 1 
                  AND FM.[Default] = 0 
                  AND FM.FeedMillID = @FeedMillID
                  AND @Date BETWEEN FM.EffectiveDateFrom AND FM.EffectiveDateTo
                  AND @Range BETWEEN FMD.RangeFrom AND FMD.RangeTo
          )

BEGIN

SELECT @GPAForeignMaterialID = FMD.[GPAForeignMaterialID]
FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL FMD
INNER JOIN dbo.cft_GPA_FOREIGN_MATERIAL FM ON FM.GPAForeignMaterialID = FMD.GPAForeignMaterialID
WHERE FM.Active = 1 
      AND FM.[Default] = 0 
      AND FM.FeedMillID = @FeedMillID
      AND @Date BETWEEN FM.EffectiveDateFrom AND FM.EffectiveDateTo
      AND @Range BETWEEN FMD.RangeFrom AND FMD.RangeTo


END ELSE BEGIN

SELECT @GPAForeignMaterialID = FMD.[GPAForeignMaterialID]
FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL FMD
INNER JOIN dbo.cft_GPA_FOREIGN_MATERIAL FM ON FM.GPAForeignMaterialID = FMD.GPAForeignMaterialID
WHERE FM.Active = 1 
      AND FM.[Default] = 1 
      AND FM.FeedMillID = @FeedMillID
      AND @Date BETWEEN FM.EffectiveDateFrom AND ISNULL(FM.EffectiveDateTo, '2099/12/12')
      AND @Range BETWEEN FMD.RangeFrom AND FMD.RangeTo

END

RETURN @GPAForeignMaterialID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_ID_SELECT_BY_DATE_AND_RANGE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_ID_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

