CREATE TABLE [dbo].[cftPMCommCat] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PMCommCatID]   CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [PK__cftPMCommCat__7ACA7FEB] PRIMARY KEY CLUSTERED ([PMCommCatID] ASC) WITH (FILLFACTOR = 90)
);

