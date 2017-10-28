
-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 05/21/2008
-- Description:	Returns all phones by contactID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PHONE_SELECT_BY_CONTACT_ID_CD]
(
	@ContactID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Phone.PhoneID
		,Phone.PhoneNbr
		,Phone.Extension
		,Phone.SpeedDial
		,ContactPhone.PhoneTypeID
		,ContactPhone.PhoneCarrierID
		,ContactPhone.Comment
		,CellPhoneProvider.CarrierName
		,CellPhoneProvider.CarrierTextMessageAddress
	FROM [$(CentralData)].dbo.Phone Phone
		INNER JOIN [$(CentralData)].dbo.ContactPhone ContactPhone ON ContactPhone.PhoneID = Phone.PhoneID
		LEFT JOIN [$(CentralData)].dbo.cft_CONTACT_CELL_PHONE_PROVIDER CellPhoneProvider ON CellPhoneProvider.CarrierID = ContactPhone.PhoneCarrierID
	WHERE   (ContactPhone.ContactID = @ContactID)
	ORDER BY Phone.PhoneNbr

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PHONE_SELECT_BY_CONTACT_ID_CD] TO [db_sp_exec]
    AS [dbo];

