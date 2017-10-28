-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/07/2008
-- Description:	Returns all FSA Offices
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FSA_OFFICE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT FsaOffice.FsaOfficeID
	    ,FsaOffice.ContactID
		,FsaOffice.Active
		,Vendor.RemitName BusinessName
		,Vendor.RemitAddr1 MailingAddress1
		,Vendor.RemitAddr2 MailingAddress2
		,Vendor.RemitCity MailingCity
		,Vendor.RemitState MailingState
		,Vendor.RemitZip MailingZip
		,Terms.Descr PaymentOption
FROM dbo.cft_FSA_OFFICE FsaOffice
	INNER JOIN [$(SolomonApp)].dbo.Vendor Vendor ON Vendor.VendId = FsaOffice.FsaOfficeID
	LEFT JOIN [$(SolomonApp)].dbo.Terms Terms ON Terms.TermsId = Vendor.Terms
Order By Vendor.RemitName, Vendor.RemitState, Vendor.RemitCity
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_SELECT] TO [db_sp_exec]
    AS [dbo];

