-- =============================================
-- Author:		Andrew Derco
-- Create date: 06/11/2008
-- Description:	Returns all corn producers including unknown one
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_SELECT_WITH_UNKNOWN]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CornProducer.CornProducerID
       ,CornProducer.Active
       ,Vendor.RemitName BusinessName
       ,Vendor.RemitState
       ,Vendor.RemitCity
FROM dbo.cft_CORN_PRODUCER CornProducer
	INNER JOIN [$(SolomonApp)].dbo.Vendor Vendor ON Vendor.VendId = CornProducer.CornProducerID

UNION ALL

SELECT Vendor.VendId
       ,1
       ,Vendor.RemitName BusinessName
       ,Vendor.RemitState
       ,Vendor.RemitCity
FROM [$(SolomonApp)].dbo.Vendor Vendor 
WHERE VendId = 'AAAAAA'
    

ORDER BY Vendor.RemitName, Vendor.RemitState, Vendor.RemitCity
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_SELECT_WITH_UNKNOWN] TO [db_sp_exec]
    AS [dbo];

