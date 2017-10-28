
-- =============================================
-- Author:	Andrey Derco
-- Create date: 09/18/2008
-- Description:	Returns all corn producers
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_SELECT_ACTIVE_FOR_COMBOBOX]
AS
BEGIN
  
SET NOCOUNT ON; 

SELECT CP.CornProducerID,
       V.RemitName BusinessName
FROM dbo.cft_CORN_PRODUCER CP (nolock)
INNER JOIN [$(SolomonApp)].dbo.Vendor V (nolock) ON V.VendId = CP.CornProducerID
WHERE CP.Active = 1
ORDER BY V.RemitName, V.RemitState, V.RemitCity

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_SELECT_ACTIVE_FOR_COMBOBOX] TO [db_sp_exec]
    AS [dbo];

