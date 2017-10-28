CREATE TABLE [dbo].[cftInterCoClass] (
    [ClassID]       CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftInterCoClass0] PRIMARY KEY CLUSTERED ([ClassID] ASC) WITH (FILLFACTOR = 90)
);

