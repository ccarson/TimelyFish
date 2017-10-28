CREATE TABLE [dbo].[smConAdjust] (
    [AccruetoGL]    SMALLINT      NOT NULL,
    [AccrueType]    CHAR (1)      NOT NULL,
    [Acct]          CHAR (10)     NOT NULL,
    [AdjType]       CHAR (1)      NOT NULL,
    [Amount]        FLOAT (53)    NOT NULL,
    [AmtApplied]    FLOAT (53)    NOT NULL,
    [ARBatNbr]      CHAR (10)     NOT NULL,
    [ARRefNbr]      CHAR (10)     NOT NULL,
    [Batnbr]        CHAR (10)     NOT NULL,
    [BillDate]      SMALLDATETIME NOT NULL,
    [BillType]      CHAR (1)      NOT NULL,
    [BranchID]      CHAR (10)     NOT NULL,
    [ContractID]    CHAR (10)     NOT NULL,
    [CpnyId]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Descr]         CHAR (60)     NOT NULL,
    [GLBatNbr]      CHAR (10)     NOT NULL,
    [InvBatNbr]     CHAR (10)     NOT NULL,
    [InvoiceLineID] SMALLINT      NOT NULL,
    [InvoiceNbr]    CHAR (10)     NOT NULL,
    [Invtid]        CHAR (30)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [PerPost]       CHAR (6)      NOT NULL,
    [ProcessDate]   SMALLDATETIME NOT NULL,
    [ProjectID]     CHAR (16)     NOT NULL,
    [RevType]       CHAR (1)      NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [Status]        CHAR (1)      NOT NULL,
    [Sub]           CHAR (24)     NOT NULL,
    [TaskID]        CHAR (32)     NOT NULL,
    [TransDate]     SMALLDATETIME NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smConAdjust0] PRIMARY KEY CLUSTERED ([Batnbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smConAdjust1]
    ON [dbo].[smConAdjust]([ContractID] ASC, [BillDate] ASC, [Batnbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConAdjust2]
    ON [dbo].[smConAdjust]([ContractID] ASC, [TransDate] ASC, [Batnbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConAdjust3]
    ON [dbo].[smConAdjust]([PerPost] ASC, [ContractID] ASC, [TransDate] ASC) WITH (FILLFACTOR = 90);

