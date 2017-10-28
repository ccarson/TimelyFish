CREATE TABLE [dbo].[OMPrintQueue] (
    [CpnyID]     CHAR (10)     NOT NULL,
    [INNbr]      CHAR (10)     NOT NULL,
    [Reprint]    SMALLINT      NOT NULL,
    [ReqCntr]    CHAR (2)      NOT NULL,
    [ReqNbr]     CHAR (10)     NOT NULL,
    [RI_ID]      SMALLINT      NOT NULL,
    [S4Future01] CHAR (30)     NOT NULL,
    [S4Future02] CHAR (30)     NOT NULL,
    [S4Future03] FLOAT (53)    NOT NULL,
    [S4Future04] FLOAT (53)    NOT NULL,
    [S4Future05] FLOAT (53)    NOT NULL,
    [S4Future06] FLOAT (53)    NOT NULL,
    [S4Future07] SMALLDATETIME NOT NULL,
    [S4Future08] SMALLDATETIME NOT NULL,
    [S4Future09] INT           NOT NULL,
    [S4Future10] INT           NOT NULL,
    [S4Future11] CHAR (10)     NOT NULL,
    [S4Future12] CHAR (10)     NOT NULL,
    [tstamp]     ROWVERSION    NOT NULL,
    CONSTRAINT [OMPrintQueue0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [CpnyID] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90)
);

