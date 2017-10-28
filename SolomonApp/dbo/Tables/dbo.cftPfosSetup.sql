CREATE TABLE [dbo].[cftPfosSetup] (
    [ServerName] VARCHAR (25)  NOT NULL,
    [Uri]        VARCHAR (255) NOT NULL,
    [tstamp]     ROWVERSION    NOT NULL,
    CONSTRAINT [PK_cftPfosSetup] PRIMARY KEY CLUSTERED ([ServerName] ASC) WITH (FILLFACTOR = 90)
);

