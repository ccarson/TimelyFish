-- =============================================
-- Author:		Dave Killion
-- Create date: 11/8/2007
-- Description:	Inserts a record into the Driver Company Information table
-- for a specific Contact ID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_COMPANY_INFO_INSERT] 
	-- Add the parameters for the stored procedure here
	@SelectedStatus int,
	@TruckCompanyComments varchar(500),
	@ContactID int
AS
BEGIN
INSERT INTO dbo.cft_DRIVER_COMPANY_INFO
	(ContactID
	,SelectedStatus
	,TruckCompanyComments)
VALUES
	(@ContactID
	,@SelectedStatus
        ,@TruckCompanyComments)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_COMPANY_INFO_INSERT] TO [db_sp_exec]
    AS [dbo];

