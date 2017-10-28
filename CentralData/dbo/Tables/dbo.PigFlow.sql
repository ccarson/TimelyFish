CREATE TABLE [dbo].[PigFlow] (
    [PigFlowID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]    VARCHAR (50) NULL,
    [OrderCode]      INT          NULL,
    [MovementSystem] SMALLINT     NULL,
    CONSTRAINT [PK_PigFlow] PRIMARY KEY CLUSTERED ([PigFlowID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsPigFlow ON [dbo].[PigFlow] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftPigFlow
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User,
OrderCode,
PigFlowID,
ProductionSystemID
)
Select

getdate(),'','SYSADMIN',
isnull(convert(varchar(30),Description),''),
getdate(),'','SYSADMIN',
isnull(OrderCode,0),
PigFlowID=replicate('0',3-len(rtrim(convert(char(3),PigFlowID)))) + rtrim(convert(char(3),PigFlowID)),
ProductionSystemID=replicate('0',2-len(rtrim(convert(char(2),MovementSystem)))) + rtrim(convert(char(2),MovementSystem))
FROM Inserted


GO
CREATE TRIGGER trDelPigFlow ON [dbo].[PigFlow] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftPigFlow FROM [$(SolomonApp)].dbo.cftPigFlow s
JOIN Deleted d on 
s.PigFlowID=
replicate('0',3-len(rtrim(convert(char(3),d.PigFlowID))))
	 + rtrim(convert(char(3),d.PigFlowID)) 

 


GO
CREATE TRIGGER trUpdPigFlow ON [dbo].[PigFlow] 
FOR UPDATE
AS
BEGIN TRAN

Delete [$(SolomonApp)].dbo.cftPigFlow FROM [$(SolomonApp)].dbo.cftPigFlow s
JOIN Deleted d on 
s.PigFlowID=
replicate('0',3-len(rtrim(convert(char(3),d.PigFlowID))))
	 + rtrim(convert(char(3),d.PigFlowID))  

Insert into [$(SolomonApp)].dbo.cftPigFlow
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
Lupd_DateTime,Lupd_Prog,Lupd_User,
OrderCode,
PigFlowID,
ProductionSystemID
)
Select

getdate(),'','SYSADMIN',
isnull(convert(varchar(30),Description),''),
getdate(),'','SYSADMIN',
isnull(OrderCode,0),
PigFlowID=replicate('0',3-len(rtrim(convert(char(3),PigFlowID)))) + rtrim(convert(char(3),PigFlowID)),
ProductionSystemID=replicate('0',2-len(rtrim(convert(char(2),MovementSystem)))) + rtrim(convert(char(2),MovementSystem))
FROM Inserted

COMMIT TRAN
