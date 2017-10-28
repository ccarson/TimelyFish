CREATE TRIGGER trInsMilesMatrix ON [dbo].[MilesMatrix] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftMilesMatrix
(AddressIDFrom,AddressIDTo,Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,OneWayHours,OneWayMiles,OneWayMilesTest,
OverRide,RestrictOneWayHours,RestrictOneWayMiles
)
Select 
case when AddressIDFrom is null then '' else
replicate('0',6-len(rtrim(convert(char(6),AddressIDFrom)))) + rtrim(convert(char(6),AddressIDFrom)) end,
case when AddressIDTo is null then '' else
replicate('0',6-len(rtrim(convert(char(6),AddressIDTo)))) + rtrim(convert(char(6),AddressIDTo)) end,
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',isnull(OneWayHours,0),
isnull(OneWayMiles,0),isnull(OneWayMilesTest,0),isnull(OverRide,0),isnull(RestrictOneWayHours,0),isnull(RestrictOneWayMiles,0)
FROM Inserted


GO
CREATE TRIGGER trDelMilesMatrix ON [dbo].[MilesMatrix] 
FOR DELETE
AS
Delete s FROM [$(SolomonApp)].dbo.cftMilesMatrix s
JOIN Deleted d on 
s.AddressIDFrom=
replicate('0',6-len(rtrim(convert(char(6),d.AddressIDFrom))))
	 + rtrim(convert(char(6),d.AddressIDFrom)) 
and s.AddressIDTo=
replicate('0',6-len(rtrim(convert(char(6),d.AddressIDTo))))
	 + rtrim(convert(char(6),d.AddressIDTo)) 

GO
CREATE TRIGGER trUpdMilesMatrix ON [dbo].[MilesMatrix] 
FOR UPDATE
AS
BEGIN TRAN
Delete s FROM [$(SolomonApp)].dbo.cftMilesMatrix s
JOIN Deleted d on 
s.AddressIDFrom=
replicate('0',6-len(rtrim(convert(char(6),d.AddressIDFrom))))
	 + rtrim(convert(char(6),d.AddressIDFrom)) 
and s.AddressIDTo=
replicate('0',6-len(rtrim(convert(char(6),d.AddressIDTo))))
	 + rtrim(convert(char(6),d.AddressIDTo)) 

Insert into [$(SolomonApp)].dbo.cftMilesMatrix
(AddressIDFrom,AddressIDTo,Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,OneWayHours,OneWayMiles,OneWayMilesTest,
OverRide,RestrictOneWayHours,RestrictOneWayMiles
)
Select 
case when AddressIDFrom is null then '' else
replicate('0',6-len(rtrim(convert(char(6),AddressIDFrom)))) + rtrim(convert(char(6),AddressIDFrom)) end,
case when AddressIDTo is null then '' else
replicate('0',6-len(rtrim(convert(char(6),AddressIDTo)))) + rtrim(convert(char(6),AddressIDTo)) end,
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',isnull(OneWayHours,0),
isnull(OneWayMiles,0),isnull(OneWayMilesTest,0),isnull(OverRide,0),isnull(RestrictOneWayHours,0),isnull(RestrictOneWayMiles,0)
FROM Inserted

COMMIT TRAN
