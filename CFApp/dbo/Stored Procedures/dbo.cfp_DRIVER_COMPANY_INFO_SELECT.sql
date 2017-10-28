-- =============================================
-- Author:		Dave Killion
-- Create date: 11/8/2007
-- Description:	Selects a record from cft_Driver_Company_Info
-- =============================================
CREATE PROCEDURE dbo.cfp_DRIVER_COMPANY_INFO_SELECT
	-- Add the parameters for the stored procedure here
@CONTACTID INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	SelectedStatus
    ,TruckCompanyComments
FROM 
	dbo.cft_DRIVER_COMPANY_INFO (NOLOCK)
WHERE
	ContactID = @CONTACTID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_COMPANY_INFO_SELECT] TO [db_sp_exec]
    AS [dbo];

