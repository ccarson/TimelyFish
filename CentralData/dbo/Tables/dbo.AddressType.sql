CREATE TABLE [dbo].[AddressType] (
    [AddressTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]   VARCHAR (30) NULL,
    CONSTRAINT [PK_AddressTyoe] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsAddressType ON [dbo].[AddressType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftAddressType
(AddressTypeID,Crtd_DateTime,Crtd_Prog,Crtd_User,Description,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
AddressTypeID=replicate('0',2-len(rtrim(convert(char(2),AddressTypeID))))
	 + rtrim(convert(char(2),AddressTypeID)),
GetDate(),'','SYSADMIN',isnull(Description,''),
getdate(),'','SYSADMIN'
	FROM Inserted

GO
CREATE TRIGGER trDelAddressType ON [dbo].[AddressType] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftAddressType 
FROM [$(SolomonApp)].dbo.cftAddressType a
JOIN Deleted d on 
a.AddressTypeID=replicate('0',2-len(rtrim(convert(char(2),d.AddressTypeID))))
	 + rtrim(convert(char(2),d.AddressTypeID)) 

GO
CREATE TRIGGER trUpdAddressType ON [dbo].[AddressType] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftAddressType 
FROM [$(SolomonApp)].dbo.cftAddressType a
JOIN Deleted d on 
a.AddressTypeID=replicate('0',2-len(rtrim(convert(char(2),d.AddressTypeID))))
	 + rtrim(convert(char(2),d.AddressTypeID)) 

Insert into [$(SolomonApp)].dbo.cftAddressType
(AddressTypeID,Crtd_DateTime,Crtd_Prog,Crtd_User,Description,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
AddressTypeID=replicate('0',2-len(rtrim(convert(char(2),AddressTypeID))))
	 + rtrim(convert(char(2),AddressTypeID)),
GetDate(),'','SYSADMIN',isnull(Description,''),
getdate(),'','SYSADMIN'
	FROM Inserted
COMMIT TRAN

GO
GRANT SELECT
    ON OBJECT::[dbo].[AddressType] TO [hybridconnectionlogin_permissions]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Orientation', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType', @level2type = N'COLUMN', @level2name = N'AddressTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType', @level2type = N'COLUMN', @level2name = N'AddressTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType', @level2type = N'COLUMN', @level2name = N'AddressTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AddressType', @level2type = N'COLUMN', @level2name = N'Description';

