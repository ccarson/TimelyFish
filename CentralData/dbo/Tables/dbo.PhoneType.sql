CREATE TABLE [dbo].[PhoneType] (
    [PhoneTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description] VARCHAR (30) NULL,
    CONSTRAINT [PK_PhoneType] PRIMARY KEY CLUSTERED ([PhoneTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsPhoneType ON [dbo].[PhoneType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftPhoneType
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PhoneTypeID
)
Select 
getdate(),'','SYSADMIN',
isnull(Description,''),
getdate(),'','SYSADMIN',
PhoneTypeID=replicate('0',3-len(rtrim(convert(char(3),PhoneTypeID))))
	 + rtrim(convert(char(3),PhoneTypeID))
	FROM Inserted

GO
CREATE TRIGGER trDelPhoneType ON [dbo].[PhoneType] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftPhoneType
FROM [$(SolomonApp)].dbo.cftPhoneType a
JOIN Deleted d on 
a.PhoneTypeID=replicate('0',3-len(rtrim(convert(char(3),d.PhoneTypeID))))
	 + rtrim(convert(char(3),d.PhoneTypeID))

GO
CREATE TRIGGER trUpdPhoneType ON [dbo].[PhoneType] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftPhoneType
FROM [$(SolomonApp)].dbo.cftPhoneType a
JOIN Deleted d on 
a.PhoneTypeID=replicate('0',3-len(rtrim(convert(char(3),d.PhoneTypeID))))
	 + rtrim(convert(char(3),d.PhoneTypeID))

Insert into [$(SolomonApp)].dbo.cftPhoneType
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PhoneTypeID
)
Select 
getdate(),'','SYSADMIN',
isnull(Description,''),
getdate(),'','SYSADMIN',
PhoneTypeID=replicate('0',3-len(rtrim(convert(char(3),PhoneTypeID))))
	 + rtrim(convert(char(3),PhoneTypeID))
	FROM Inserted


COMMIT TRAN


GO
GRANT SELECT
    ON OBJECT::[dbo].[PhoneType] TO [hybridconnectionlogin_permissions]
    AS [dbo];

