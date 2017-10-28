CREATE TABLE [dbo].[BarnStyle] (
    [BarnStyleID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BarnStyleDescription] VARCHAR (30) NOT NULL,
    [DefaultBarnLossValue] FLOAT (53)   NULL,
    CONSTRAINT [PK_BarnStyle] PRIMARY KEY CLUSTERED ([BarnStyleID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Description]
    ON [dbo].[BarnStyle]([BarnStyleDescription] ASC) WITH (FILLFACTOR = 90);


GO
CREATE TRIGGER dbo.trInsBarnStyle ON [dbo].[BarnStyle] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftBarnStyle
(BarnStyleID,Crtd_DateTime,Crtd_Prog,Crtd_User,DefaultBarnLossValue,
Description,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
BarnStyleID=replicate('0',2-len(rtrim(convert(char(2),BarnStyleID))))
	 + rtrim(convert(char(2),BarnStyleID)),GETDATE(),'','SYSADMIN',isnull(DefaultBarnLossValue,0),
isnull(BarnStyleDescription,''),GETDATE(),'','SYSADMIN'
	FROM Inserted

GO
CREATE TRIGGER trDelBarnStyle ON [dbo].[BarnStyle] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftBarnStyle FROM [$(SolomonApp)].dbo.cftBarnStyle b
JOIN Deleted d on 
b.BarnStyleID= 
replicate('0',2-len(rtrim(convert(char(2),d.BarnStyleID))))
	 + rtrim(convert(char(2),d.BarnStyleID)) 

GO
CREATE TRIGGER trUpdBarnStyle ON [dbo].[BarnStyle] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftBarnStyle FROM [$(SolomonApp)].dbo.cftBarnStyle b
JOIN Deleted d on 
b.BarnStyleID= 
replicate('0',2-len(rtrim(convert(char(2),d.BarnStyleID))))
	 + rtrim(convert(char(2),d.BarnStyleID)) 

Insert into [$(SolomonApp)].dbo.cftBarnStyle
(BarnStyleID,Crtd_DateTime,Crtd_Prog,Crtd_User,DefaultBarnLossValue,
Description,Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 
BarnStyleID=replicate('0',2-len(rtrim(convert(char(2),BarnStyleID))))
	 + rtrim(convert(char(2),BarnStyleID)),GETDATE(),'','SYSADMIN',isnull(DefaultBarnLossValue,0),
isnull(BarnStyleDescription,''),GETDATE(),'','SYSADMIN'
	FROM Inserted
COMMIT TRAN
