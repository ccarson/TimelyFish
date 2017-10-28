CREATE TRIGGER [dbo].[trInsProdSvcMgr] ON [dbo].[ProdSvcMgrAssignment] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftProdSvcMgr
(
Crtd_DateTime,Crtd_Prog,Crtd_User,
EffectiveDate,
Lupd_DateTime,Lupd_Prog,Lupd_User,
ProdSvcMgrContactID,SiteContactID

)
Select

getdate(),'','SYSADMIN',
isnull(EffectiveDate,'1/1/1900'),
getdate(),'','SYSADMIN',
ProdSvcMgrContactID=replicate('0',6-len(rtrim(convert(char(6),ProdSvcMgrContactID))))
	 + rtrim(convert(char(6),ProdSvcMgrContactID)),
SiteContactID=replicate('0',6-len(rtrim(convert(char(6),SiteContactID))))
	 + rtrim(convert(char(6),SiteContactID))

From Inserted




GO
CREATE TRIGGER trDelProdSvcMgr ON [dbo].[ProdSvcMgrAssignment] 
FOR DELETE
AS
Delete r
FROM [$(SolomonApp)].dbo.cftProdSvcMgr r
JOIN Deleted d on
r.SiteContactID=
replicate('0',6-len(rtrim(convert(char(6),d.SiteContactID))))
	 + rtrim(convert(char(6),d.SiteContactID))
and 
r.EffectiveDate=
d.EffectiveDate

GO

CREATE TRIGGER [dbo].[trUpdProdSvcMgr] ON [dbo].[ProdSvcMgrAssignment] 
FOR UPDATE
AS
BEGIN TRAN
Delete r
FROM [$(SolomonApp)].dbo.cftProdSvcMgr r
JOIN Deleted d on
r.SiteContactID=
replicate('0',6-len(rtrim(convert(char(6),d.SiteContactID))))
	 + rtrim(convert(char(6),d.SiteContactID))
and 
r.EffectiveDate=
d.EffectiveDate

Insert into [$(SolomonApp)].dbo.cftProdSvcMgr
(
Crtd_DateTime,Crtd_Prog,Crtd_User,
EffectiveDate,
Lupd_DateTime,Lupd_Prog,Lupd_User,
ProdSvcMgrContactID,SiteContactID

)
Select

getdate(),'','SYSADMIN',
isnull(EffectiveDate,'1/1/1900'),
getdate(),'','SYSADMIN',
ProdSvcMgrContactID=replicate('0',6-len(rtrim(convert(char(6),ProdSvcMgrContactID))))
	 + rtrim(convert(char(6),ProdSvcMgrContactID)),
SiteContactID=replicate('0',6-len(rtrim(convert(char(6),SiteContactID))))
	 + rtrim(convert(char(6),SiteContactID))
from Inserted

COMMIT TRAN
