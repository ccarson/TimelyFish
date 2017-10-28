-- =======================================================
-- Author:		Brian Cesafsky
-- Create date: 04/16/2008
-- Description:	Returns corn producers by search criteria
-- =======================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_SELECT_BY_SEARCH_CRITERIA]
(
	@ID					varchar(15),
	@BusinessName		varchar(30),
	@Phone				varchar(30),
	@StreetAdress1		varchar(30),
	@StreetAdress2		varchar(30),
	@City				varchar(30),
	@State				varchar(2),
	@ZipCode			varchar(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Vendor.VendId CornProducerID
		,Vendor.RemitName BusinessName
		,Vendor.RemitPhone Phone
		,Vendor.RemitAddr1 MailingAddress1
		,Vendor.RemitAddr2 MailingAddress2
		,Vendor.RemitCity MailingCity
		,Vendor.RemitState MailingState
		,Vendor.RemitZip MailingZip
		,Terms.Descr PaymentOption
	FROM [$(SolomonApp)].dbo.Vendor Vendor (NOLOCK)
		LEFT JOIN [$(SolomonApp)].dbo.Terms Terms ON Terms.TermsId = Vendor.Terms
	WHERE NOT EXISTS
		(SELECT * FROM dbo.cft_CORN_PRODUCER cft_CORN_PRODUCER (NOLOCK) WHERE cft_CORN_PRODUCER.CornProducerID = Vendor.VendID)
              AND Vendor.VendID <> 'AAAAAA'
	AND Vendor.VendId like @ID	
	AND Vendor.RemitName like @BusinessName
	AND Vendor.RemitPhone like @Phone
	AND Vendor.RemitAddr1 like @StreetAdress1
	AND Vendor.RemitAddr2 like @StreetAdress2
	AND Vendor.RemitCity like @City
	AND Vendor.RemitState like @State
	AND Vendor.RemitZip like @ZipCode
Order By Vendor.RemitName, Vendor.RemitState, Vendor.RemitCity
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_SELECT_BY_SEARCH_CRITERIA] TO [db_sp_exec]
    AS [dbo];

