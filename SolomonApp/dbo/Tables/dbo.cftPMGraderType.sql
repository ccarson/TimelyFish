CREATE TABLE [dbo].[cftPMGraderType] (
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [DefaultType]      SMALLINT      NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [NoteID]           INT           NOT NULL,
    [PMGraderTypeDesc] CHAR (30)     NOT NULL,
    [PMGraderTypeID]   CHAR (3)      NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftPMGraderType0] PRIMARY KEY CLUSTERED ([PMGraderTypeID] ASC) WITH (FILLFACTOR = 90)
);

