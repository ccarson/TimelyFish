-- =============================================
-- Author:		Matt Dawson
-- Create date: 09/16/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_FUTURE_CONTRACTS]
	@CornProducerID VARCHAR(15)
AS
BEGIN

	SELECT
		cft_Contract.CornProducerID
	,	Vendor.Name 'CornProducer'
	,	cft_Contract.ContractNumber
	,	cft_Contract_Type.Name 'ContractType'
	,	CONVERT(VARCHAR, cft_Contract.DateEstablished, 101) 'DateEstablished'
	,	CONVERT(VARCHAR, cft_Contract.DueDateFrom, 101) 'DueDateFrom'
	,	CONVERT(VARCHAR, cft_Contract.DueDateTo, 101) 'DueDateTo'
	,	cft_Contract.Bushels
	,	cft_Feed_Mill.Name 'FeedMillName'
	FROM		dbo.cft_Contract cft_Contract (NOLOCK)
	LEFT OUTER JOIN dbo.cft_Contract_Type cft_Contract_Type (NOLOCK)
		ON	cft_Contract_Type.ContractTypeID = cft_Contract.ContractTypeID
	LEFT OUTER JOIN dbo.cft_Corn_Producer cft_Corn_Producer (NOLOCK)
		ON	RTRIM(cft_Corn_Producer.CornProducerID) = RTRIM(cft_Contract.CornProducerID)
	LEFT OUTER JOIN dbo.cft_Vendor Vendor (NOLOCK)
		ON	RTRIM(Vendor.VendID) = RTRIM(cft_Corn_Producer.CornProducerID)
	LEFT OUTER JOIN dbo.cft_Feed_Mill cft_Feed_Mill (NOLOCK)
		ON	cft_Feed_Mill.FeedMillID = cft_Contract.FeedMillID
	WHERE
		(cft_Contract.DueDateFrom >= GETDATE() OR cft_Contract.DateEstablished >= GETDATE())
		AND RTRIM(cft_Contract.CornProducerID) = RTRIM(@CornProducerID)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASE_SETTLEMENT_FUTURE_CONTRACTS] TO [db_sp_exec]
    AS [dbo];

