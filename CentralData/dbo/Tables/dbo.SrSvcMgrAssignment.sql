CREATE TABLE [dbo].[SrSvcMgrAssignment] (
    [SrSvcMgrAssignmentID] INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SrSvcMgrContactID]    INT NOT NULL,
    [SvcMgrContactID]      INT NOT NULL,
    CONSTRAINT [PK_SrSvcMgrAssignment] PRIMARY KEY CLUSTERED ([SrSvcMgrContactID] ASC, [SvcMgrContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsSrSvcMgrAsn ON [dbo].[SrSvcMgrAssignment] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftSrSvcMgrAsn
(
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
SrSvcMgrContactID,SvcMgrContactID

)
Select

getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',
SrSvcMgrContactID=replicate('0',6-len(rtrim(convert(char(6),SrSvcMgrContactID))))
	 + rtrim(convert(char(6),SrSvcMgrContactID)),
SvcMgrContactID=replicate('0',6-len(rtrim(convert(char(6),SvcMgrContactID))))
	 + rtrim(convert(char(6),SvcMgrContactID))

From Inserted



GO
CREATE TRIGGER trDelSrSvcMgrAsn ON [dbo].[SrSvcMgrAssignment] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftSrSvcMgrAsn
FROM [$(SolomonApp)].dbo.cftSrSvcMgrAsn r
JOIN Deleted d on
r.SrSvcMgrContactID=
replicate('0',6-len(rtrim(convert(char(6),d.SrSvcMgrContactID))))
	 + rtrim(convert(char(6),d.SrSvcMgrContactID))
and 
r.SvcMgrContactID=
replicate('0',6-len(rtrim(convert(char(6),d.SvcMgrContactID))))
	 + rtrim(convert(char(6),d.SvcMgrContactID))

GO
CREATE TRIGGER trUpdSrSvcMgrAsn ON [dbo].[SrSvcMgrAssignment] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftSrSvcMgrAsn
FROM [$(SolomonApp)].dbo.cftSrSvcMgrAsn r
JOIN Deleted d on
r.SrSvcMgrContactID=
replicate('0',6-len(rtrim(convert(char(6),d.SrSvcMgrContactID))))
	 + rtrim(convert(char(6),d.SrSvcMgrContactID))
and 
r.SvcMgrContactID=
replicate('0',6-len(rtrim(convert(char(6),d.SvcMgrContactID))))
	 + rtrim(convert(char(6),d.SvcMgrContactID))

Insert into [$(SolomonApp)].dbo.cftSrSvcMgrAsn
(
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
SrSvcMgrContactID,SvcMgrContactID

)
Select

getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',
SrSvcMgrContactID=replicate('0',6-len(rtrim(convert(char(6),SrSvcMgrContactID))))
	 + rtrim(convert(char(6),SrSvcMgrContactID)),
SvcMgrContactID=replicate('0',6-len(rtrim(convert(char(6),SvcMgrContactID))))
	 + rtrim(convert(char(6),SvcMgrContactID))

From Inserted

COMMIT TRAN
