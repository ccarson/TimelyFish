CREATE TABLE [dbo].[GeneratorType] (
    [GeneratorTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GeneratorTypeDescription] VARCHAR (15) NOT NULL,
    CONSTRAINT [PK_GeneratorType] PRIMARY KEY CLUSTERED ([GeneratorTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsGeneratorType ON [dbo].[GeneratorType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftGeneratorType
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
GeneratorTypeID,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select

getdate(),'','SYSADMIN',
isnull(GeneratorTypeDescription,''),
GeneratorTypeID=replicate('0',2-len(rtrim(convert(char(2),GeneratorTypeID)))) + rtrim(convert(char(2),GeneratorTypeID)),
getdate(),'','SYSADMIN'
FROM Inserted


GO
CREATE TRIGGER trDelGeneratorType ON [dbo].[GeneratorType] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftGeneratorType FROM [$(SolomonApp)].dbo.cftGeneratorType s
JOIN Deleted d on 
s.GeneratorTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.GeneratorTypeID))))
	 + rtrim(convert(char(2),d.GeneratorTypeID)) 

 


GO
CREATE TRIGGER trUpdGeneratorType ON [dbo].[GeneratorType] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftGeneratorType FROM [$(SolomonApp)].dbo.cftGeneratorType s
JOIN Deleted d on 
s.GeneratorTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.GeneratorTypeID))))
	 + rtrim(convert(char(2),d.GeneratorTypeID)) 

Insert into [$(SolomonApp)].dbo.cftGeneratorType
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
GeneratorTypeID,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select

getdate(),'','SYSADMIN',
isnull(GeneratorTypeDescription,''),
GeneratorTypeID=replicate('0',2-len(rtrim(convert(char(2),GeneratorTypeID)))) + rtrim(convert(char(2),GeneratorTypeID)),
getdate(),'','SYSADMIN'
FROM Inserted

COMMIT TRAN
