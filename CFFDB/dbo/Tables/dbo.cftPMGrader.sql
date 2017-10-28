CREATE TABLE [dbo].[cftPMGrader] (
    [BatchNbr]        CHAR (10)     NULL,
    [Crtd_DateTime]   SMALLDATETIME NULL,
    [Crtd_Prog]       CHAR (8)      NULL,
    [Crtd_User]       CHAR (10)     NULL,
    [GraderContactID] CHAR (6)      NULL,
    [Lupd_DateTime]   SMALLDATETIME NULL,
    [Lupd_Prog]       CHAR (8)      NULL,
    [Lupd_User]       CHAR (10)     NULL,
    [NoteID]          INT           NULL,
    [PMGraderTypeID]  CHAR (3)      NULL,
    [RefNbr]          CHAR (10)     NULL,
    [tstamp]          ROWVERSION    NULL
);

