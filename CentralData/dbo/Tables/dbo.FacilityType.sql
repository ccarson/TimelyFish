CREATE TABLE [dbo].[FacilityType] (
    [FacilityTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FacilityTypeDescription] VARCHAR (30) NULL,
    [PigProdPhaseID]          VARCHAR (3)  NULL,
    CONSTRAINT [PK_FacilityType] PRIMARY KEY CLUSTERED ([FacilityTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsFacilityType ON [dbo].[FacilityType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftFacilityType
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
FacilityTypeID,
Lupd_DateTime,Lupd_Prog,Lupd_User,PigProdPhaseID
)
Select

getdate(),'','SYSADMIN',
isnull(FacilityTypeDescription,''),
FacilityTypeID=replicate('0',3-len(rtrim(convert(char(3),FacilityTypeID)))) + rtrim(convert(char(3),FacilityTypeID)),
getdate(),'','SYSADMIN',isnull(PigProdPhaseID,'')
FROM Inserted




GO
CREATE TRIGGER trDelFacilityType ON [dbo].[FacilityType] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftFacilityType FROM [$(SolomonApp)].dbo.cftFacilityType s
JOIN Deleted d on 
s.FacilityTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.FacilityTypeID))))
	 + rtrim(convert(char(3),d.FacilityTypeID)) 

 


GO
CREATE TRIGGER trUpdFacilityType ON [dbo].[FacilityType] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftFacilityType FROM [$(SolomonApp)].dbo.cftFacilityType s
JOIN Deleted d on 
s.FacilityTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.FacilityTypeID))))
	 + rtrim(convert(char(3),d.FacilityTypeID)) 

Insert into [$(SolomonApp)].dbo.cftFacilityType
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
FacilityTypeID,
Lupd_DateTime,Lupd_Prog,Lupd_User,PigProdPhaseID
)
Select

getdate(),'','SYSADMIN',
isnull(FacilityTypeDescription,''),
FacilityTypeID=replicate('0',3-len(rtrim(convert(char(3),FacilityTypeID)))) + rtrim(convert(char(3),FacilityTypeID)),
getdate(),'','SYSADMIN',isnull(PigProdPhaseID,'')
FROM Inserted

COMMIT TRAN


GO
GRANT SELECT
    ON OBJECT::[dbo].[FacilityType] TO [hybridconnectionlogin_permissions]
    AS [dbo];

