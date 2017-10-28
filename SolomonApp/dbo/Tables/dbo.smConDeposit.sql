CREATE TABLE [dbo].[smConDeposit] (
    [AccruedtoGl]   SMALLINT      DEFAULT ((0)) NOT NULL,
    [Acct]          CHAR (10)     DEFAULT ('') NOT NULL,
    [Amount]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AmtApplied]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ARBatNbr]      CHAR (10)     DEFAULT ('') NOT NULL,
    [ARRefNbr]      CHAR (10)     DEFAULT ('') NOT NULL,
    [BatNbr]        CHAR (10)     DEFAULT ('') NOT NULL,
    [BillDate]      SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [BranchID]      CHAR (10)     DEFAULT ('') NOT NULL,
    [Contractid]    CHAR (10)     DEFAULT ('') NOT NULL,
    [CpnyID]        CHAR (10)     DEFAULT ('') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Crtd_Prog]     CHAR (8)      DEFAULT ('') NOT NULL,
    [Crtd_User]     CHAR (10)     DEFAULT ('') NOT NULL,
    [Descr]         CHAR (60)     DEFAULT ('') NOT NULL,
    [GLBatNbr]      CHAR (10)     DEFAULT ('') NOT NULL,
    [InvBatNbr]     CHAR (10)     DEFAULT ('') NOT NULL,
    [InvoiceLineID] SMALLINT      DEFAULT ((0)) NOT NULL,
    [InvoiceNbr]    CHAR (10)     DEFAULT ('') NOT NULL,
    [InvtId]        CHAR (30)     DEFAULT ('') NOT NULL,
    [LineNbr]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [Lupd_DateTime] SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]     CHAR (8)      DEFAULT ('') NOT NULL,
    [Lupd_User]     CHAR (10)     DEFAULT ('') NOT NULL,
    [NoteID]        INT           DEFAULT ((0)) NOT NULL,
    [OrdNbr]        CHAR (10)     DEFAULT ('') NOT NULL,
    [PerPost]       CHAR (6)      DEFAULT ('') NOT NULL,
    [ProcessDate]   SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [ProjectID]     CHAR (16)     DEFAULT ('') NOT NULL,
    [Rebill]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [RebillDate]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Refnbr]        CHAR (10)     DEFAULT ('') NOT NULL,
    [RI_ID]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [Status]        CHAR (1)      DEFAULT ('') NOT NULL,
    [Sub]           CHAR (24)     DEFAULT ('') NOT NULL,
    [TaskID]        CHAR (32)     DEFAULT ('') NOT NULL,
    [TranDate]      SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User1]         CHAR (30)     DEFAULT ('') NOT NULL,
    [User2]         CHAR (30)     DEFAULT ('') NOT NULL,
    [User3]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     DEFAULT ('') NOT NULL,
    [User6]         CHAR (10)     DEFAULT ('') NOT NULL,
    [User7]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smConDeposit0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smConDeposit1]
    ON [dbo].[smConDeposit]([Contractid] ASC, [TranDate] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConDeposit2]
    ON [dbo].[smConDeposit]([Contractid] ASC, [BillDate] ASC, [BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConDeposit3]
    ON [dbo].[smConDeposit]([PerPost] ASC, [Contractid] ASC, [TranDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConDeposit4]
    ON [dbo].[smConDeposit]([Contractid] ASC, [Status] ASC, [BillDate] ASC, [Amount] ASC, [AmtApplied] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConDeposit5]
    ON [dbo].[smConDeposit]([Contractid] ASC, [InvBatNbr] ASC, [InvoiceLineID] ASC) WITH (FILLFACTOR = 90);

