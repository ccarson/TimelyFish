CREATE TABLE [dbo].[smCode] (
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [Fault_Duration]     CHAR (4)      NOT NULL,
    [Fault_Id]           CHAR (10)     NOT NULL,
    [FaultDesc]          CHAR (30)     NOT NULL,
    [FaultNotesPrompt]   SMALLINT      NOT NULL,
    [FaultNumberOfCalls] SMALLINT      NOT NULL,
    [Lupd_DateTime]      SMALLDATETIME NOT NULL,
    [Lupd_Prog]          CHAR (8)      NOT NULL,
    [Lupd_User]          CHAR (10)     NOT NULL,
    [User1]              CHAR (30)     NOT NULL,
    [User2]              CHAR (30)     NOT NULL,
    [User3]              FLOAT (53)    NOT NULL,
    [User4]              FLOAT (53)    NOT NULL,
    [User5]              CHAR (10)     NOT NULL,
    [User6]              CHAR (10)     NOT NULL,
    [User7]              SMALLDATETIME NOT NULL,
    [User8]              SMALLDATETIME NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [smCode0] PRIMARY KEY CLUSTERED ([Fault_Id] ASC) WITH (FILLFACTOR = 90)
);

