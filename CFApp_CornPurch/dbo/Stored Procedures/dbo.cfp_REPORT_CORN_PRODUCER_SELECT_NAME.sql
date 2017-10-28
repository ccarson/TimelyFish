-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/14/2008
-- Description:	Returns CornProducer's name
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CORN_PRODUCER_SELECT_NAME]
(
   @CornProducerID	char(15)
)
AS
BEGIN
	SET NOCOUNT ON;

  SELECT V.RemitName AS CornProducerName 
  FROM [$(SolomonApp)].dbo.Vendor V 
  WHERE V.VendId = @CornProducerID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CORN_PRODUCER_SELECT_NAME] TO [db_sp_exec]
    AS [dbo];

