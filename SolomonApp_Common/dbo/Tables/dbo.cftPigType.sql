CREATE TABLE [dbo].[cftPigType] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [LoadTimeMinutes] SMALLINT      NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [NoteID]          INT           NOT NULL,
    [PigTypeDesc]     CHAR (30)     NOT NULL,
    [PigTypeID]       CHAR (2)      NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftPigType0] PRIMARY KEY CLUSTERED ([PigTypeID] ASC) WITH (FILLFACTOR = 90)
);

