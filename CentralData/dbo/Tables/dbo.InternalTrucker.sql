CREATE TABLE [dbo].[InternalTrucker] (
    [ContactID]           INT      NOT NULL,
    [DefaultPigTrailerID] INT      NULL,
    [StatusTypeID]        INT      CONSTRAINT [DF_InternalTrucker_StatusTypeID] DEFAULT (1) NULL,
    [TrackMiles]          SMALLINT NULL,
    CONSTRAINT [PK_InternalTrucker] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsInternalTrucker ON [dbo].[InternalTrucker] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftInternalTrucker
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
DefaultPigTrailerID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
StatusTypeID,TrackMiles
)
Select 
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
case when DefaultPigTrailerID is null then '' else replicate('0',3-len(rtrim(convert(char(3),DefaultPigTrailerID))))
	 + rtrim(convert(char(3),DefaultPigTrailerID)) end,
getdate(),'','SYSADMIN',
isnull(StatusTypeID,0),isnull(TrackMiles,0)

	FROM Inserted

GO
CREATE TRIGGER trDelInternalTrucker ON [dbo].[InternalTrucker] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftInternalTrucker
FROM [$(SolomonApp)].dbo.cftInternalTrucker a
JOIN Deleted d on 
a.ContactID=d.ContactID

GO
CREATE TRIGGER trUpdInternalTrucker ON [dbo].[InternalTrucker] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftInternalTrucker
FROM [$(SolomonApp)].dbo.cftInternalTrucker a
JOIN Deleted d on 
a.ContactID=d.ContactID

Insert into [$(SolomonApp)].dbo.cftInternalTrucker
(ContactID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
DefaultPigTrailerID,
Lupd_DateTime,Lupd_Prog,Lupd_User,
StatusTypeID,TrackMiles
)
Select 
ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID))))
	 + rtrim(convert(char(6),ContactID)),
getdate(),'','SYSADMIN',
case when DefaultPigTrailerID is null then '' else replicate('0',3-len(rtrim(convert(char(3),DefaultPigTrailerID))))
	 + rtrim(convert(char(3),DefaultPigTrailerID)) end,
getdate(),'','SYSADMIN',
isnull(StatusTypeID,0),isnull(TrackMiles,0)
	FROM Inserted


COMMIT TRAN

