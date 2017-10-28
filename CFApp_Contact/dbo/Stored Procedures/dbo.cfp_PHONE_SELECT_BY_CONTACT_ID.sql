-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 04/22/2008
-- Description:	Returns all phones by contactID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PHONE_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cft_PHONE.PhoneID
		,cft_PHONE.PhoneNbr
		,cft_PHONE.Extension
		,cft_PHONE.SpeedDial
		,cft_CONTACT_PHONE.PhoneTypeID
		,cft_CONTACT_PHONE.PhoneCarrierID
		,cft_CONTACT_PHONE.Comment
		,cft_CONTACT_CELL_PHONE_PROVIDER.CarrierName
		,cft_CONTACT_CELL_PHONE_PROVIDER.CarrierTextMessageAddress
	FROM dbo.cft_PHONE cft_PHONE
		INNER JOIN dbo.cft_CONTACT_PHONE cft_CONTACT_PHONE ON cft_CONTACT_PHONE.PhoneID = cft_PHONE.PhoneID
		LEFT JOIN dbo.cft_CONTACT_CELL_PHONE_PROVIDER cft_CONTACT_CELL_PHONE_PROVIDER ON cft_CONTACT_CELL_PHONE_PROVIDER.CarrierID = cft_CONTACT_PHONE.PhoneCarrierID
	WHERE   (cft_CONTACT_PHONE.ContactID = @ContactID)
	ORDER BY cft_PHONE.PhoneNbr
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PHONE_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

