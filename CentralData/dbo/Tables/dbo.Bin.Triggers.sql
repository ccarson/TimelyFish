CREATE TRIGGER trInsBin ON [dbo].[Bin] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftBin
(Active,BarnNbr,BinNbr,BinSortOrder,BinTypeID,ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,FeedingLevel,
Lupd_DateTime,Lupd_Prog,Lupd_User,RoomNbr
)
Select 
isnull(bin.Active,0),isnull(b.BarnNbr,''),isnull(cast(bin.BinNbr as varchar(6)),''),isnull(bin.BinSortOrder,0),
	BinTypeID=Case when bin.BinTypeID is null then '' else replicate('0',3-len(rtrim(convert(char(3),bin.BinTypeID))))
	 + rtrim(convert(char(3),bin.BinTypeID)) end ,
ContactID=replicate('0',6-len(rtrim(convert(char(6),bin.ContactID))))
	 + rtrim(convert(char(6),bin.ContactID)),
getdate(),'','SYSADMIN',isnull(bin.FeedingLevel,''),
getdate(),'','SYSADMIN',isnull(r.RoomNbr,'')

	FROM Inserted bin
	LEFT OUTER JOIN  dbo.Barn b on bin.BarnID=b.BarnID
	LEFT OUTER JOIN  dbo.Room r on bin.RoomID=r.RoomID

GO
CREATE TRIGGER trDelBin ON [dbo].[Bin] 
FOR DELETE
AS
Delete  [$(SolomonApp)].dbo.cftBin 
FROM [$(SolomonApp)].dbo.cftBin b

JOIN Deleted d on b.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and b.BinNbr=convert(char(6),d.BinNbr)

GO
CREATE TRIGGER trUpdBin ON [dbo].[Bin] 
FOR UPDATE
AS
BEGIN TRAN

Delete  [$(SolomonApp)].dbo.cftBin 
FROM [$(SolomonApp)].dbo.cftBin b

JOIN Deleted d on b.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))
and b.BinNbr=convert(char(6),d.BinNbr)


Insert into [$(SolomonApp)].dbo.cftBin
(Active,BarnNbr,BinNbr,BinSortOrder,BinTypeID,ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,FeedingLevel,
Lupd_DateTime,Lupd_Prog,Lupd_User,RoomNbr
)
Select 
isnull(bin.Active,0),isnull(b.BarnNbr,''),isnull(cast(bin.BinNbr as varchar(6)),''),isnull(bin.BinSortOrder,0),
	BinTypeID=Case when bin.BinTypeID is null then '' else replicate('0',3-len(rtrim(convert(char(3),bin.BinTypeID))))
	 + rtrim(convert(char(3),bin.BinTypeID)) end,
ContactID=replicate('0',6-len(rtrim(convert(char(6),bin.ContactID))))
	 + rtrim(convert(char(6),bin.ContactID)),
getdate(),'','SYSADMIN',isnull(bin.FeedingLevel,''),
getdate(),'','SYSADMIN',isnull(r.RoomNbr,'')

	FROM Inserted bin
	LEFT OUTER JOIN  dbo.Barn b on bin.BarnID=b.BarnID
	LEFT OUTER JOIN  dbo.Room r on bin.RoomID=r.RoomID

COMMIT TRAN
