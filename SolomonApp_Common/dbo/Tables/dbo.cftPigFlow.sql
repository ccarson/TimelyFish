CREATE TABLE [dbo].[cftPigFlow] (
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [Description]        CHAR (30)     NOT NULL,
    [Lupd_DateTime]      SMALLDATETIME NOT NULL,
    [Lupd_Prog]          CHAR (8)      NOT NULL,
    [Lupd_User]          CHAR (10)     NOT NULL,
    [NoteID]             INT           NULL,
    [OrderCode]          SMALLINT      NOT NULL,
    [PigFlowID]          CHAR (3)      NOT NULL,
    [ProductionSystemID] CHAR (2)      NOT NULL,
    [tstamp]             ROWVERSION    NULL,
    CONSTRAINT [cftPigFlow0] PRIMARY KEY CLUSTERED ([PigFlowID] ASC) WITH (FILLFACTOR = 90)
);

