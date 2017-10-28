CREATE TRIGGER trInsSiteDivDept ON [dbo].[SiteDivDept] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftSiteDivDept
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Dept,Div,
EffectiveDate,EffectivePeriod,
Lupd_DateTime,Lupd_Prog,Lupd_User,
SiteID)
Select 
ContactID=Case when ContactID is null then '' 
	else replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)) end, 
GetDate(),'','SYSADMIN',
isnull(Dept,''), isnull(Div,''),
isnull(EffectiveDate,'1/1/1900'),isnull(EffectivePeriod,''),
getdate(),'','SYSADMIN',
isnull(SiteID,'')
	FROM Inserted


GO
CREATE TRIGGER trDelSiteDivDept ON [dbo].[SiteDivDept] 
FOR DELETE
AS
Delete a 
FROM [$(SolomonApp)].dbo.cftSiteDivDept a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and a.EffectiveDate=d.EffectiveDate

GO
CREATE TRIGGER trUpdSiteDivDept ON [dbo].[SiteDivDept] 
FOR UPDATE
AS
BEGIN TRAN
Delete a 
FROM [$(SolomonApp)].dbo.cftSiteDivDept a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and a.EffectiveDate=d.EffectiveDate

Insert into [$(SolomonApp)].dbo.cftSiteDivDept
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Dept,Div,
EffectiveDate,EffectivePeriod,
Lupd_DateTime,Lupd_Prog,Lupd_User,
SiteID)
Select 
ContactID=Case when ContactID is null then '' 
	else replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)) end, 
GetDate(),'','SYSADMIN',
isnull(Dept,''), isnull(Div,''),
isnull(EffectiveDate,'1/1/1900'),isnull(EffectivePeriod,''),
getdate(),'','SYSADMIN',
isnull(SiteID,'')
	FROM Inserted
COMMIT WORK
