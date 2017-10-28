CREATE TRIGGER trInsContactAddress ON [dbo].[ContactAddress] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftContactAddress
(AddressID,
AddressTypeID,
ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
AddressID=replicate('0',6-len(rtrim(convert(char(6),AddressID)))) + rtrim(convert(char(6),AddressID)),
AddressTypeID=replicate('0',2-len(rtrim(convert(char(2),AddressTypeID)))) + rtrim(convert(char(2),AddressTypeID)),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',getdate(),'','SYSADMIN'
FROM Inserted


GO
CREATE TRIGGER trDelContactAddress ON [dbo].[ContactAddress] 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftContactAddress s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 
and 
s.AddressID=
replicate('0',6-len(rtrim(convert(char(6),d.AddressID))))
	 + rtrim(convert(char(6),d.AddressID)) 
and
s.AddressTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.AddressTypeID))))
	 + rtrim(convert(char(2),d.AddressTypeID)) 


GO
CREATE TRIGGER trUpdContactAddress ON [dbo].[ContactAddress] 
FOR UPDATE
AS
BEGIN TRAN
Delete s FROM [$(SolomonApp)].dbo.cftContactAddress s
JOIN Deleted d on 
s.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) 
and 
s.AddressID=
replicate('0',6-len(rtrim(convert(char(6),d.AddressID))))
	 + rtrim(convert(char(6),d.AddressID)) 
and
s.AddressTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.AddressTypeID))))
	 + rtrim(convert(char(2),d.AddressTypeID))

Insert into [$(SolomonApp)].dbo.cftContactAddress
(AddressID,
AddressTypeID,
ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
AddressID=replicate('0',6-len(rtrim(convert(char(6),AddressID)))) + rtrim(convert(char(6),AddressID)),
AddressTypeID=replicate('0',2-len(rtrim(convert(char(2),AddressTypeID)))) + rtrim(convert(char(2),AddressTypeID)),
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',getdate(),'','SYSADMIN'
FROM Inserted

COMMIT TRAN
