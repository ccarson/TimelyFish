CREATE TRIGGER trInsContactPhone ON [dbo].[ContactPhone] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftContactPhone
(Comment, PhoneID,
PhoneTypeID,
ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
isnull(Comment,''),PhoneID=replicate('0',6-len(rtrim(convert(char(6),PhoneID)))) + rtrim(convert(char(6),PhoneID)),
PhoneTypeID=replicate('0',3-len(rtrim(convert(char(3),PhoneTypeID)))) + rtrim(convert(char(3),PhoneTypeID)),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',getdate(),'','SYSADMIN'
FROM Inserted


GO
CREATE TRIGGER trDelContactPhone ON [dbo].[ContactPhone] 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftContactPhone s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 
and 
s.PhoneID=
replicate('0',6-len(rtrim(convert(char(6),d.PhoneID))))
	 + rtrim(convert(char(6),d.PhoneID)) 
and
s.PhoneTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.PhoneTypeID))))
	 + rtrim(convert(char(3),d.PhoneTypeID)) 


GO
CREATE TRIGGER trUpdContactPhone ON [dbo].[ContactPhone] 
FOR UPDATE
AS
BEGIN TRAN
Delete s FROM [$(SolomonApp)].dbo.cftContactPhone s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 
and 
s.PhoneID=
replicate('0',6-len(rtrim(convert(char(6),d.PhoneID))))
	 + rtrim(convert(char(6),d.PhoneID)) 
and
s.PhoneTypeID=
replicate('0',3-len(rtrim(convert(char(3),d.PhoneTypeID))))
	 + rtrim(convert(char(3),d.PhoneTypeID))

Insert into [$(SolomonApp)].dbo.cftContactPhone
(Comment, PhoneID,
PhoneTypeID,
ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
isnull(Comment,''),PhoneID=replicate('0',6-len(rtrim(convert(char(6),PhoneID)))) + rtrim(convert(char(6),PhoneID)),
PhoneTypeID=replicate('0',3-len(rtrim(convert(char(3),PhoneTypeID)))) + rtrim(convert(char(3),PhoneTypeID)),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',getdate(),'','SYSADMIN'
FROM Inserted

COMMIT TRAN
