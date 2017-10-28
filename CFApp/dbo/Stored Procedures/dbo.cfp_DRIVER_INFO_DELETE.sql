
-- =============================================
-- Author:		Dave Killion
-- Create date: 11/7/2007
-- Description:	Deletes a record from cft_DRIVER_INFO
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_INFO_DELETE] 
			@DriverID int
 AS
BEGIN
DELETE dbo.cft_DRIVER_INFO
WHERE 
	DriverID = @DriverID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_INFO_DELETE] TO [db_sp_exec]
    AS [dbo];

