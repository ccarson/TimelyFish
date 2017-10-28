CREATE TABLE [dbo].[SOPrintQueue] (
    [ARAcct]     CHAR (10)     CONSTRAINT [DF_SOPrintQueue_ARAcct] DEFAULT (' ') NOT NULL,
    [ARSub]      CHAR (24)     CONSTRAINT [DF_SOPrintQueue_ARSub] DEFAULT (' ') NOT NULL,
    [CpnyID]     CHAR (10)     CONSTRAINT [DF_SOPrintQueue_CpnyID] DEFAULT (' ') NOT NULL,
    [InvcNbr]    CHAR (15)     CONSTRAINT [DF_SOPrintQueue_InvcNbr] DEFAULT (' ') NOT NULL,
    [OrdNbr]     CHAR (15)     CONSTRAINT [DF_SOPrintQueue_OrdNbr] DEFAULT (' ') NOT NULL,
    [PerPost]    CHAR (6)      CONSTRAINT [DF_SOPrintQueue_PerPost] DEFAULT (' ') NOT NULL,
    [Reprint]    SMALLINT      CONSTRAINT [DF_SOPrintQueue_Reprint] DEFAULT ((0)) NOT NULL,
    [RI_ID]      SMALLINT      CONSTRAINT [DF_SOPrintQueue_RI_ID] DEFAULT ((0)) NOT NULL,
    [RptNbr]     CHAR (5)      CONSTRAINT [DF_SOPrintQueue_RptNbr] DEFAULT (' ') NOT NULL,
    [S4Future01] CHAR (30)     CONSTRAINT [DF_SOPrintQueue_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02] CHAR (30)     CONSTRAINT [DF_SOPrintQueue_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03] FLOAT (53)    CONSTRAINT [DF_SOPrintQueue_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04] FLOAT (53)    CONSTRAINT [DF_SOPrintQueue_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05] FLOAT (53)    CONSTRAINT [DF_SOPrintQueue_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06] FLOAT (53)    CONSTRAINT [DF_SOPrintQueue_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07] SMALLDATETIME CONSTRAINT [DF_SOPrintQueue_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08] SMALLDATETIME CONSTRAINT [DF_SOPrintQueue_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09] INT           CONSTRAINT [DF_SOPrintQueue_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10] INT           CONSTRAINT [DF_SOPrintQueue_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11] CHAR (10)     CONSTRAINT [DF_SOPrintQueue_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12] CHAR (10)     CONSTRAINT [DF_SOPrintQueue_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]  CHAR (15)     CONSTRAINT [DF_SOPrintQueue_ShipperID] DEFAULT (' ') NOT NULL,
    [SOTypeID]   CHAR (4)      CONSTRAINT [DF_SOPrintQueue_SOTypeID] DEFAULT (' ') NOT NULL,
    [tstamp]     ROWVERSION    NOT NULL,
    CONSTRAINT [SOPrintQueue0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [CpnyID] ASC, [OrdNbr] ASC, [ShipperID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SOPrintQueue1]
    ON [dbo].[SOPrintQueue]([CpnyID] ASC, [ShipperID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPrintQueue2]
    ON [dbo].[SOPrintQueue]([CpnyID] ASC, [OrdNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPrintQueue3]
    ON [dbo].[SOPrintQueue]([CpnyID] ASC, [ShipperID] ASC, [S4Future11] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPrintQueue4]
    ON [dbo].[SOPrintQueue]([CpnyID] ASC, [OrdNbr] ASC, [S4Future11] ASC) WITH (FILLFACTOR = 90);

