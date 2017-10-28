CREATE  TRIGGER 
	dbo.trInsBarn ON [dbo].[Barn] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftBarn
(AlarmSystemType,BarnDescription,BarnID,BarnManufacturer,BarnMgrContactID,BarnNbr,
BarnStyleID,CapMultiplier,CenterAlleyWidth,ContactID,Crtd_DateTime,Crtd_Prog,Crtd_User,
DateContracted,DfltFeedPlanID,
DfltRation,DeliverFeedFlag,FacilityTypeID,FinFile,Height,Length,LoadChuteFlag,LossValue,
Lupd_DateTime,Lupd_Prog,Lupd_User,ManuverableWithSemiF,MaxCap,PigChampLocationID,SiteID,
SpecialRation,SpecialRationBegin,SpecialRationEnd,SquareFootage,StatusTypeID,StdCap,
VentilationType,WasteHandlingSys,WFFinFile2,Width,DateBuilt,ManureSysTypeID
)
Select 
Case when AlarmSystemType is null
		then '' else replicate('0',2-len(rtrim(convert(char(2),AlarmSystemType))))
	 + rtrim(convert(char(2),AlarmSystemType)) END,
isnull(BarnDescription,''),BarnID=replicate('0',5-len(rtrim(convert(char(5),BarnID))))
	 + rtrim(convert(char(5),BarnID)),
isnull(BarnManufacturer,''),
BarnMgrContactID=case when BarnMgrContactID is null then '' Else replicate('0',6-len(rtrim(convert(char(6),BarnMgrContactID))))
	 + rtrim(convert(char(6),BarnMgrContactID)) END,
isnull(BarnNbr,''),
BarnStyleID=Case when BarnStyleID is null then '' ELSE replicate('0',2-len(rtrim(convert(char(2),BarnStyleID))))
	 + rtrim(convert(char(2),BarnStyleID)) END,
isnull(CapMultiplier,0),isnull(CenterAlleyWidth,0),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
Crtd_DateTime=GETDATE(),Crtd_Prog='',Crtd_User='SYSADMIN',
isnull(DateContracted,'1/1/1900'),
Case when DefaultFeedPlanID is null
then '0000' else
replicate('0',4-len(rtrim(convert(char(4),DefaultFeedPlanID))))
	 + rtrim(convert(char(4),DefaultFeedPlanID)) END,
DefaultRation=isnull(DefaultRation,''),isnull(DeliverFeedFlag,0),
FacilityTypeID=Case when FacilityTypeID is null then '' Else  replicate('0',3-len(rtrim(convert(char(6),FacilityTypeID))))
	 + rtrim(convert(char(3),FacilityTypeID)) END,
isnull(FinFile,''),isnull(Height,0),isnull(Length,0),isnull(LoadChuteFlag,0),isnull(LossValue,0),
GETDATE(),'','SYSADMIN',isnull(ManuverableWithSemiFlag,0),
isnull(MaxCap,0),isnull(PigChampLocationID,''),
isnull(SiteID,''),
isnull(SpecialRation,''),isnull(SpecialRationBegin,'1/1/1901'),isnull(SpecialRationEnd,'1/1/1901'),
isnull(SquareFootage,0),isnull(StatusTypeID,''),isnull(StdCap,0),
isnull(VentilationType,''),isnull(WasteHandlingSys,''),isnull(WFFinFile2,''),isnull(Width,0),isnull(DateBuilt,''),
isnull(ManureSysTypeID,'')
	FROM Inserted


Insert into dbo.BarnChar (BarnID)
select BarnID FROM Inserted


GO
CREATE TRIGGER trDelBarn ON [dbo].[Barn] 
FOR DELETE
AS
Delete b
FROM [$(SolomonApp)].dbo.cftBarn b
JOIN Deleted d on
b.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and b.BarnNbr=d.BarnNbr

GO

/****** Object:  Trigger dbo.trUpdBarn    Script Date: 9/28/2005 7:08:54 AM ******/
CREATE  TRIGGER trUpdBarn ON [dbo].[Barn] 
FOR UPDATE
AS
BEGIN TRAN
Delete b
FROM [$(SolomonApp)].dbo.cftBarn b
JOIN Deleted d on
b.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and b.BarnNbr=d.BarnNbr

Insert into [$(SolomonApp)].dbo.cftBarn
(AlarmSystemType,BarnDescription,BarnID,BarnManufacturer,BarnMgrContactID,BarnNbr,
BarnStyleID,CapMultiplier,CenterAlleyWidth,ContactID,Crtd_DateTime,Crtd_Prog,Crtd_User,
DateContracted,DfltFeedPlanID,
DfltRation,DeliverFeedFlag,FacilityTypeID,FinFile,Height,Length,LoadChuteFlag,LossValue,
Lupd_DateTime,Lupd_Prog,Lupd_User,ManuverableWithSemiF,MaxCap,PigChampLocationID,SiteID,
SpecialRation,SpecialRationBegin,SpecialRationEnd,SquareFootage,StatusTypeID,StdCap,
VentilationType,WasteHandlingSys,WFFinFile2,Width,DateBuilt,ManureSysTypeID
)
Select 
Case when AlarmSystemType is null
		then '' else replicate('0',2-len(rtrim(convert(char(2),AlarmSystemType))))
	 + rtrim(convert(char(2),AlarmSystemType)) END,
isnull(BarnDescription,''),BarnID=replicate('0',5-len(rtrim(convert(char(5),BarnID))))
	 + rtrim(convert(char(5),BarnID)),
isnull(BarnManufacturer,''),
BarnMgrContactID=case when BarnMgrContactID is null then '' Else replicate('0',6-len(rtrim(convert(char(6),BarnMgrContactID))))
	 + rtrim(convert(char(6),BarnMgrContactID)) END,
isnull(BarnNbr,''),
BarnStyleID=Case when BarnStyleID is null then '' ELSE replicate('0',2-len(rtrim(convert(char(2),BarnStyleID))))
	 + rtrim(convert(char(2),BarnStyleID)) END,
isnull(CapMultiplier,0),isnull(CenterAlleyWidth,0),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
Crtd_DateTime=GETDATE(),Crtd_Prog='',Crtd_User='SYSADMIN',
isnull(DateContracted,'1/1/1900'),
Case when DefaultFeedPlanID is null
then '0000' else
replicate('0',4-len(rtrim(convert(char(4),DefaultFeedPlanID))))
	 + rtrim(convert(char(4),DefaultFeedPlanID)) END,
DefaultRation=isnull(DefaultRation,''),isnull(DeliverFeedFlag,0),
FacilityTypeID=Case when FacilityTypeID is null then '' Else  replicate('0',3-len(rtrim(convert(char(6),FacilityTypeID))))
	 + rtrim(convert(char(3),FacilityTypeID)) END,
isnull(FinFile,''),isnull(Height,0),isnull(Length,0),isnull(LoadChuteFlag,0),isnull(LossValue,0),
GETDATE(),'','SYSADMIN',isnull(ManuverableWithSemiFlag,0),
isnull(MaxCap,0),isnull(PigChampLocationID,''),
isnull(SiteID,''),
isnull(SpecialRation,''),isnull(SpecialRationBegin,'1/1/1901'),isnull(SpecialRationEnd,'1/1/1901'),
isnull(SquareFootage,0),isnull(StatusTypeID,''),isnull(StdCap,0),
isnull(VentilationType,''),isnull(WasteHandlingSys,''),isnull(WFFinFile2,''),isnull(Width,0),isnull(DateBuilt,''),
isnull(ManureSysTypeID,'')
	FROM Inserted
COMMIT TRAN
