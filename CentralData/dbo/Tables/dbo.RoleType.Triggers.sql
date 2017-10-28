CREATE TRIGGER 
	dbo.trInsRoleType ON [dbo].[RoleType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftRoleType
	(Crtd_DateTime,Crtd_Prog,Crtd_User,Description,Lupd_DateTime,Lupd_Prog,Lupd_User,RoleTypeID)
	Select getdate(),'','SYSADMIN',RoleTypeDescription,getdate(),'','SYSADMIN',
	RoleTypeID=replicate('0',3-len(rtrim(convert(char(3),RoleTypeID))))
	 + rtrim(convert(char(3),RoleTypeID))
	FROM Inserted

GO
CREATE TRIGGER 
	dbo.trDelRoleType ON [dbo].[RoleType] 
FOR DELETE
AS
Delete r FROM [$(SolomonApp)].dbo.cftRoleType r
JOIN Deleted d on 
r.RoleTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.RoleTypeID))))
	 + rtrim(convert(char(3),d.RoleTypeID))

GO
CREATE TRIGGER trUpdRoleType ON [dbo].[RoleType] 
FOR UPDATE
AS
BEGIN TRAN
Delete r FROM [$(SolomonApp)].dbo.cftRoleType r
JOIN Deleted d on 
r.RoleTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.RoleTypeID))))
	 + rtrim(convert(char(3),d.RoleTypeID))

Insert into [$(SolomonApp)].dbo.cftRoleType
	(Crtd_DateTime,Crtd_Prog,Crtd_User,Description,Lupd_DateTime,Lupd_Prog,Lupd_User,RoleTypeID)
	Select getdate(),'','SYSADMIN',RoleTypeDescription,getdate(),'','SYSADMIN',
	RoleTypeID=replicate('0',3-len(rtrim(convert(char(3),RoleTypeID))))
	 + rtrim(convert(char(3),RoleTypeID))
	FROM Inserted
COMMIT TRAN
