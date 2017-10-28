CREATE TRIGGER trInsFuelSurcharge ON [dbo].[FuelSurcharge] 
FOR INSERT
AS
Insert into SolomonApp.dbo.cftFuelSurcharge
(Crtd_DateTime,Crtd_Prog,Crtd_User,
High,Low,
Lupd_DateTime,Lupd_Prog,Lupd_User,
Rate
)
Select 
getdate(),'','SYSADMIN',
isnull(High,0),isnull(Low,0),
getdate(),'','SYSADMIN',
isnull(Rate,0)

	FROM Inserted

GO
CREATE TRIGGER trDelFuelSurcharge ON [dbo].[FuelSurcharge] 
FOR DELETE
AS
Delete SolomonApp.dbo.cftFuelSurcharge
FROM SolomonApp.dbo.cftFuelSurcharge a
JOIN Deleted d on 
a.Low=d.Low and a.High=d.High

GO
CREATE TRIGGER trUpdFuelSurcharge ON [dbo].[FuelSurcharge] 
FOR UPDATE
AS
BEGIN TRAN
Delete SolomonApp.dbo.cftFuelSurcharge
FROM SolomonApp.dbo.cftFuelSurcharge a
JOIN Deleted d on 
a.Low=d.Low and a.High=d.High

Insert into SolomonApp.dbo.cftFuelSurcharge
(Crtd_DateTime,Crtd_Prog,Crtd_User,
High,Low,
Lupd_DateTime,Lupd_Prog,Lupd_User,
Rate
)
Select 
getdate(),'','SYSADMIN',
isnull(High,0),isnull(Low,0),
getdate(),'','SYSADMIN',
isnull(Rate,0)
	FROM Inserted


COMMIT TRAN

