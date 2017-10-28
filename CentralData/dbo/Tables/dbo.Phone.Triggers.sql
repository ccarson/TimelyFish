CREATE TRIGGER 
	dbo.trInsPhone ON [dbo].[Phone] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftPhone
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Extension,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PhoneID,
PhoneNbr,SpeedDial
)
Select 
getdate(),'','SYSADMIN',
isnull(convert(varchar(10),Extension),''),
getdate(),'','SYSADMIN',
PhoneID=replicate('0',6-len(rtrim(convert(char(6),PhoneID))))
	 + rtrim(convert(char(6),PhoneID)),
isnull(PhoneNbr,0),
isnull(convert(varchar(6),SpeedDial),'')
	FROM Inserted

GO
CREATE TRIGGER 
	dbo.trDelPhone ON [dbo].[Phone] 
FOR DELETE
AS
Delete a
FROM [$(SolomonApp)].dbo.cftPhone a
JOIN Deleted d on 
a.PHoneID=replicate('0',6-len(rtrim(convert(char(6),d.PhoneID))))
	 + rtrim(convert(char(6),d.PhoneID))

GO
CREATE TRIGGER 
	dbo.trUpdPhone ON [dbo].[Phone] 
FOR UPDATE
AS
BEGIN TRAN
Delete a
FROM [$(SolomonApp)].dbo.cftPhone a
JOIN Deleted d on 
a.PHoneID=replicate('0',6-len(rtrim(convert(char(6),d.PhoneID))))
	 + rtrim(convert(char(6),d.PhoneID))

Insert into [$(SolomonApp)].dbo.cftPhone
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Extension,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PhoneID,
PhoneNbr,SpeedDial
)
Select 
getdate(),'','SYSADMIN',
isnull(convert(varchar(10),Extension),''),
getdate(),'','SYSADMIN',
PhoneID=replicate('0',6-len(rtrim(convert(char(6),PhoneID))))
	 + rtrim(convert(char(6),PhoneID)),
isnull(PhoneNbr,0),
isnull(convert(varchar(6),SpeedDial),'')
	FROM Inserted

COMMIT TRAN
