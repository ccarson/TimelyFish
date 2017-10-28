CREATE TABLE [dbo].[cftPigGradeCatType] (
    [Crtd_Date]           SMALLDATETIME NOT NULL,
    [Crtd_Prog]           CHAR (8)      NOT NULL,
    [Crtd_User]           CHAR (10)     NOT NULL,
    [DefaultType]         SMALLINT      NOT NULL,
    [Lupd_Date]           SMALLDATETIME NOT NULL,
    [Lupd_Prog]           CHAR (8)      NOT NULL,
    [Lupd_User]           CHAR (10)     NOT NULL,
    [NoteID]              INT           NOT NULL,
    [PigGradeCatTypeDesc] CHAR (20)     NOT NULL,
    [PigGradeCatTypeID]   CHAR (2)      NOT NULL,
    [tstamp]              ROWVERSION    NULL,
    CONSTRAINT [cftPigGradeCatType0] PRIMARY KEY CLUSTERED ([PigGradeCatTypeID] ASC) WITH (FILLFACTOR = 90)
);

