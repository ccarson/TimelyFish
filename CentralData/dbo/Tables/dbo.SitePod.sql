CREATE TABLE [dbo].[SitePod] (
    [ContactID]       INT           NOT NULL,
    [PodID]           CHAR (3)      NOT NULL,
    [EffectiveDate]   SMALLDATETIME NOT NULL,
    [EffectivePeriod] CHAR (6)      NOT NULL,
    CONSTRAINT [PK_SitePod] PRIMARY KEY CLUSTERED ([ContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsSitePod ON [dbo].[SitePod] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftSitePod
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
EffectiveDate,EffectivePeriod,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PodID)
Select 
ContactID=Case when ContactID is null then '' 
	else replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)) end, 
GetDate(),'','SYSADMIN',
isnull(EffectiveDate,'1/1/1900'),isnull(EffectivePeriod,''),
getdate(),'','SYSADMIN',
isnull(PodID,'')
	FROM Inserted


GO
CREATE TRIGGER trDelSitePod ON [dbo].[SitePod] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftSitePod
FROM [$(SolomonApp)].dbo.cftSitePod a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and a.EffectiveDate=d.EffectiveDate

GO
CREATE TRIGGER trUpdSitePod ON [dbo].[SitePod] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftSitePod
FROM [$(SolomonApp)].dbo.cftSitePod a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and a.EffectiveDate=d.EffectiveDate

Insert into [$(SolomonApp)].dbo.cftSitePod
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
EffectiveDate,EffectivePeriod,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PodID)
Select 
ContactID=Case when ContactID is null then '' 
	else replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)) end, 
GetDate(),'','SYSADMIN',
isnull(EffectiveDate,'1/1/1900'),isnull(EffectivePeriod,''),
getdate(),'','SYSADMIN',
isnull(PodID,'')
	FROM Inserted

COMMIT WORK
