
-- =============================================
-- Author:		Doran Dahle
-- Create date: 06/11/2015
-- Description:	Inserts a record into [$(CentralData)].permih
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_TQA_PERMIT_INSERT] 
			@ContactID INT
           ,@PermitNbr VARCHAR(50)
           
AS
BEGIN
INSERT INTO [$(CentralData)].[dbo].[Permit]
           ([PermitTypeID]
           ,[PermitNbr]
           ,[SiteContactID]
           ,[IssueDate]
           ,[ExpirationDate]
           ,[PermitLength]
           ,[PermitLengthUOM]
           ,[RenewalLeadDays]
           ,[Comment]
           ,[OriginalIssueDate])
     VALUES
           (35
           ,@PermitNbr
           ,@ContactID
           ,Getdate()
           ,DATEADD(year,3, getdate())
           ,3
           ,'Years'
           ,90
           ,'ADDED From CFAPP Transportation'
           ,Getdate())
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_TQA_PERMIT_INSERT] TO [db_sp_exec]
    AS [dbo];

