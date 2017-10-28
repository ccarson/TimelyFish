CREATE TABLE [dbo].[Owner] (
    [OwnerID]            INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [OwnerContactID]     INT        NOT NULL,
    [SiteContactID]      INT        NOT NULL,
    [PrimaryContactFlag] SMALLINT   CONSTRAINT [DF_Owner_PrimaryContactFlag] DEFAULT (0) NULL,
    [PercentOwnership]   FLOAT (53) NULL,
    [TotalAcresFarmed]   FLOAT (53) CONSTRAINT [DF_Owner_TotalAcresFarmed] DEFAULT (0) NOT NULL,
    [TotalAcresOwned]    FLOAT (53) CONSTRAINT [DF_Owner_TotalAcresOwned] DEFAULT (0) NOT NULL,
    [TotalAcresRented]   FLOAT (53) CONSTRAINT [DF_Owner_TotalAcresRented] DEFAULT (0) NOT NULL,
    CONSTRAINT [PK_Owner] PRIMARY KEY CLUSTERED ([OwnerID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsOwner ON [dbo].[Owner] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftOwner
(Crtd_DateTime,Crtd_Prog,Crtd_User,
InsuranceProgramID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
OwnerContactID,
PercentOwnership,PrimaryContactFlag,
SiteContactID,
TotalAcresFarmed,TotalAcresOwned,TotalAcresRented
)
Select
getdate(),'','SYSADMIN',
'',
getdate(),'','SYSADMIN',
case when OwnerContactID is null then '' else replicate('0',6-len(rtrim(convert(char(6),OwnerContactID)))) + rtrim(convert(char(6),OwnerContactID)) end,
isnull(PercentOwnership,0),isnull(PrimaryContactFlag,0),
SiteContactID=replicate('0',6-len(rtrim(convert(char(6),SiteContactID)))) + rtrim(convert(char(6),SiteContactID)),
isnull(TotalAcresFarmed,0),isnull(TotalAcresOwned,0),isnull(TotalAcresRented,0)
FROM Inserted


GO
CREATE TRIGGER trDelOwner ON [dbo].[Owner] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftOwner FROM [$(SolomonApp)].dbo.cftOwner s
JOIN Deleted d on 
s.OwnerContactID=d.OwnerContactID and s.SiteContactID=d.SiteContactID



GO
CREATE TRIGGER trUpdOwner ON [dbo].[Owner] 
FOR UPDATE
AS
BEGIN TRAN

Delete [$(SolomonApp)].dbo.cftOwner FROM [$(SolomonApp)].dbo.cftOwner s
JOIN Deleted d on 
s.OwnerContactID=d.OwnerContactID and s.SiteContactID=d.SiteContactID

Insert into [$(SolomonApp)].dbo.cftOwner
(Crtd_DateTime,Crtd_Prog,Crtd_User,
InsuranceProgramID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
OwnerContactID,
PercentOwnership,PrimaryContactFlag,
SiteContactID,
TotalAcresFarmed,TotalAcresOwned,TotalAcresRented
)
Select
getdate(),'','SYSADMIN',
'',
getdate(),'','SYSADMIN',
case when OwnerContactID is null then '' else replicate('0',6-len(rtrim(convert(char(6),OwnerContactID)))) + rtrim(convert(char(6),OwnerContactID)) end,
isnull(PercentOwnership,0),isnull(PrimaryContactFlag,0),
SiteContactID=replicate('0',6-len(rtrim(convert(char(6),SiteContactID)))) + rtrim(convert(char(6),SiteContactID)),
isnull(TotalAcresFarmed,0),isnull(TotalAcresOwned,0),isnull(TotalAcresRented,0)
FROM Inserted

COMMIT TRAN
