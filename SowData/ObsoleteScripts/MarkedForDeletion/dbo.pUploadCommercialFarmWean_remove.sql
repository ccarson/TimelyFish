--*************************************************************
--	Purpose:Insert Commercial Farm Weans int EssbaseGeneticUploadTemp
--	Author: Charity Anderson
--	Date: 3/22/2006
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE PROC dbo.[pUploadCommercialFarmWean_remove]
	(@FarmID as varchar(10))
AS

If @FarmID='' 
	BEGIN
		SET NOCOUNT ON
		BEGIN TRANSACTION
			Insert into EssbaseGeneticUploadTemp
			([Week],FarmID,FarmSow,Genetics,Account,Value)
			Select 
			[Week],FarmID, FarmSow,Genetics, 'WeanQty',Qty
			from vCommercialFarmWean
	
			Insert into EssbaseGeneticUploadTemp
			([Week],FarmID,FarmSow,Genetics,Account,Value)
			Select w.[Week], w.FarmID, w.FarmSow, w.Genetics, LEFT(rtrim(e.Account),LEN(rtrim(e.Account))-6) + '_Wean', Value
			from vCommercialFarmWean w
			JOIN EssbaseGeneticUploadTemp e on w.FarmSow=e.FarmSow and e.Account not in ('Entry','WeanQty')
			and left(e.Account,2)<>'S_'
		COMMIT WORK
		SET NOCOUNT OFF
	END
ELSE
	BEGIN
		SET NOCOUNT ON
		BEGIN TRANSACTION
			Insert into EssbaseGeneticUploadTemp
			([Week],FarmID,FarmSow,Genetics,Account,Value)
			Select 
			[Week],FarmID, FarmSow,Genetics, 'WeanQty',Qty
			from vCommercialFarmWean where FarmID=@FarmID
			
			Insert into EssbaseGeneticUploadTemp
			([Week],FarmID,FarmSow,Genetics,Account,Value)
			Select w.[Week], w.FarmID, w.FarmSow,w.Genetics, LEFT(rtrim(e.Account),LEN(rtrim(e.Account))-6) + '_Wean',  Value
			from vCommercialFarmWean w
			JOIN EssbaseGeneticUploadTemp e on w.FarmSow=e.FarmSow and e.Account not in ('Entry','WeanQty')
			and left(e.Account,2)<>'S_' 
			where w.FarmID=@FarmID
		COMMIT WORK
		SET NOCOUNT OFF
	END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pUploadCommercialFarmWean_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pUploadCommercialFarmWean_remove] TO [se\analysts]
    AS [dbo];

