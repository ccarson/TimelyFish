CREATE TRIGGER trInsBinType ON [dbo].[BinType] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftBinType
(BinCapacity,
BinTypeID,ConeConversion,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,Lupd_DateTime,
Lupd_Prog,Lupd_User,RingConversion
)
Select 
isnull(BinCapacity,0),
BinTypeID=replicate('0',3-len(rtrim(convert(char(3),BinTypeID)))) + rtrim(convert(char(3),BinTypeID)),
isnull(ConeConversion,0),
getdate(),'','SYSADMIN',
isnull(BinTypeDescription,''),getdate(),
'','SYSADMIN',isnull(RingConversion,0)
FROM Inserted


GO
CREATE TRIGGER trDelBinType ON [dbo].[BinType] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftBinType FROM [$(SolomonApp)].dbo.cftBinType s
JOIN Deleted d on 
s.BinTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.BinTypeID))))
	 + rtrim(convert(char(3),d.BinTypeID)) 


GO
CREATE TRIGGER trUpdBinType ON [dbo].[BinType] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftBinType FROM [$(SolomonApp)].dbo.cftBinType s
JOIN Deleted d on 
s.BinTypeID=
replicate('0',2-len(rtrim(convert(char(2),d.BinTypeID))))
	 + rtrim(convert(char(3),d.BinTypeID)) 

Insert into [$(SolomonApp)].dbo.cftBinType
(BinCapacity,
BinTypeID,ConeConversion,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,Lupd_DateTime,
Lupd_Prog,Lupd_User,RingConversion
)
Select 
isnull(BinCapacity,0),
BinTypeID=replicate('0',3-len(rtrim(convert(char(3),BinTypeID)))) + rtrim(convert(char(3),BinTypeID)),
isnull(ConeConversion,0),
getdate(),'','SYSADMIN',
isnull(BinTypeDescription,''),getdate(),
'','SYSADMIN',isnull(RingConversion,0)
FROM Inserted

COMMIT TRAN
