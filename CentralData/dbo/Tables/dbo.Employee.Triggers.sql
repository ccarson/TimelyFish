CREATE TRIGGER trInsEmployee ON [dbo].[Employee] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftEmployee
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,EmployeeID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
UserID
)
Select
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
isnull(EmployeeID,''),
getdate(),'','SYSADMIN',
isnull(UserID,'')
FROM Inserted


GO
CREATE TRIGGER trDelEmployee ON [dbo].[Employee] 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftEmployee s
JOIN Deleted d on 
s.ContactID=d.ContactID

 


GO
CREATE TRIGGER trUpdEmployee ON [dbo].[Employee] 
FOR UPDATE
AS
BEGIN TRAN

Delete s FROM [$(SolomonApp)].dbo.cftEmployee s
JOIN Deleted d on 
s.ContactID=d.ContactID

Insert into [$(SolomonApp)].dbo.cftEmployee
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,EmployeeID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
UserID
)
Select
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
isnull(EmployeeID,''),
getdate(),'','SYSADMIN',
isnull(UserID,'')
FROM Inserted

COMMIT TRAN

