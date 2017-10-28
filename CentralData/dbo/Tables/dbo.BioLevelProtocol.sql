CREATE TABLE [dbo].[BioLevelProtocol] (
    [Department]       VARCHAR (20) NOT NULL,
    [Type]             VARCHAR (20) NOT NULL,
    [BioSecurityLevel] VARCHAR (20) NOT NULL,
    [Protocol]         VARCHAR (20) NOT NULL,
    [Crtd_DateTime]    DATETIME     NOT NULL,
    [Crtd_User]        VARCHAR (50) NOT NULL,
    [Lupd_DateTime]    DATETIME     NULL,
    [Lupd_User]        VARCHAR (50) NULL,
    [SortOrder]        SMALLINT     NULL,
    CONSTRAINT [PK_BioLevelProtocol] PRIMARY KEY CLUSTERED ([Department] ASC, [Type] ASC, [BioSecurityLevel] ASC) WITH (FILLFACTOR = 90)
);


GO

CREATE TRIGGER [dbo].[trDelBioLevelProtocol] ON [dbo].[BioLevelProtocol] 
	FOR DELETE
	AS
		Delete [$(SolomonApp)].dbo.cftBioLevelProtocol FROM [$(SolomonApp)].dbo.cftBioLevelProtocol s
		JOIN Deleted d on 
		s.Department=d.Department and s.Type=d.Type and s.BioSecurityLevel=d.BioSecurityLevel


GO

CREATE  TRIGGER [dbo].[trInsBioLevelProtocol] ON [dbo].[BioLevelProtocol] 
	FOR INSERT
	AS
		Insert into [$(SolomonApp)].dbo.cftBioLevelProtocol
		(Department, [Type], [BioSecurityLevel], [Protocol],
		Crtd_DateTime, Crtd_User, Lupd_DateTime, Lupd_User, SortOrder)
		Select Department, [Type], [BioSecurityLevel], [Protocol], Crtd_DateTime, Crtd_User,
		isnull(Lupd_DateTime,'01/01/1900'), isnull(Lupd_User,''), SortOrder
		From Inserted s


GO

CREATE  TRIGGER [dbo].[trUpdBioLevelProtocol] ON [dbo].[BioLevelProtocol] 
	FOR UPDATE
	AS
	BEGIN TRAN
		Delete [$(SolomonApp)].dbo.cftBioLevelProtocol FROM [$(SolomonApp)].dbo.cftBioLevelProtocol s
		JOIN Deleted d on 
		s.Department=d.Department and s.Type=d.Type and s.BioSecurityLevel=d.BioSecurityLevel

		Insert into [$(SolomonApp)].dbo.cftBioLevelProtocol
		(Department, [Type], [BioSecurityLevel], [Protocol],
		Crtd_DateTime, Crtd_User, Lupd_DateTime, Lupd_User, SortOrder)
		Select Department, [Type], [BioSecurityLevel], [Protocol], Crtd_DateTime, Crtd_User,
		isnull(Lupd_DateTime,'01/01/1900'), isnull(Lupd_User,''), SortOrder
		From Inserted s
	COMMIT TRAN

