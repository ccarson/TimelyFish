CREATE TABLE [dbo].[cftPMGrader] (
    [BatchNbr]        CHAR (10)     NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NULL,
    [Crtd_Prog]       CHAR (8)      NULL,
    [Crtd_User]       CHAR (10)     NULL,
    [GraderContactID] CHAR (6)      NULL,
    [Lupd_DateTime]   SMALLDATETIME NULL,
    [Lupd_Prog]       CHAR (8)      NULL,
    [Lupd_User]       CHAR (10)     NULL,
    [NoteID]          INT           NULL,
    [PMGraderTypeID]  CHAR (3)      NOT NULL,
    [RefNbr]          CHAR (10)     NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftPMGrader0] PRIMARY KEY CLUSTERED ([BatchNbr] ASC, [RefNbr] ASC, [PMGraderTypeID] ASC) WITH (FILLFACTOR = 90)
);

