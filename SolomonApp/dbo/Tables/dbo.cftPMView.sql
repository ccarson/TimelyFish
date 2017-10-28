CREATE TABLE [dbo].[cftPMView] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MarketFlag]    SMALLINT      NULL,
    [NoteID]        INT           NOT NULL,
    [PMSystemID]    CHAR (2)      NOT NULL,
    [PMViewID]      CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPMView0] PRIMARY KEY CLUSTERED ([PMViewID] ASC) WITH (FILLFACTOR = 90)
);

