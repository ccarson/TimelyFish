CREATE TABLE [dbo].[SiteBio] (
    [ContactID]        INT          NOT NULL,
    [SiteID]           VARCHAR (4)  NOT NULL,
    [BioSecurityLevel] VARCHAR (20) NULL,
    [Challenge]        VARCHAR (40) NULL,
    [Crtd_DateTime]    DATETIME     NOT NULL,
    [Crtd_User]        VARCHAR (50) NOT NULL,
    [Lupd_DateTime]    DATETIME     NULL,
    [Lupd_User]        VARCHAR (50) NULL,
    CONSTRAINT [PK_SiteBio] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SiteBio_Contact] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE
);


GO

CREATE TRIGGER [dbo].[trDelSiteBio] ON [dbo].[SiteBio] 
	FOR DELETE
	AS
		Delete [$(SolomonApp)].dbo.cftSiteBio FROM [$(SolomonApp)].dbo.cftSiteBio s
		JOIN Deleted d on 
		s.ContactID=
		replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
			 + rtrim(convert(char(6),d.ContactID))

GO
     
-- Now update the siteBio table triggers to keep the  site table biosecuritylevel field updated
CREATE TRIGGER [dbo].[trInsSiteBio] ON  [dbo].[SiteBio] 
	FOR INSERT
	AS
	Begin Tran
		Update  dbo.Site
			set biosecuritylevel = ins.biosecuritylevel
		from  dbo.Site s
		inner join inserted ins on ins.contactid=s.contactid and ins.siteid=s.siteid
		
		Insert into [$(SolomonApp)].dbo.cftSiteBio
		([ContactID], [SiteID], [BioSecurityLevel],	Challenge, Crtd_DateTime, Crtd_User, Lupd_DateTime, Lupd_User)
		Select 
		ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
		isnull(SiteID,''),
		isnull([BioSecurityLevel],''),
		isnull(Challenge,''), Crtd_DateTime, Crtd_User, 
		isnull(Lupd_DateTime,'01/01/1900'), isnull(Lupd_User,'')
		From Inserted s
	Commit Tran

GO

CREATE TRIGGER [dbo].[trUpdSiteBio] ON  [dbo].[SiteBio] 
	FOR UPDATE
	AS
	BEGIN TRAN
		Update  dbo.Site
			set biosecuritylevel = ins.biosecuritylevel
		from  dbo.Site s
		inner join inserted ins on ins.contactid=s.contactid and ins.siteid=s.siteid
		
		Delete [$(SolomonApp)].dbo.cftSiteBio FROM [$(SolomonApp)].dbo.cftSiteBio s
		JOIN Deleted d on 
		s.ContactID=
		replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
			 + rtrim(convert(char(6),d.ContactID)) 


		Insert into [$(SolomonApp)].dbo.cftSiteBio
		([ContactID], [SiteID], [BioSecurityLevel],	Challenge, Crtd_DateTime, Crtd_User, Lupd_DateTime, Lupd_User)
		Select 
		ContactID=replicate('0',6-len(rtrim(convert(char(6),ContactID)))) + rtrim(convert(char(6),ContactID)),
		isnull(SiteID,''),
		isnull([BioSecurityLevel],''),
		isnull(Challenge,''), Crtd_DateTime, Crtd_User,
		isnull(Lupd_DateTime,'01/01/1900'), isnull(Lupd_User,'')
		From Inserted s
	COMMIT TRAN

GO
GRANT SELECT
    ON OBJECT::[dbo].[SiteBio] TO [hybridconnectionlogin_permissions]
    AS [dbo];

