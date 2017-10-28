CREATE TRIGGER trInsRoom ON [dbo].[Room] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftRoom
(BarnNbr,
BrnCapPrct,
ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
DfltFeedPlanID,
DfltGenderTypeID,
FacilityTypeID,
FinFile,Height,Length,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PigChampLocationID,RoomDescription,
RoomNbr,
StatusTypeID,WFFinFile2,Width

)
Select
isnull(b.BarnNbr,''),
isnull(BarnCapPercentage,0),
ContactID=replicate('0',6-len(rtrim(convert(char(6),r.ContactID))))
	 + rtrim(convert(char(6),r.ContactID)),
getdate(),'','SYSADMIN',
DfltFeedPlanID=isnull(r.DefaultFeedPlanID,''),
DfltGenderTypeID=isnull(r.DefaultGenderTypeID,''),
Case when r.FacilityTypeID is null then '' Else  replicate('0',3-len(rtrim(convert(char(6),r.FacilityTypeID))))
	 + rtrim(convert(char(3),r.FacilityTypeID)) END,
isnull(r.FinFile,''),isnull(r.Height,0),isnull(r.Length,0),
getdate(),'','SYSADMIN',
isnull(r.PigChampLocationID,''),isnull(RoomDescription,''),
RoomNbr=isnull(RoomNbr,''),
isnull(r.StatusTypeID,''),isnull(r.WFFinFile2,''),isnull(r.Width,0)

From Inserted r
LEFT JOIN  dbo.Barn b on r.BarnID=b.BarnID


GO
CREATE TRIGGER trDelRoom ON [dbo].[Room] 
FOR DELETE
AS
Delete r
FROM [$(SolomonApp)].dbo.cftRoom r
JOIN Deleted d on
r.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

and r.RoomNbr=d.RoomNbr

GO
CREATE TRIGGER trUpdRoom ON [dbo].[Room] 
FOR UPDATE
AS
BEGIN TRAN
Delete r
FROM [$(SolomonApp)].dbo.cftRoom r
JOIN Deleted d on
r.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

and r.RoomNbr=d.RoomNbr

Insert into [$(SolomonApp)].dbo.cftRoom
(BarnNbr,
BrnCapPrct,
ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
DfltFeedPlanID,
DfltGenderTypeID,
FacilityTypeID,
FinFile,Height,Length,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PigChampLocationID,RoomDescription,
RoomNbr,
StatusTypeID,WFFinFile2,Width
)
Select
isnull(b.BarnNbr,''),
isnull(BarnCapPercentage,0),
ContactID=replicate('0',6-len(rtrim(convert(char(6),r.ContactID))))
	 + rtrim(convert(char(6),r.ContactID)),
getdate(),'','SYSADMIN',
DfltFeedPlanID=isnull(r.DefaultFeedPlanID,''),
DfltGenderTypeID=isnull(r.DefaultGenderTypeID,''),
Case when r.FacilityTypeID is null then '' Else  replicate('0',3-len(rtrim(convert(char(6),r.FacilityTypeID))))
	 + rtrim(convert(char(3),r.FacilityTypeID)) END,
isnull(r.FinFile,''),isnull(r.Height,0),isnull(r.Length,0),
getdate(),'','SYSADMIN',
isnull(r.PigChampLocationID,''),isnull(RoomDescription,''),
RoomNbr=isnull(RoomNbr,''),
isnull(r.StatusTypeID,''),isnull(r.WFFinFile2,''),isnull(r.Width,0)

From Inserted r
LEFT JOIN  dbo.Barn b on r.BarnID=b.BarnID
COMMIT TRAN
