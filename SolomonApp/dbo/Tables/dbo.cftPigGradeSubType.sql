CREATE TABLE [dbo].[cftPigGradeSubType] (
    [Crtd_DateTime]       SMALLDATETIME NULL,
    [Crtd_Prog]           CHAR (8)      NULL,
    [Crtd_User]           CHAR (10)     NULL,
    [Lupd_DateTime]       SMALLDATETIME NULL,
    [Lupd_Prog]           CHAR (8)      NULL,
    [Lupd_User]           CHAR (10)     NULL,
    [NoteID]              INT           NULL,
    [PigGradeSubTypeDesc] CHAR (30)     NULL,
    [PigGradeSubTypeID]   CHAR (2)      NOT NULL,
    [tstamp]              ROWVERSION    NULL,
    CONSTRAINT [cftPigGradeSubType0] PRIMARY KEY CLUSTERED ([PigGradeSubTypeID] ASC) WITH (FILLFACTOR = 90)
);

