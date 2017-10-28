CREATE TABLE [dbo].[smZipCode] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [ZipCity]       CHAR (30)     NOT NULL,
    [ZipCounty]     CHAR (30)     NOT NULL,
    [ZipDesc]       CHAR (30)     NOT NULL,
    [ZipId]         CHAR (10)     NOT NULL,
    [ZipMapCoord]   CHAR (10)     NOT NULL,
    [ZipMapPage]    SMALLINT      NOT NULL,
    [ZipState]      CHAR (3)      NOT NULL,
    [ZipTaxId]      CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smZipCode0] PRIMARY KEY CLUSTERED ([ZipId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smZipCode1]
    ON [dbo].[smZipCode]([ZipState] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smZipCode2]
    ON [dbo].[smZipCode]([ZipCounty] ASC) WITH (FILLFACTOR = 90);

