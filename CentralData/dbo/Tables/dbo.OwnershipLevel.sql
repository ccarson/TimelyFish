CREATE TABLE [dbo].[OwnershipLevel] (
    [OwnershipLevelID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [OwnershipLevelDescription] VARCHAR (10) NULL,
    CONSTRAINT [PK_OwnershipLevel] PRIMARY KEY CLUSTERED ([OwnershipLevelID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsOwnershipLevel ON [dbo].[OwnershipLevel] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftOwnershipLevel
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User,
OwnershipLevelID
)
Select 
getdate(),'','SYSADMIN',
isnull(OwnershipLevelDescription,''),
getdate(),'','SYSADMIN',
OwnershipLevelID=replicate('0',2-len(rtrim(convert(char(2),OwnershipLevelID)))) + rtrim(convert(char(2),OwnershipLevelID))
	FROM Inserted

GO
CREATE TRIGGER trDelOwnershipLevel ON [dbo].[OwnershipLevel] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftOwnershipLevel
FROM [$(SolomonApp)].dbo.cftOwnershipLevel a
JOIN Deleted d on 
a.OwnershipLevelID=replicate('0',2-len(rtrim(convert(char(2),d.OwnershipLevelID)))) + rtrim(convert(char(2),d.OwnershipLevelID))

GO
CREATE TRIGGER trUpdOwnershipLevel ON [dbo].[OwnershipLevel] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftOwnershipLevel
FROM [$(SolomonApp)].dbo.cftOwnershipLevel a
JOIN Deleted d on 
a.OwnershipLevelID=replicate('0',2-len(rtrim(convert(char(2),d.OwnershipLevelID)))) + rtrim(convert(char(2),d.OwnershipLevelID))

Insert into [$(SolomonApp)].dbo.cftOwnershipLevel
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User,
OwnershipLevelID
)
Select 
getdate(),'','SYSADMIN',
isnull(OwnershipLevelDescription,''),
getdate(),'','SYSADMIN',
OwnershipLevelID=replicate('0',2-len(rtrim(convert(char(2),OwnershipLevelID)))) + rtrim(convert(char(2),OwnershipLevelID))
	FROM Inserted


COMMIT TRAN

