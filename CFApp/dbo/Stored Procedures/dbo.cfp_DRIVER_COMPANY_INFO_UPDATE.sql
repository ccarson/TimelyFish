
-- =============================================
-- Author:		Dave Killion
-- Create date: 11/8/2007
-- Description:	Updates the Driver Company Information table
-- for a specific Contact ID
-- 1/22/2016 DDahle - added Insert check
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_COMPANY_INFO_UPDATE] 
	-- Add the parameters for the stored procedure here
	@SelectedStatus int,
	@TruckCompanyComments varchar(500),
	@ContactID int
AS
BEGIN
IF (EXISTS (SELECT * FROM DBO.cft_DRIVER_COMPANY_INFO where ContactID = @ContactID))
Begin
UPDATE DBO.cft_DRIVER_COMPANY_INFO
   SET 
	SelectedStatus = @SelectedStatus,
    TruckCompanyComments = @TruckCompanyComments 
 WHERE 
	ContactID = @ContactID
END
ELSE
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_COMPANY_INFO_UPDATE] TO [db_sp_exec]
    AS [dbo];

