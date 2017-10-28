CREATE TABLE [dbo].[PigSupplier] (
    [ContactID] INT NOT NULL,
    CONSTRAINT [PK_PigSupplier] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsPigSupplier ON [dbo].[PigSupplier] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftPigSupplier
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN'
	FROM Inserted

GO
CREATE TRIGGER trDelPigSupplier ON [dbo].[PigSupplier] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftPigSupplier
FROM [$(SolomonApp)].dbo.cftPigSupplier a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

GO
CREATE TRIGGER trUpdPigSupplier ON [dbo].[PigSupplier] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftPigSupplier
FROM [$(SolomonApp)].dbo.cftPigSupplier a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

Insert into [$(SolomonApp)].dbo.cftPigSupplier
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN'
	FROM Inserted


COMMIT TRAN

