CREATE TABLE [dbo].[MarketTrucker] (
    [MarketTruckerID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]        INT          NULL,
    [TruckNbr]         VARCHAR (4)  NULL,
    [PigTrailerTypeID] INT          NULL,
    [StatusTypeID]     INT          CONSTRAINT [DF_MarketTrucker_StatusID] DEFAULT (1) NULL,
    [VendID]           VARCHAR (15) NULL,
    CONSTRAINT [PK_MarketTrucker_1] PRIMARY KEY CLUSTERED ([MarketTruckerID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsMarketTrucker ON [dbo].[MarketTrucker] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftMarketTrucker
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
MarketTruckerID,PigTrailerTypeID,
StatusTypeID,TruckNbr,VendID
)
Select

ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',
MarketTruckerID=replicate('0',6-len(rtrim(convert(char(6),MarketTruckerID)))) + rtrim(convert(char(6),MarketTruckerID)),
case when PigTrailerTypeID is null then '' else replicate('0',2-len(rtrim(convert(char(2),PigTrailerTypeID)))) + rtrim(convert(char(2),PigTrailerTypeID)) end,
isnull(StatusTypeID,0),isnull(TruckNbr,''), isnull(VendID,'')
FROM Inserted


GO
CREATE TRIGGER trDelMarketTrucker ON [dbo].[MarketTrucker] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftMarketTrucker FROM [$(SolomonApp)].dbo.cftMarketTrucker s
JOIN Deleted d on 
s.MarketTruckerID=
replicate('0',6-len(rtrim(convert(char(6),d.MarketTruckerID))))
	 + rtrim(convert(char(6),d.MarketTruckerID)) 

 


GO
CREATE TRIGGER trUpdMarketTrucker ON [dbo].[MarketTrucker] 
FOR UPDATE
AS
BEGIN TRAN

Delete [$(SolomonApp)].dbo.cftMarketTrucker FROM [$(SolomonApp)].dbo.cftMarketTrucker s
JOIN Deleted d on 
s.MarketTruckerID=
replicate('0',6-len(rtrim(convert(char(6),d.MarketTruckerID))))
	 + rtrim(convert(char(6),d.MarketTruckerID))  

Insert into [$(SolomonApp)].dbo.cftMarketTrucker
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
MarketTruckerID,PigTrailerTypeID,
StatusTypeID,TruckNbr,VendID
)
Select

ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
getdate(),'','SYSADMIN',
MarketTruckerID=replicate('0',6-len(rtrim(convert(char(6),MarketTruckerID)))) + rtrim(convert(char(6),MarketTruckerID)),
case when PigTrailerTypeID is null then '' else replicate('0',2-len(rtrim(convert(char(2),PigTrailerTypeID)))) + rtrim(convert(char(2),PigTrailerTypeID)) end,
isnull(StatusTypeID,0),isnull(TruckNbr,''),isnull(VendID,'')
FROM Inserted

COMMIT TRAN
