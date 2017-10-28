CREATE TABLE [dbo].[POPrintQueue] (
    [CpnyID]     CHAR (10)     CONSTRAINT [DF_POPrintQueue_CpnyID] DEFAULT (' ') NOT NULL,
    [PONbr]      CHAR (10)     CONSTRAINT [DF_POPrintQueue_PONbr] DEFAULT (' ') NOT NULL,
    [Reprint]    SMALLINT      CONSTRAINT [DF_POPrintQueue_Reprint] DEFAULT ((0)) NOT NULL,
    [ReqCntr]    CHAR (2)      CONSTRAINT [DF_POPrintQueue_ReqCntr] DEFAULT (' ') NOT NULL,
    [ReqNbr]     CHAR (10)     CONSTRAINT [DF_POPrintQueue_ReqNbr] DEFAULT (' ') NOT NULL,
    [RI_ID]      SMALLINT      CONSTRAINT [DF_POPrintQueue_RI_ID] DEFAULT ((0)) NOT NULL,
    [S4Future01] CHAR (30)     CONSTRAINT [DF_POPrintQueue_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02] CHAR (30)     CONSTRAINT [DF_POPrintQueue_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03] FLOAT (53)    CONSTRAINT [DF_POPrintQueue_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04] FLOAT (53)    CONSTRAINT [DF_POPrintQueue_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05] FLOAT (53)    CONSTRAINT [DF_POPrintQueue_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06] FLOAT (53)    CONSTRAINT [DF_POPrintQueue_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07] SMALLDATETIME CONSTRAINT [DF_POPrintQueue_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08] SMALLDATETIME CONSTRAINT [DF_POPrintQueue_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09] INT           CONSTRAINT [DF_POPrintQueue_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10] INT           CONSTRAINT [DF_POPrintQueue_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11] CHAR (10)     CONSTRAINT [DF_POPrintQueue_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12] CHAR (10)     CONSTRAINT [DF_POPrintQueue_S4Future12] DEFAULT (' ') NOT NULL,
    [tstamp]     ROWVERSION    NOT NULL,
    CONSTRAINT [POPrintQueue0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [CpnyID] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90)
);

