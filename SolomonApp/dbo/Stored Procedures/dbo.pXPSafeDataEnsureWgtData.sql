


--*************************************************************
--	Purpose:Check for Load Wgt
--	Author: Doran Dahle
--	Date: 08/26/2014
--	Usage: Safedata SSIS

--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
CREATE PROC [dbo].[pXPSafeDataEnsureWgtData]
	@SDI_Nbr varchar(6),
    @Call_DT datetime,
    @PMLOADID varchar(10),
	@Phone varchar(30),
    @GrossWgt int,
    @TareWgt int

AS

IF (EXISTS (SELECT * FROM dbo.cftSafeLoadWgt (NOLOCK) WHERE  PMLoadID = @PMLOADID))
begin
 UPDATE [SolomonApp].[dbo].[cftSafeLoadWgt]
   SET [Call_DateTime] = @Call_DT
      ,[GrossWgt] = @GrossWgt
      ,[Lupd_DateTime] = getDate()
      ,[Lupd_Prog] = 'SSIS'
      ,[Lupd_User] = 'SSIS'
      ,[SDI_Nbr] = @SDI_Nbr
      ,[Statusflg] = 'O'
      ,[TareWgt] = @TareWgt
      ,[Trucker] = @Phone
 WHERE [PMLoadID] = @PMLOADID
 
 
 
 end
else
begin
INSERT INTO [dbo].[cftSafeLoadWgt]
           ([Call_DateTime]
           ,[Crtd_DateTime]
           ,[Crtd_Prog]
           ,[Crtd_User]
           ,[GrossWgt]
           ,[PMLoadID]
           ,[SDI_Nbr]
           ,[Statusflg]
           ,[TareWgt]
           ,[Trucker])
     VALUES
           (@Call_DT
           ,getDate()
           ,'SSIS'
           ,'SSIS'
           ,@GrossWgt
           ,@PMLOADID
           ,@SDI_Nbr
           ,'O'
           ,@TareWgt
           ,@Phone)
end




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXPSafeDataEnsureWgtData] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXPSafeDataEnsureWgtData] TO [MSDSL]
    AS [dbo];

