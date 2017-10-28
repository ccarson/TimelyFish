-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Returns all Corn Producers
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CORN_PRODUCER_SELECT]
(
   @IncludeAll	bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT '%' AS CornProducerID,
         '--All--' AS CornProducerName,
         0 AS OrderBy
       
  UNION ALL 

  SELECT CP.CornProducerID,
         V.RemitName AS CornProducerName,
         1
  FROM dbo.cft_CORN_PRODUCER CP
  INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
  ORDER BY 3,2

END ELSE BEGIN

  SELECT CP.CornProducerID,
         V.RemitName AS CornProducerName,
         1 AS OrderBy 
  FROM dbo.cft_CORN_PRODUCER CP
  INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
  ORDER BY 2

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CORN_PRODUCER_SELECT] TO [db_sp_exec]
    AS [dbo];

