CREATE TABLE [dbo].[MarketSvcMgrAssignment] (
    [MarketSvcMgrAssignmentID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]            INT           NOT NULL,
    [MarketSvcMgrContactID]    INT           NOT NULL,
    [EffectiveDate]            SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_MarketSvcMgrAssignment] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsMktMgrAssign ON [dbo].[MarketSvcMgrAssignment] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftMktMgrAssign
(Crtd_DateTime,Crtd_Prog,Crtd_User,
EffectiveDate,
Lupd_DateTime,Lupd_Prog,Lupd_User,
MktMgrContactID,
SiteContactID
)
Select
getdate(),'','SYSADMIN',
isnull(EffectiveDate,'1/1/1901'),
getdate(),'','SYSADMIN',
MktMgrContactID=replicate('0',6-len(rtrim(convert(char(6),MarketSvcMgrContactID))))
	 + rtrim(convert(char(6),MarketSvcMgrContactID)),
SiteContactID=replicate('0',6-len(rtrim(convert(char(6),SiteContactID))))
	 + rtrim(convert(char(6),SiteContactID))

	FROM Inserted

GO
CREATE TRIGGER trDelMktMgrAssign ON [dbo].[MarketSvcMgrAssignment] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftMktMgrAssign
FROM [$(SolomonApp)].dbo.cftMktMgrAssign a
JOIN Deleted d on 
a.MktMgrContactID=replicate('0',6-len(rtrim(convert(char(6),d.MarketSvcMgrContactID))))
	 + rtrim(convert(char(6),d.MarketSvcMgrContactID))
AND
a.SiteContactID=replicate('0',6-len(rtrim(convert(char(6),d.SiteContactID))))
	 + rtrim(convert(char(6),d.SiteContactID))

GO
CREATE TRIGGER trUpdMktMgrAssign ON [dbo].[MarketSvcMgrAssignment] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftMktMgrAssign
FROM [$(SolomonApp)].dbo.cftMktMgrAssign a
JOIN Deleted d on 
a.MktMgrContactID=replicate('0',6-len(rtrim(convert(char(6),d.MarketSvcMgrContactID))))
	 + rtrim(convert(char(6),d.MarketSvcMgrContactID))
AND
a.SiteContactID=replicate('0',6-len(rtrim(convert(char(6),d.SiteContactID))))
	 + rtrim(convert(char(6),d.SiteContactID))

Insert into [$(SolomonApp)].dbo.cftMktMgrAssign
(Crtd_DateTime,Crtd_Prog,Crtd_User,
EffectiveDate,
Lupd_DateTime,Lupd_Prog,Lupd_User,
MktMgrContactID,
SiteContactID
)
Select
getdate(),'','SYSADMIN',
isnull(EffectiveDate,'1/1/1901'),
getdate(),'','SYSADMIN',
MktMgrContactID=replicate('0',6-len(rtrim(convert(char(6),MarketSvcMgrContactID))))
	 + rtrim(convert(char(6),MarketSvcMgrContactID)),
SiteContactID=replicate('0',6-len(rtrim(convert(char(6),SiteContactID))))
	 + rtrim(convert(char(6),SiteContactID))

	FROM Inserted




COMMIT TRAN


GO
GRANT SELECT
    ON OBJECT::[dbo].[MarketSvcMgrAssignment] TO [hybridconnectionlogin_permissions]
    AS [dbo];

