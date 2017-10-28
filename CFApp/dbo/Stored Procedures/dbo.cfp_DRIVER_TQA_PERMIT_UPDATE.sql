

-- =============================================
-- Author:		Doran Dahle
-- Create date: 06/11/2015
-- Description:	Updates a record in [$(CentralData)].permit
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_TQA_PERMIT_UPDATE] 
			@PermitID int
           ,@PermitNbr VARCHAR(50)
AS
BEGIN
UPDATE [$(CentralData)].[dbo].[Permit]
   SET [PermitNbr] = @PermitNbr
 WHERE [PermitID] = @PermitID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_TQA_PERMIT_UPDATE] TO [db_sp_exec]
    AS [dbo];

