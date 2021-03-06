﻿CREATE TABLE [dbo].[SMInvoice] (
    [Acct]           CHAR (10)     NOT NULL,
    [Amount]         FLOAT (53)    NOT NULL,
    [ARBatNbr]       CHAR (10)     NOT NULL,
    [ASID]           INT           NOT NULL,
    [BillingType]    CHAR (1)      NOT NULL,
    [BranchID]       CHAR (10)     NOT NULL,
    [CallDetailType] CHAR (1)      NOT NULL,
    [CmmnAmt]        FLOAT (53)    NOT NULL,
    [CmmnPct]        FLOAT (53)    NOT NULL,
    [ContractID]     CHAR (10)     NOT NULL,
    [CpnyID]         CHAR (10)     NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [CustID]         CHAR (15)     NOT NULL,
    [CustPO]         CHAR (30)     NOT NULL,
    [DocDate]        SMALLDATETIME NOT NULL,
    [DocDesc]        CHAR (30)     NOT NULL,
    [DocType]        CHAR (1)      NOT NULL,
    [DocumentId]     CHAR (10)     NOT NULL,
    [IN_ID01]        CHAR (30)     NOT NULL,
    [IN_ID03]        CHAR (20)     NOT NULL,
    [IN_ID04]        CHAR (20)     NOT NULL,
    [IN_ID05]        CHAR (10)     NOT NULL,
    [IN_ID06]        CHAR (10)     NOT NULL,
    [IN_ID07]        CHAR (4)      NOT NULL,
    [IN_ID08]        FLOAT (53)    NOT NULL,
    [IN_ID09]        SMALLDATETIME NOT NULL,
    [IN_ID10]        SMALLINT      NOT NULL,
    [IN_IN02]        CHAR (30)     NOT NULL,
    [InvoiceType]    CHAR (1)      NOT NULL,
    [LineCntr]       SMALLINT      NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [NoteID]         INT           NOT NULL,
    [OrigCallID]     CHAR (10)     NOT NULL,
    [PerEnt]         CHAR (6)      NOT NULL,
    [PerPost]        CHAR (6)      NOT NULL,
    [ProjectID]      CHAR (16)     NOT NULL,
    [Refnbr]         CHAR (10)     NOT NULL,
    [ShipToID]       CHAR (10)     NOT NULL,
    [SlsperID]       CHAR (10)     NOT NULL,
    [Sub]            CHAR (24)     NOT NULL,
    [TaxAmt00]       FLOAT (53)    NOT NULL,
    [TaxAmt01]       FLOAT (53)    NOT NULL,
    [TaxAmt02]       FLOAT (53)    NOT NULL,
    [TaxAmt03]       FLOAT (53)    NOT NULL,
    [TaxID00]        CHAR (10)     NOT NULL,
    [TaxID01]        CHAR (10)     NOT NULL,
    [TaxID02]        CHAR (10)     NOT NULL,
    [TaxID03]        CHAR (10)     NOT NULL,
    [TermID]         CHAR (2)      NOT NULL,
    [TxblAmt00]      FLOAT (53)    NOT NULL,
    [TxblAmt01]      FLOAT (53)    NOT NULL,
    [TxblAmt02]      FLOAT (53)    NOT NULL,
    [TxblAmt03]      FLOAT (53)    NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [User9]          SMALLINT      NOT NULL,
    [UserID]         CHAR (47)     NOT NULL,
    [WrkOrdNbr]      CHAR (10)     NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [smInvoice0] PRIMARY KEY CLUSTERED ([IN_ID06] ASC, [Refnbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smInvoice1]
    ON [dbo].[SMInvoice]([DocType] ASC, [DocumentId] ASC, [Refnbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smInvoice2]
    ON [dbo].[SMInvoice]([ARBatNbr] ASC, [Refnbr] ASC) WITH (FILLFACTOR = 90);

