
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 07/21/2008
-- Description:	Selects data for voided tickets report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_VOIDED_TICKETS_REPORT_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT 
	CT.TicketNumber,
	PT.CornProducerID,
	V.RemitName AS CornProducerName,
	PT.ContractID,
	PT.DeliveryDate,
	GL_TYPE.Name,
	0 AS Amount,
	0 AS SolomonBatchNumber,
	'GL' AS SolomonBatchType
       
FROM cft_GL_TYPE GL_TYPE, cft_CORN_TICKET CT
	INNER JOIN dbo.cft_PARTIAL_TICKET PT ON CT.TicketID = PT.FullTicketID
	INNER JOIN [$(SolomonApp)].dbo.Vendor V ON PT.CornProducerID = V.VendID
	WHERE CT.TicketStatusID = 2

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_VOIDED_TICKETS_REPORT_SELECT] TO [db_sp_exec]
    AS [dbo];

