CREATE TRIGGER trInsContactType ON [dbo].[ContactType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftContactType
(ContactTypeID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select
ContactTypeID=replicate('0',2-len(rtrim(convert(char(2),ContactTypeID)))) + rtrim(convert(char(2),ContactTypeID)),
getdate(),'','SYSADMIN',
isnull(ContactTypeDescription,''),
getdate(),'','SYSADMIN'
FROM Inserted


GO
CREATE TRIGGER trDelContactType ON [dbo].[ContactType] 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftContactType s
JOIN Deleted d on 
s.ContactTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.ContactTypeID))))
	 + rtrim(convert(char(2),d.ContactTypeID)) 

 


GO
CREATE TRIGGER trUpdContactType ON [dbo].[ContactType] 
FOR UPDATE
AS
BEGIN TRAN
Delete s FROM [$(SolomonApp)].dbo.cftContactType s
JOIN Deleted d on 
s.ContactTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.ContactTypeID))))
	 + rtrim(convert(char(2),d.ContactTypeID)) 

Insert into [$(SolomonApp)].dbo.cftContactType
(ContactTypeID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select
ContactTypeID=replicate('0',2-len(rtrim(convert(char(2),ContactTypeID)))) + rtrim(convert(char(2),ContactTypeID)),
getdate(),'','SYSADMIN',
isnull(ContactTypeDescription,''),
getdate(),'','SYSADMIN'
FROM Inserted

COMMIT TRAN
