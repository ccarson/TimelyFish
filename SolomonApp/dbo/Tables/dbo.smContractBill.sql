CREATE TABLE [dbo].[smContractBill] (
    [AmtPaid]       FLOAT (53)    NOT NULL,
    [ARBatNbr]      CHAR (10)     NOT NULL,
    [ARRefNbr]      CHAR (10)     NOT NULL,
    [BillAmount]    FLOAT (53)    NOT NULL,
    [BillDate]      SMALLDATETIME NOT NULL,
    [BillFlag]      SMALLINT      NOT NULL,
    [CB_D04]        CHAR (20)     NOT NULL,
    [CB_ID01]       CHAR (30)     NOT NULL,
    [CB_ID02]       CHAR (30)     NOT NULL,
    [CB_ID03]       CHAR (20)     NOT NULL,
    [CB_ID05]       CHAR (10)     NOT NULL,
    [CB_ID06]       CHAR (10)     NOT NULL,
    [CB_ID07]       CHAR (4)      NOT NULL,
    [CB_ID08]       FLOAT (53)    NOT NULL,
    [CB_ID09]       SMALLDATETIME NOT NULL,
    [CB_ID10]       SMALLINT      NOT NULL,
    [CmmnAmt]       FLOAT (53)    NOT NULL,
    [Comment]       CHAR (30)     NOT NULL,
    [CmmnPct]       FLOAT (53)    NOT NULL,
    [CmmnStatus]    SMALLINT      NOT NULL,
    [ContractID]    CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DocType]       CHAR (2)      NOT NULL,
    [InvBatNbr]     CHAR (10)     NOT NULL,
    [InvoiceLineID] SMALLINT      NOT NULL,
    [InvoiceNbr]    CHAR (10)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MiscAmt]       FLOAT (53)    NOT NULL,
    [NbrOfCalls]    SMALLINT      NOT NULL,
    [NoteID]        INT           NOT NULL,
    [PerPost]       CHAR (6)      NOT NULL,
    [ProcessDate]   SMALLDATETIME NOT NULL,
    [ProjectID]     CHAR (16)     NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [Status]        CHAR (1)      NOT NULL,
    [TaskID]        CHAR (32)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smContractBill0] PRIMARY KEY CLUSTERED ([ContractID] ASC, [BillDate] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smContractBill1]
    ON [dbo].[smContractBill]([ContractID] ASC, [Status] ASC, [BillDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smContractBill2]
    ON [dbo].[smContractBill]([ContractID] ASC, [InvBatNbr] ASC, [InvoiceLineID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);

