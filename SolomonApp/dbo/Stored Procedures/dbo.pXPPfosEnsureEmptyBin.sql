--*************************************************************
--	Purpose:Check for Pfos Site record
--	Author: Doran Dahle
--	Date: 10/04/2012
--	Usage: Feed	Delivery, 		 
--	Parms: SiteContactID
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
Create PROC [dbo].[pXPPfosEnsureEmptyBin]
	@BinNbr varchar(10),
    @Call_DT datetime,
    @SDI_Nbr varchar(6),
    @PigGroupID int,
    @SiteContactID varchar(6)

AS

IF (EXISTS (SELECT * FROM dbo.cftPfosSafedata (NOLOCK) WHERE upper(SDI_Nbr) = @SDI_Nbr ))
begin
UPDATE [SolomonApp].[dbo].[cftPfosSafedata]
   SET [BinNbr] = @BinNbr
      ,[Crtd_DT] = getdate()
      ,[Call_DT] = @Call_DT
      ,[PigGroupID] = @PigGroupID
      ,[SiteContactID] = @SiteContactID
 WHERE [SDI_Nbr] = @SDI_Nbr
 end
else
begin
INSERT INTO [SolomonApp].[dbo].[cftPfosSafedata]
           ([BinNbr]
           ,[Crtd_DT]
           ,[Call_DT]
           ,[SDI_Nbr]
           ,[PigGroupID]
           ,[Statusflg]
           ,[SiteContactID])
     VALUES
           (@BinNbr
           ,getDate()
           ,@Call_DT
           ,@SDI_Nbr
           ,@PigGroupID
           ,'O'
           ,@SiteContactID )
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXPPfosEnsureEmptyBin] TO [SE\ssis_datawriter]
    AS [dbo];

