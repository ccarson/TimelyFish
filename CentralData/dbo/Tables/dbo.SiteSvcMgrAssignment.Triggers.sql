CREATE TRIGGER trInsSiteSvcMgrAssignment ON [dbo].[SiteSvcMgrAssignment] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftSiteSvcMgrAsn
(Crtd_DateTime,Crtd_Prog,Crtd_User,EffectiveDate,Lupd_DateTime,Lupd_Prog,Lupd_User,SiteContactID,SvcMgrContactID
)
Select 
getdate(),'','SYSADMIN',isnull(EffectiveDate,'1/1/1901'),getdate(),'','SYSADMIN',
case when SiteContactID is null then '' else
replicate('0',6-len(rtrim(convert(char(6),SiteContactID)))) + rtrim(convert(char(6),SiteContactID)) end,
case when SvcMgrContactID is null then '' else
replicate('0',6-len(rtrim(convert(char(6),SvcMgrContactID)))) + rtrim(convert(char(6),SvcMgrContactID)) end


	FROM Inserted


GO


CREATE TRIGGER trDelSiteSvcMgrAssignment ON [dbo].[SiteSvcMgrAssignment] 
FOR DELETE
AS
Delete a
FROM [$(SolomonApp)].dbo.cftSiteSvcMgrAsn a JOIN Deleted d
on a.EffectiveDate=d.EffectiveDate and a.SiteContactID=d.SiteContactID and a.SvcMgrContactID=d.SvcMgrContactID
GO


CREATE TRIGGER trUpdSiteSvcMgrAssignment ON [dbo].[SiteSvcMgrAssignment] 
FOR UPDATE
AS
BEGIN TRAN
Delete a
FROM [$(SolomonApp)].dbo.cftSiteSvcMgrAsn a JOIN Deleted d
on a.EffectiveDate=d.EffectiveDate and a.SiteContactID=d.SiteContactID and a.SvcMgrContactID=d.SvcMgrContactID

Insert into [$(SolomonApp)].dbo.cftSiteSvcMgrAsn
(Crtd_DateTime,Crtd_Prog,Crtd_User,EffectiveDate,Lupd_DateTime,Lupd_Prog,Lupd_User,SiteContactID,SvcMgrContactID
)
Select 
getdate(),'','SYSADMIN',isnull(EffectiveDate,'1/1/1901'),getdate(),'','SYSADMIN',
case when SiteContactID is null then '' else
replicate('0',6-len(rtrim(convert(char(6),SiteContactID)))) + rtrim(convert(char(6),SiteContactID)) end,
case when SvcMgrContactID is null then '' else
replicate('0',6-len(rtrim(convert(char(6),SvcMgrContactID)))) + rtrim(convert(char(6),SvcMgrContactID)) end


	FROM Inserted
COMMIT TRAN
