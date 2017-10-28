-- ===============================================================
-- Author:		Sergey Neskin
-- Create date: 09/01/2008
-- ===============================================================
CREATE PROCEDURE dbo.cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_SELECT
(
     @CornProducerID		varchar(15)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT  CP.FsaOfficeCornProducerID, 
		CP.FsaOfficeID,
		CP.CornProducerID,
		C.ContactName AS FsaOfficeName,
		CP.FsaPaymentAmount,
		CP.FsaLoanNumber,
		CP.CreatedDateTime,
		CP.CreatedBy,
		CP.UpdatedDateTime,
		CP.UpdatedBy
FROM  dbo.cft_FSA_OFFICE_CORN_PRODUCER CP
	LEFT OUTER JOIN dbo.cft_FSA_OFFICE FO ON FO.FsaOfficeID = CP.FsaOfficeID
	LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_CONTACT C ON C.ContactID = FO.ContactID
WHERE CornProducerID = @CornProducerID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_CORN_PRODUCER_RECORD_SELECT] TO [db_sp_exec]
    AS [dbo];

