CREATE  PROC [dbo].[pEssbaseSolomonBinRTemp_remove]
	AS
	-- Clear the week definition temp table and the day definition temp table
	TRUNCATE TABLE cftBinReadingTemp
    


Begin Transaction
--Insert all Bin Reading Data Related to a Sow Farm
INSERT INTO dbo.cftBinReadingTemp (BinNbr,BinReadingDate,Crtd_Date,Crtd_DateTime,Crtd_Prog,
Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User,NoteID,SiteContactID,Tons)
Select bn.BinNbr,bn.BinReadingDate,bn.Crtd_Date,bn.Crtd_DateTime,bn.Crtd_Prog,
bn.Crtd_User,bn.Lupd_DateTime,bn.Lupd_Prog,bn.Lupd_User,bn.NoteID,bn.SiteContactID,bn.Tons
FROM [$(SolomonApp)].dbo.cftBinReading bn	-- remove the earth reference 20130905 smr part of the saturn retirement.
JOIN vSowFarmBin v ON bn.SiteContactID = v.ContactID AND bn.BinNbr=v.BinNbr
Commit

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pEssbaseSolomonBinRTemp_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pEssbaseSolomonBinRTemp_remove] TO [se\analysts]
    AS [dbo];

