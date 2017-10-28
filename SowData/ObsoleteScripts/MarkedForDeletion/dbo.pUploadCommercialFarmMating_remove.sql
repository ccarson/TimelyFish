--*************************************************************
--	Purpose:Insert Commercial Farm Weans int EssbaseGeneticUploadTemp
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE PROC dbo.[pUploadCommercialFarmMating_remove]
			(@FarmID as varchar(10))
AS
IF @FarmID='' 
	BEGIN
		Insert into EssbaseGeneticUploadTemp
		([Week],FarmID,FarmSow,Genetics,Account,Value)
		Select 
		[Week],FarmID, FarmSow,Genetics, 'S_' + Account,1
		from vCommercialFarmMating
	END 
ELSE
	BEGIN
		Insert into EssbaseGeneticUploadTemp
		([Week],FarmID,FarmSow,Genetics,Account,Value)
		Select 
		[Week],FarmID, FarmSow,Genetics, 'S_' + Account,1
		from vCommercialFarmMating where FarmID=@FarmID
	END 

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pUploadCommercialFarmMating_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pUploadCommercialFarmMating_remove] TO [se\analysts]
    AS [dbo];

