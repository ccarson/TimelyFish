﻿CREATE TABLE [dbo].[ARStmt] (
    [AgeDays00]          SMALLINT      NOT NULL,
    [AgeDays01]          SMALLINT      NOT NULL,
    [AgeDays02]          SMALLINT      NOT NULL,
    [AgeMsg00]           CHAR (50)     NOT NULL,
    [AgeMsg01]           CHAR (50)     NOT NULL,
    [AgeMsg02]           CHAR (50)     NOT NULL,
    [AgeMsg03]           CHAR (50)     NOT NULL,
    [CloseDateTime]      SMALLDATETIME NOT NULL,
    [CloseDateTime_Prev] SMALLDATETIME NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [LastAgeDate]        SMALLDATETIME NOT NULL,
    [LastFinChrgDate]    SMALLDATETIME NOT NULL,
    [LastStmtDate]       SMALLDATETIME NOT NULL,
    [LUpd_DateTime]      SMALLDATETIME NOT NULL,
    [LUpd_Prog]          CHAR (8)      NOT NULL,
    [LUpd_User]          CHAR (10)     NOT NULL,
    [NoteId]             INT           NOT NULL,
    [S4Future01]         CHAR (30)     NOT NULL,
    [S4Future02]         CHAR (30)     NOT NULL,
    [S4Future03]         FLOAT (53)    NOT NULL,
    [S4Future04]         FLOAT (53)    NOT NULL,
    [S4Future05]         FLOAT (53)    NOT NULL,
    [S4Future06]         FLOAT (53)    NOT NULL,
    [S4Future07]         SMALLDATETIME NOT NULL,
    [S4Future08]         SMALLDATETIME NOT NULL,
    [S4Future09]         INT           NOT NULL,
    [S4Future10]         INT           NOT NULL,
    [S4Future11]         CHAR (10)     NOT NULL,
    [S4Future12]         CHAR (10)     NOT NULL,
    [StmtCycleId]        CHAR (2)      NOT NULL,
    [User1]              CHAR (30)     NOT NULL,
    [User2]              CHAR (30)     NOT NULL,
    [User3]              FLOAT (53)    NOT NULL,
    [User4]              FLOAT (53)    NOT NULL,
    [User5]              CHAR (10)     NOT NULL,
    [User6]              CHAR (10)     NOT NULL,
    [User7]              SMALLDATETIME NOT NULL,
    [User8]              SMALLDATETIME NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [ARStmt0] PRIMARY KEY CLUSTERED ([StmtCycleId] ASC) WITH (FILLFACTOR = 90)
);

