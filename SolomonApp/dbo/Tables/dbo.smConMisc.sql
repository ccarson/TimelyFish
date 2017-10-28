CREATE TABLE [dbo].[smConMisc] (
    [Acct]          CHAR (10)     NOT NULL,
    [ARBatnbr]      CHAR (10)     NOT NULL,
    [ARRefnbr]      CHAR (10)     NOT NULL,
    [BatNbr]        CHAR (10)     NOT NULL,
    [BranchID]      CHAR (10)     NOT NULL,
    [ContractID]    CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Descr]         CHAR (60)     NOT NULL,
    [ExtPrice]      FLOAT (53)    NOT NULL,
    [InvBatNbr]     CHAR (10)     NOT NULL,
    [InvoiceLineID] SMALLINT      NOT NULL,
    [InvoiceNbr]    CHAR (10)     NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [PerPost]       CHAR (6)      NOT NULL,
    [Price]         FLOAT (53)    NOT NULL,
    [ProcessDate]   SMALLDATETIME NOT NULL,
    [ProjectID]     CHAR (16)     NOT NULL,
    [Qty]           FLOAT (53)    NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [Status]        CHAR (1)      NOT NULL,
    [Sub]           CHAR (24)     NOT NULL,
    [TaskID]        CHAR (32)     NOT NULL,
    [Taxable]       CHAR (1)      NOT NULL,
    [TaxAmt00]      FLOAT (53)    NOT NULL,
    [TaxAmt01]      FLOAT (53)    NOT NULL,
    [TaxAmt02]      FLOAT (53)    NOT NULL,
    [TaxAmt03]      FLOAT (53)    NOT NULL,
    [Taxid00]       CHAR (10)     NOT NULL,
    [Taxid01]       CHAR (10)     NOT NULL,
    [Taxid02]       CHAR (10)     NOT NULL,
    [Taxid03]       CHAR (10)     NOT NULL,
    [TranDate]      SMALLDATETIME NOT NULL,
    [TxblAmt00]     FLOAT (53)    NOT NULL,
    [TxblAmt01]     FLOAT (53)    NOT NULL,
    [TxblAmt02]     FLOAT (53)    NOT NULL,
    [TxblAmt03]     FLOAT (53)    NOT NULL,
    [Unit]          CHAR (6)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smConMisc0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smConMisc1]
    ON [dbo].[smConMisc]([ContractID] ASC, [TranDate] ASC, [BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConMisc2]
    ON [dbo].[smConMisc]([ContractID] ASC, [Taxable] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConMisc3]
    ON [dbo].[smConMisc]([ContractID] ASC, [Status] ASC, [TranDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConMisc4]
    ON [dbo].[smConMisc]([ContractID] ASC, [InvBatNbr] ASC, [InvoiceLineID] ASC) WITH (FILLFACTOR = 90);

