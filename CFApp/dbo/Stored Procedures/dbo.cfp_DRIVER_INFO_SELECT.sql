-- =============================================
-- Author:		Dave Killion
-- Create date: 11/8/2007
-- Description:	Returns all records from cft_DRIVER_INFO that match the contactid
-- =============================================
CREATE PROCEDURE dbo.cfp_DRIVER_INFO_SELECT
	-- Add the parameters for the stored procedure here
	@ContactID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [DriverID]
      ,[DriverOrigin]
      ,[DriverCodeID]
      ,[TrailerNumber]
      ,[DriverName]
      ,[DriverStatusID]
      ,[DriverBusinessPhoneNumber]
      ,[DriverCellPhoneNumber]
      ,[DriverEmail]
	  ,[DriverComments]
      ,[TrailerID]
  FROM [cft_DRIVER_INFO] (NOLOCK)
where [ContactID] = @ContactID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_INFO_SELECT] TO [db_sp_exec]
    AS [dbo];

