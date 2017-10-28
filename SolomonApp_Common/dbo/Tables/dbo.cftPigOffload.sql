CREATE TABLE [dbo].[cftPigOffload] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DestPMId]      INT           NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [SrcPMId]       INT           NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPigOffload0] PRIMARY KEY CLUSTERED ([SrcPMId] ASC) WITH (FILLFACTOR = 90)
);

