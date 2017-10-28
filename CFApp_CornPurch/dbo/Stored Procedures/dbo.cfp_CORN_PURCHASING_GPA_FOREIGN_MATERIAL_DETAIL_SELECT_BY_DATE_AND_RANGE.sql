
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaForeignMaterialDetail record by date,range and feed mill id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_SELECT_BY_DATE_AND_RANGE
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;


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

SELECT FMD.[GPAForeignMaterialDetailID],
       FMD.[GPAForeignMaterialID],
       FMD.[Increment],
       FMD.[RangeFrom],
       FMD.[RangeTo],
       FMD.[Value],
       FMD.[CreatedDateTime],
       FMD.[CreatedBy],
       FMD.[UpdatedDateTime],
       FMD.[UpdatedBy]
FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL FMD
INNER JOIN dbo.cft_GPA_FOREIGN_MATERIAL FM ON FM.GPAForeignMaterialID = FMD.GPAForeignMaterialID
WHERE FM.Active = 1 
      AND FM.[Default] = 0 
      AND FM.FeedMillID = @FeedMillID
      AND @Date BETWEEN FM.EffectiveDateFrom AND FM.EffectiveDateTo
      AND @Range BETWEEN FMD.RangeFrom AND FMD.RangeTo


END ELSE BEGIN

SELECT FMD.[GPAForeignMaterialDetailID],
       FMD.[GPAForeignMaterialID],
       FMD.[Increment],
       FMD.[RangeFrom],
       FMD.[RangeTo],
       FMD.[Value],
       FMD.[CreatedDateTime],
       FMD.[CreatedBy],
       FMD.[UpdatedDateTime],
       FMD.[UpdatedBy]
FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL FMD
INNER JOIN dbo.cft_GPA_FOREIGN_MATERIAL FM ON FM.GPAForeignMaterialID = FMD.GPAForeignMaterialID
WHERE FM.Active = 1 
      AND FM.[Default] = 1 
      AND FM.FeedMillID = @FeedMillID
      AND @Date BETWEEN FM.EffectiveDateFrom AND ISNULL(FM.EffectiveDateTo, '2099/12/12')
      AND @Range BETWEEN FMD.RangeFrom AND FMD.RangeTo

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

