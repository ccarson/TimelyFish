

--*************************************************************
--	Purpose:Check for Feed Outage Project
--	Author: Doran Dahle
--	Date: 03/03/2014
--	Usage: Safedata SSIS

--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
CREATE PROC [dbo].[pXPSafeDataEnsureFOData]
	@BarnNbr varchar(10),
    @Call_DT datetime,
    @SDI_Nbr varchar(6),
    @SiteContactID varchar(6),
    @Reason int,
    @Duration int

AS

IF (EXISTS (SELECT * FROM dbo.cftSafedataFO (NOLOCK) WHERE upper(SDI_Nbr) = @SDI_Nbr ))
begin
UPDATE [SolomonApp].[dbo].[cftSafedataFO]
   SET [BarnNbr] = @BarnNbr
      ,[Crtd_DT] = getdate()
      ,[Call_DT] = @Call_DT
      ,[Reason] = @Reason
      ,[Duration] = @Duration
 WHERE [SDI_Nbr] = @SDI_Nbr
 end
else
begin
INSERT INTO [SolomonApp].[dbo].[cftSafedataFO]
           ([BarnNbr]
           ,[Crtd_DT]
           ,[Call_DT]
           ,[SDI_Nbr]
           ,[Reason]
           ,[Duration]
           ,[SiteContactID])
     VALUES
           (@BarnNbr
           ,getDate()
           ,@Call_DT
           ,@SDI_Nbr
           ,@Reason
           ,@Duration
           ,@SiteContactID )
end



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXPSafeDataEnsureFOData] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXPSafeDataEnsureFOData] TO [MSDSL]
    AS [dbo];

