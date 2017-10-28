CREATE TRIGGER [dbo].[trInsAddress] ON [dbo].[Address] 
FOR INSERT
AS

Begin tran

Insert into [$(SolomonApp)].dbo.cftAddress
(Address1,Address2,AddressID,City,Country,County,
Crtd_DateTime,Crtd_Prog,Crtd_User,Latitude,Longitude,
Lupd_DateTime,Lupd_Prog,Lupd_User,Range,SectionNbr,State,TempID,Township,Zip
)
Select isnull(Address1,''),isnull(Address2,''),
AddressID=replicate('0',6-len(rtrim(convert(char(6),AddressID))))
	 + rtrim(convert(char(6),AddressID)),isnull(City,''),isnull(Country,''), isnull(County,''),
GetDate(),'','SYSADMIN',isnull(latitude,0),isnull(longitude,0),
getdate(),'','SYSADMIN',isnull(Range,''),isnull(SectionNbr,''),isnull(State,''),isnull(TempID,''),
isnull(Township,''),isnull(zip,'')
	FROM Inserted
	
Insert into dbo.cft_Address_attrib
(AddressID, georef
)
Select AddressID, geography::STGeomFromText ('POINT (' + CAST ([Longitude] AS VARCHAR (20)) + ' ' +CAST ([Latitude] AS VARCHAR (20)) + ')', 4326) as georef
	FROM Inserted
	
	
commit tran



GO
CREATE TRIGGER trDelAddress ON [dbo].[Address] 
FOR DELETE
AS
Delete a
FROM [$(SolomonApp)].dbo.cftAddress a
JOIN Deleted d on 
a.AddressID=replicate('0',6-len(rtrim(convert(char(6),d.AddressID))))
	 + rtrim(convert(char(6),d.AddressID))

GO


CREATE TRIGGER [dbo].[trUpdAddress] ON [dbo].[Address] 
FOR UPDATE
AS
BEGIN TRAN
Delete a
FROM [$(SolomonApp)].dbo.cftAddress a
JOIN Deleted d on 
a.AddressID=replicate('0',6-len(rtrim(convert(char(6),d.AddressID))))
	 + rtrim(convert(char(6),d.AddressID))

Insert into [$(SolomonApp)].dbo.cftAddress
(Address1,Address2,AddressID,City,Country,County,
Crtd_DateTime,Crtd_Prog,Crtd_User,Latitude,Longitude,
Lupd_DateTime,Lupd_Prog,Lupd_User,Range,SectionNbr,State,TempID,Township,Zip
)
Select isnull(Address1,''),isnull(Address2,''),
AddressID=replicate('0',6-len(rtrim(convert(char(6),AddressID))))
	 + rtrim(convert(char(6),AddressID)),isnull(City,''),isnull(Country,''), isnull(County,''),
GetDate(),'','SYSADMIN',isnull(latitude,0),isnull(longitude,0),
getdate(),'','SYSADMIN',isnull(Range,''),isnull(SectionNbr,''),isnull(State,''),isnull(TempID,''),
isnull(Township,''),isnull(zip,'')
	FROM Inserted

IF UPDATE(Latitude) or UPDATE(Longitude)
BEGIN
Delete  dbo.MilesMatrix from  dbo.MilesMatrix m
JOIN Inserted i on m.AddressIDFrom=i.AddressID and isnull(m.OverRide,0)=0

UPDATE [dbo].[cft_Address_attrib] 
SET GeoRef = geography::STGeomFromText ('POINT (' + CAST ([Longitude] AS VARCHAR (20)) + ' ' +CAST ([Latitude] AS VARCHAR (20)) + ')', 4326)
from [dbo].[cft_Address_attrib] A (nolock)
  inner join inserted I on I.addressid = A.addressid

END



COMMIT TRAN
