CREATE TABLE [dbo].[smConDiscount] (
    [AccrualProcess] SMALLINT      NOT NULL,
    [AccrualBatNbr]  CHAR (10)     NOT NULL,
    [AccrueDate]     SMALLDATETIME NOT NULL,
    [AccruetoGL]     SMALLINT      NOT NULL,
    [Acct]           CHAR (10)     NOT NULL,
    [AdjType]        CHAR (1)      NOT NULL,
    [Amount]         FLOAT (53)    NOT NULL,
    [AmtApplied]     FLOAT (53)    NOT NULL,
    [ARBatnbr]       CHAR (10)     NOT NULL,
    [ARRefnbr]       CHAR (10)     NOT NULL,
    [BillAmount]     FLOAT (53)    NOT NULL,
    [BillDate]       SMALLDATETIME NOT NULL,
    [BranchId]       CHAR (10)     NOT NULL,
    [ContractID]     CHAR (10)     NOT NULL,
    [CpnyID]         CHAR (10)     NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Descr]          CHAR (60)     NOT NULL,
    [GLBatNbr]       CHAR (10)     NOT NULL,
    [InvBatNbr]      CHAR (10)     NOT NULL,
    [InvoiceLineID]  SMALLINT      NOT NULL,
    [InvoiceNbr]     SMALLINT      NOT NULL,
    [Invtid]         CHAR (30)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [NoteID]         INT           NOT NULL,
    [OrdNbr]         CHAR (10)     NOT NULL,
    [PerPost]        CHAR (6)      NOT NULL,
    [ProcessDate]    SMALLDATETIME NOT NULL,
    [ProjectID]      CHAR (16)     NOT NULL,
    [RI_ID]          SMALLINT      NOT NULL,
    [Status]         CHAR (1)      NOT NULL,
    [Sub]            CHAR (24)     NOT NULL,
    [TaskID]         CHAR (32)     NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [smConDiscount0] PRIMARY KEY CLUSTERED ([ContractID] ASC, [AccrueDate] ASC, [BillDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smConDiscount1]
    ON [dbo].[smConDiscount]([Status] ASC, [ContractID] ASC, [BillDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConDiscount2]
    ON [dbo].[smConDiscount]([AccrueDate] ASC, [AccruetoGL] ASC, [ContractID] ASC) WITH (FILLFACTOR = 90);

