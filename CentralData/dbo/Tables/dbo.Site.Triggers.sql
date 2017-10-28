CREATE TRIGGER dbo.trSiteInsert on dbo.Site
FOR INSERT
AS
SET NOCOUNT ON
INSERT INTO dbo.HealthServices(ContactID)
	Select ContactID
FROM Inserted i

GO
/****** Object:  Trigger dbo.trInsSite    Script Date: 9/28/2005 1:25:32 PM ******/
CREATE  TRIGGER dbo.trInsSite ON dbo.Site 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftSite
(AugerRatePerHour,AugerType,CollateralHolderPigs,CollateralHolderProp,CompanyName,
ContactID,CpnyID,Crtd_DateTime,Crtd_Prog,Crtd_User,DefaultPigCpnyID,DeliverFeedFlag,
FacilityTypeID,FeedGrouping,FeedMillContactID,FeedOrderComments,FeedOrderDay,
FeedTransferLocation,FeedTransferTons,GeneratorTypeID,
Lupd_DateTime,Lupd_Prog,Lupd_User,OfficeLocation,OfficeSize,OverheadPwrLinesFlag,
OwnershipLevelID,OwnershipTypeID,PFEUClassification,PremiseID,PigSystemID,
PortChuteFlg,
RoadRestrictionTons,SiteAcres,
SiteID,SiteMgrContactID,SolomonProjectID,WallMapPinLocation,WallMapPinNbr,
ContractCpnyID,OwningCpnyID,GeoState,SwapAssessorContID,
FeedlotRegNbr
)
Select 
isnull(AugerRatePerHour,0),isnull(AugerType,''),isnull(CollateralHolderPigs,''),isnull(CollateralHolderProperty,''),
isnull(CompanyName,''),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
isnull(a.AccountingEntityDescription,'') as CpnyID,getdate(),'','SYSADMIN',
isnull(a1.AccountingEntityDescription,'') as DefaultPigCpnyID,isnull(DeliverFeedFlag,0),
case when FacilityTypeID is null then '' else replicate('0',3-len(rtrim(convert(char(3),FacilityTypeID)))) + rtrim(convert(char(3),FacilityTypeID)) end,
isnull(FeedGrouping,''),
Case when FeedMillContactID is null then '' else replicate('0',6-len(rtrim(convert(char(6),FeedMillContactID)))) + rtrim(convert(char(6),FeedMillContactID)) end,
isnull(FeedOrderComments,''), isnull(FeedOrderDay,''),
isnull(FeedTransferLocation,''),isnull(FeedTransferTons,0),
case when GeneratorTypeID is null then '' else replicate('0',2-len(rtrim(convert(char(2),GeneratorTypeID)))) + rtrim(convert(char(2),GeneratorTypeID)) end,
getdate(),'','SYSADMIN',isnull(OfficeLocaction,''),isnull(OfficeSize,''),isnull(OverheadPowerLinesFlag,0),
case when OwnershipLevelID is null then '' else replicate('0',2-len(rtrim(convert(char(2),OwnershipLevelID)))) + rtrim(convert(char(2),OwnershipLevelID)) end,
case when OwnershipID is null then '' else replicate('0', 2-len(rtrim(convert(char(2),OwnershipID)))) + rtrim(convert(char(2),OwnershipID)) end,
isnull(PFEUClassification,''),isnull(PremiseID,''),
case when PigSystemID is null then '' else replicate('0', 2-len(rtrim(convert(char(2),PigSystemID)))) + rtrim(convert(char(2),PigSystemID)) end ,
isnull(PortChuteFlg,0),
isnull(RoadRestrictionTons,0),isnull(SiteAcres,0),
isnull(SiteID,''),
case when SiteMgrContactID is null then '' else replicate('0',6-len(rtrim(convert(char(6),SiteMgrContactID)))) + rtrim(convert(char(6),SiteMgrContactID)) end,
case when SiteID is null then '' else (Select ProjectPrefix from [$(SolomonApp)].dbo.cftPGSetup) + SiteID end ,
isnull(WallMapPinLocation,''),isnull(WallMapPinNbr,''), 
ContractCpnyID=isnull(cc.AccountingEntityDescription,''),
OwningCpnyID=isnull(oc.AccountingEntityDescription,''),
GeoState=isnull(GeoState,''),
SwapAssessorContID=isnull(SwapAssessorContID,''),
FeedlotRegNbr=isnull(FeedlotRegNbr,'')
From Inserted s
LEFT OUTER JOIN dbo.AccountingEntity a on s.AccountingEntityID=a.AccountingEntityID
LEFT OUTER JOIN dbo.AccountingEntity a1 on s.DefaultPigCompanyID=a1.AccountingEntityID
LEFT OUTER JOIN dbo.AccountingEntity oc on s.OwningCpnyID=oc.AccountingEntityID
LEFT OUTER JOIN dbo.AccountingEntity cc on s.ContractCpnyID=cc.AccountingEntityID

GO
CREATE TRIGGER trDelSite ON dbo.Site 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftSite s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

GO
/****** Object:  Trigger dbo.trUpdSite    Script Date: 9/28/2005 1:21:14 PM ******/
CREATE  TRIGGER trUpdSite ON dbo.Site 
FOR UPDATE
AS
BEGIN TRAN
Delete s FROM [$(SolomonApp)].dbo.cftSite s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 


Insert into [$(SolomonApp)].dbo.cftSite
(AugerRatePerHour,AugerType,CollateralHolderPigs,CollateralHolderProp,CompanyName,
ContactID,CpnyID,Crtd_DateTime,Crtd_Prog,Crtd_User,DefaultPigCpnyID,DeliverFeedFlag,
FacilityTypeID,FeedGrouping,FeedMillContactID,FeedOrderComments,FeedOrderDay,
FeedTransferLocation,FeedTransferTons,GeneratorTypeID,
Lupd_DateTime,Lupd_Prog,Lupd_User,OfficeLocation,OfficeSize,OverheadPwrLinesFlag,
OwnershipLevelID,OwnershipTypeID,PFEUClassification,PremiseID,PigSystemID,
PortChuteFlg,
RoadRestrictionTons,SiteAcres,
SiteID,SiteMgrContactID,SolomonProjectID,WallMapPinLocation,WallMapPinNbr,
ContractCpnyID,OwningCpnyID,GeoState, SwapAssessorContID, FeedlotRegNbr 
)
Select 
isnull(AugerRatePerHour,0),isnull(AugerType,''),isnull(CollateralHolderPigs,''),isnull(CollateralHolderProperty,''),
isnull(CompanyName,''),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
isnull(a.AccountingEntityDescription,'') as CpnyID,getdate(),'','SYSADMIN',
isnull(a1.AccountingEntityDescription,'') as DefaultPigCpnyID,isnull(DeliverFeedFlag,0),
case when FacilityTypeID is null then '' else replicate('0',3-len(rtrim(convert(char(3),FacilityTypeID)))) + rtrim(convert(char(3),FacilityTypeID)) end,
isnull(FeedGrouping,''),
Case when FeedMillContactID is null then '' else replicate('0',6-len(rtrim(convert(char(6),FeedMillContactID)))) + rtrim(convert(char(6),FeedMillContactID)) end,
isnull(FeedOrderComments,''), isnull(FeedOrderDay,''),
isnull(FeedTransferLocation,''),isnull(FeedTransferTons,0),
case when GeneratorTypeID is null then '' else replicate('0',2-len(rtrim(convert(char(2),GeneratorTypeID)))) + rtrim(convert(char(2),GeneratorTypeID)) end,
getdate(),'','SYSADMIN',isnull(OfficeLocaction,''),isnull(OfficeSize,''),isnull(OverheadPowerLinesFlag,0),
case when OwnershipLevelID is null then '' else replicate('0',2-len(rtrim(convert(char(2),OwnershipLevelID)))) + rtrim(convert(char(2),OwnershipLevelID)) end,
case when OwnershipID is null then '' else replicate('0', 2-len(rtrim(convert(char(2),OwnershipID)))) + rtrim(convert(char(2),OwnershipID)) end,
isnull(PFEUClassification,''),isnull(PremiseID,''),
case when PigSystemID is null then '' else replicate('0', 2-len(rtrim(convert(char(2),PigSystemID)))) + rtrim(convert(char(2),PigSystemID)) end ,
isnull(PortChuteFlg,0),
isnull(RoadRestrictionTons,0),isnull(SiteAcres,0),
isnull(SiteID,''),
case when SiteMgrContactID is null then '' else replicate('0',6-len(rtrim(convert(char(6),SiteMgrContactID)))) + rtrim(convert(char(6),SiteMgrContactID)) end,
case when SiteID is null then '' else (Select ProjectPrefix from [$(SolomonApp)].dbo.cftPGSetup) + SiteID end ,
isnull(WallMapPinLocation,''),isnull(WallMapPinNbr,''), 
ContractCpnyID=isnull(cc.AccountingEntityDescription,''),
OwningCpnyID=isnull(oc.AccountingEntityDescription,''),
GeoState=isnull(GeoState,''),
SwapAssessorContID=isnull(SwapAssessorContID,''),
FeedlotRegNbr=isnull(FeedlotRegNbr,'')

From Inserted s
LEFT OUTER JOIN dbo.AccountingEntity a on s.AccountingEntityID=a.AccountingEntityID
LEFT OUTER JOIN dbo.AccountingEntity a1 on s.DefaultPigCompanyID=a1.AccountingEntityID
LEFT OUTER JOIN dbo.AccountingEntity oc on s.OwningCpnyID=oc.AccountingEntityID
LEFT OUTER JOIN dbo.AccountingEntity cc on s.ContractCpnyID=cc.AccountingEntityID
COMMIT TRAN

GO
GRANT SELECT
    ON OBJECT::[dbo].[Site] TO [hybridconnectionlogin_permissions]
    AS [dbo];
