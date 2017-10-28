



create PROC [dbo].[pEssbaseSolomonTemp]
	AS
	-- Clear the week definition temp table and the day definition temp table
	TRUNCATE TABLE cftBinReadingTemp
    TRUNCATE TABLE cftPMTranspRecordTemp
    TRUNCATE TABLE PreSolomonSowFeed
    TRUNCATE TABLE cftPMGradeQtyTemp
    TRUNCATE TABLE cftContactTemp
    TRUNCATE TABLE cftBinTemp
    TRUNCATE TABLE cftBarnTemp
    -- Where is this used cftPM
    --vWeanPigScheduleDetail SourceContactId, MovementDate, EstimatedQty
    TRUNCATE TABLE cftPMTemp
 





Begin Transaction
--Insert all transport records for the date range user selected
INSERT INTO dbo.cftPMTranspRecordTemp (BatchNbr,DestFarmQty,DocType,MovementDate,OrigRefNbr,PigTypeID,
RecountQty,Recountrequired,RefNbr,SourceContactID,SourceFarmQty)
Select tr.BatchNbr,tr.DestFarmQty,tr.DocType,tr.MovementDate,tr.OrigRefNbr,tr.PigTypeID,
tr.RecountQty,tr.Recountrequired,tr.RefNbr,tr.SourceContactID,tr.SourceFarmQty
From [$(SolomonApp)].dbo.cftPMTranspRecord tr
JOIN [$(SolomonApp)].dbo.cftDayDefinition dd ON dd.DayDate = tr.MovementDate
JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate
--Do not pull reversals
LEFT JOIN [$(SolomonApp)].dbo.cftPMTranspRecord re on tr.RefNbr=re.OrigRefNbr
Where re.RefNbr IS NULL -- Filters out reversals
Commit

--Drop and Recreate Index
Drop INDEX cftPMTranspRecordTemp.cftPMTranspRecordTempEss

CREATE CLUSTERED INDEX cftPMTranspRecordTempEss
ON cftPMTranspRecordTemp (SourceContactID,MovementDate)



--Insert all Grade qty for the date range selected
Begin Transaction
INSERT INTO dbo.cftPMGradeQtyTemp(BatchNbr,Crtd_DateTime,Crtd_Prog,Crtd_User,
LineNbr,Lupd_Date,Lupd_Prog,Lupd_User,NoteID,PigGradeCatTypeID,PigGradeSubCatTypeID,Qty,RefNbr)
Select gq.BatchNbr,gq.Crtd_DateTime,gq.Crtd_Prog,gq.Crtd_User,
gq.LineNbr,gq.Lupd_Date,gq.Lupd_Prog,gq.Lupd_User,gq.NoteID,gq.PigGradeCatTypeID,gq.PigGradeSubCatTypeID,
gq.Qty,gq.RefNbr
From [$(SolomonApp)].dbo.cftPMGradeQty gq
JOIN [$(SolomonApp)].dbo.cftPMTranspRecord tr ON gq.BatchNbr = tr.BatchNbr AND gq.RefNbr = tr.RefNbr
JOIN [$(SolomonApp)].dbo.cftDayDefinition dd ON dd.DayDate = tr.MovementDate
JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate

Commit

--Drop and Recreate Index
Drop INDEX cftPMGradeQtyTemp.cftPMGradeQtyTempEss

CREATE CLUSTERED INDEX cftPMGradeQtyTempEss
ON cftPMGradeQtyTemp (PigGradeCatTypeID)


--This data does not change, it was a mass import, copy the table to verify nothing changed in SolomonApp
Begin Transaction
INSERT INTO dbo.PreSolomonSowFeed (ContactID,DelDate,InvtIdDel,OrdNbr,QtyDel,Reversal)
Select ContactID,DelDate,InvtIdDel,OrdNbr,QtyDel,Reversal
From [$(SolomonApp)].dbo.PreSolomonSowFeed
Commit



Begin Transaction
INSERT INTO dbo.cftPMTemp (EstimatedQty, MovementDate, PigTypeID, SourceContactID)
Select EstimatedQty, MovementDate, PigTypeID, SourceContactID
From [$(SolomonApp)].dbo.cftPM pm
JOIN [$(SolomonApp)].dbo.cftDayDefinition dd ON dd.DayDate = pm.MovementDate
--JOIN careglobal.farms fs ON fs.FarmID = dbo.GetSowFarmIDFromContactID(pm.SourceContactID,pm.MovementDate)  -- do we need this??
JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate  
Commit

--Drop and Recreate Index
Drop INDEX cftPMTemp.cftPMTempEss

CREATE CLUSTERED INDEX cftPMTempEss
ON cftPMTemp (MovementDate,SourceContactId)




Begin Transaction
INSERT INTO dbo.cftContactTemp (ContactFirstName,ContactID,ContactLastName,
ContactMiddleName,ContactName,ContactTypeID,Crtd_DateTime,Crtd_Prog,Crtd_User,
CustomerFlag,EMailAddress,EmployeeFlag,Lupd_DateTime,Lupd_Prog,Lupd_User,
ShortName,StatusTypeID,Title,TranSchedMethTypeID,VendorFlag,VetFlag)
Select ContactFirstName,ContactID,ContactLastName,ContactMiddleName,ContactName,ContactTypeID,Crtd_DateTime,
Crtd_Prog,Crtd_User,
CustomerFlag,EMailAddress,EmployeeFlag,Lupd_DateTime,Lupd_Prog,Lupd_User,
ShortName,StatusTypeID,Title,TranSchedMethTypeID,VendorFlag,VetFlag
From [$(SolomonApp)].dbo.cftContact
Commit

Begin Transaction
INSERT INTO dbo.cftBinTemp(Active,BarnNbr,BinNbr,
BinSortOrder,BinTypeID,ContactID,Crtd_DateTime,Crtd_Prog,
Crtd_User,FeedingLevel,Lupd_DateTime,Lupd_Prog,Lupd_User,RoomNbr)
Select Active,BarnNbr,BinNbr,
BinSortOrder,BinTypeID,ContactID,Crtd_DateTime,Crtd_Prog,
Crtd_User,FeedingLevel,Lupd_DateTime,Lupd_Prog,Lupd_User,RoomNbr
From [$(SolomonApp)].dbo.cftBin
Commit

Begin Transaction
INSERT INTO dbo.cftBarnTemp  (AlarmSystemType,BarnDescription,BarnID,
BarnManufacturer,BarnMgrContactID,BarnNbr,BarnStyleID,CapMultiplier,CenterAlleyWidth,
ContactID,Crtd_DateTime,Crtd_Prog,Crtd_User,DateBuilt,DateContracted,DeliverFeedFlag,
DfltFeedPlanID,DfltRation,FacilityTypeID,FinFile,Height,Length,LoadChuteFlag,LossValue,
Lupd_DateTime,Lupd_Prog,Lupd_User,ManureSysTypeID,ManuverableWithSemiF,MaxCap,PigChampLocationID,
SiteID,SpecialRation,SpecialRationBegin,SpecialRationEnd,SquareFootage,StatusTypeID,StdCap,
VentilationType,WasteHandlingSys,WFFinFile2,Width)
Select AlarmSystemType,BarnDescription,BarnID,
BarnManufacturer,BarnMgrContactID,BarnNbr,BarnStyleID,CapMultiplier,CenterAlleyWidth,
ContactID,Crtd_DateTime,Crtd_Prog,Crtd_User,DateBuilt,DateContracted,DeliverFeedFlag,
DfltFeedPlanID,DfltRation,FacilityTypeID,FinFile,Height,Length,LoadChuteFlag,LossValue,
Lupd_DateTime,Lupd_Prog,Lupd_User,ManureSysTypeID,ManuverableWithSemiF,MaxCap,PigChampLocationID,
SiteID,SpecialRation,SpecialRationBegin,SpecialRationEnd,SquareFootage,StatusTypeID,StdCap,
VentilationType,WasteHandlingSys,WFFinFile2,Width
From [$(SolomonApp)].dbo.cftBarn
Commit




 





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pEssbaseSolomonTemp] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pEssbaseSolomonTemp] TO [se\analysts]
    AS [dbo];

