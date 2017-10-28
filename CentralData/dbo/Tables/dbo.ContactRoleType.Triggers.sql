CREATE TRIGGER trInsContactRoleType ON [dbo].[ContactRoleType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftContactRoleType
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User,
RoleTypeID
)
Select
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',getdate(),'','SYSADMIN',
RoleTypeID=replicate('0',3-len(rtrim(convert(char(3),RoleTypeID)))) + rtrim(convert(char(3),RoleTypeID))
FROM Inserted


GO
CREATE TRIGGER trDelContactRoleType ON [dbo].[ContactRoleType] 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftContactRoleType s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 
and 
s.RoleTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.RoleTypeID))))
	 + rtrim(convert(char(3),d.RoleTypeID)) 
 


GO
CREATE TRIGGER trUpdContactRoleType ON [dbo].[ContactRoleType] 
FOR UPDATE
AS
BEGIN TRAN
Delete s FROM [$(SolomonApp)].dbo.cftContactRoleType s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 
and 
s.RoleTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.RoleTypeID))))
	 + rtrim(convert(char(3),d.RoleTypeID)) 

Insert into [$(SolomonApp)].dbo.cftContactRoleType
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User,
RoleTypeID
)
Select
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',getdate(),'','SYSADMIN',
RoleTypeID=replicate('0',3-len(rtrim(convert(char(3),RoleTypeID)))) + rtrim(convert(char(3),RoleTypeID))
FROM Inserted

COMMIT TRAN
