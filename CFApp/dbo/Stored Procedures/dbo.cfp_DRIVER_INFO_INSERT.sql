-- =============================================
-- Author:		Dave Killion
-- Create date: 11/7/2007
-- Description:	Inserts a record into cft_DRIVER_INFO
-- =============================================
CREATE PROCEDURE dbo.cfp_DRIVER_INFO_INSERT 
			@ContactID INT
           ,@DriverOrigin VARCHAR(50)
           ,@DriverCodeID INT
           ,@TrailerNumber VARCHAR(50)
           ,@DriverName VARCHAR(50)
           ,@DriverStatusID INT
           ,@DriverBusinessPhoneNumber varchar(50)
           ,@DriverCellPhoneNumber varchar(50)
           ,@DriverEmail  varchar(50)
           ,@DriverComments varchar(250)
           ,@TrailerID  varchar(5)
AS
BEGIN
INSERT INTO [cft_DRIVER_INFO]
           ([ContactID]
           ,[DriverOrigin]
           ,[DriverCodeID]
           ,[TrailerNumber]
           ,[DriverName]
           ,[DriverStatusID]
           ,[DriverBusinessPhoneNumber]
           ,[DriverCellPhoneNumber]
           ,[DriverEmail]
           ,[DriverComments]
		   ,[TrailerID])
     VALUES
           (@ContactID 
           ,@DriverOrigin 
           ,@DriverCodeID 
           ,@TrailerNumber 
           ,@DriverName 
           ,@DriverStatusID 
           ,@DriverBusinessPhoneNumber 
           ,@DriverCellPhoneNumber 
           ,@DriverEmail 
           ,@DriverComments
		   ,@TrailerID)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_INFO_INSERT] TO [db_sp_exec]
    AS [dbo];

