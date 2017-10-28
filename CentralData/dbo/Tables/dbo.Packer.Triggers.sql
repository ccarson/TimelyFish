CREATE  TRIGGER trInsPacker ON [dbo].[Packer] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftPacker
(CertFlg,ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Culls,CustID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
MaxNbrLoads,PrimaryPacker,TimeBetweenLoads,TrackTotals,
TrkPaidFlg
)
Select 
0,ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
isnull(Culls,0),isnull(CustID,''),

getdate(),'','SYSADMIN',

isnull(MaxNbrLoads,0),0,isnull(TimeBetweenLoads,0),isnull(TrackTotals,0),
isnull(TrkPaidFlg,0)
		FROM Inserted


GO
CREATE TRIGGER trDelPacker ON [dbo].[Packer] 
FOR DELETE
AS
Delete a
FROM [$(SolomonApp)].dbo.cftPacker a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

GO

CREATE  TRIGGER trUpdPacker ON [dbo].[Packer] 
FOR UPDATE
AS
BEGIN TRAN
Delete a
FROM [$(SolomonApp)].dbo.cftPacker a
JOIN Deleted d on 
a.ContactID=replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID))

Insert into [$(SolomonApp)].dbo.cftPacker
(CertFlg,ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Culls,CustID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
MaxNbrLoads,PrimaryPacker,TimeBetweenLoads,TrackTotals,
TrkPaidFlg
)
Select 
0,ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
isnull(Culls,0),isnull(CustID,''),

getdate(),'','SYSADMIN',

isnull(MaxNbrLoads,0),0,isnull(TimeBetweenLoads,0),isnull(TrackTotals,0),
isnull(TrkPaidFlg,0)
		FROM Inserted


COMMIT TRAN

