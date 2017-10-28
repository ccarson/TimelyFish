
-- =============================================
-- Author:		Dave Killion
-- Create date: 11/7/2007
-- Description:	Updates a record in cft_DRIVER_INFO
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_INFO_UPDATE] 
			@DriverID int
		   ,@ContactID INT
           ,@DriverOrigin VARCHAR(50)
           ,@DriverCodeID INT
           ,@TrailerNumber VARCHAR(50)
           ,@DriverName VARCHAR(50)
           ,@DriverStatusID INT
           ,@DriverBusinessPhoneNumber varchar(50)
           ,@DriverCellPhoneNumber varchar(50)
           ,@DriverEmail  varchar(50)
           ,@DriverComments varchar(250)
		   ,@TrailerID varchar(5)
AS
BEGIN
UPDATE dbo.cft_DRIVER_INFO
   SET 
	[ContactID] = @ContactID 
    ,[DriverOrigin] = @DriverOrigin 
    ,[DriverCodeID] = @DriverCodeID 
    ,[TrailerNumber] = @TrailerNumber 
    ,[DriverName] = @DriverName 
    ,[DriverStatusID] = @DriverStatusID 
    ,[DriverBusinessPhoneNumber] = @DriverBusinessPhoneNumber 
    ,[DriverCellPhoneNumber] = @DriverCellPhoneNumber 
    ,[DriverEmail] = @DriverEmail 
    ,[DriverComments] = @DriverComments 
	,[TrailerID] = @TrailerID 
 WHERE 
	DriverID = @DriverID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_INFO_UPDATE] TO [db_sp_exec]
    AS [dbo];

