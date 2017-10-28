CREATE TABLE [dbo].[WrkCABalances] (
    [bankacct]          CHAR (10)     NOT NULL,
    [banksub]           CHAR (24)     NOT NULL,
    [CABalance]         FLOAT (53)    NOT NULL,
    [CACuryBalance]     FLOAT (53)    NOT NULL,
    [CashAcctName]      CHAR (30)     NOT NULL,
    [CloseBal]          FLOAT (53)    NOT NULL,
    [CpnyID]            CHAR (10)     NOT NULL,
    [Curyclosebal]      FLOAT (53)    NOT NULL,
    [CuryDisbursements] FLOAT (53)    NOT NULL,
    [CuryGLBalance]     FLOAT (53)    NOT NULL,
    [CuryID]            CHAR (4)      NOT NULL,
    [CuryReceipts]      FLOAT (53)    NOT NULL,
    [Disbursements]     FLOAT (53)    NOT NULL,
    [GLBalance]         FLOAT (53)    NOT NULL,
    [LastReconDate]     SMALLDATETIME NOT NULL,
    [NbrChecks]         SMALLINT      NOT NULL,
    [NbrChkDays]        SMALLINT      NOT NULL,
    [NbrDepDays]        SMALLINT      NOT NULL,
    [NbrDeposits]       SMALLINT      NOT NULL,
    [Period]            CHAR (6)      NOT NULL,
    [Receipts]          FLOAT (53)    NOT NULL,
    [ReconcileFlag]     SMALLINT      NOT NULL,
    [ReconDate]         SMALLDATETIME NOT NULL,
    [RI_ID]             SMALLINT      NOT NULL,
    [Trandate]          SMALLDATETIME NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [WrkCABalances0]
    ON [dbo].[WrkCABalances]([RI_ID] ASC, [CpnyID] ASC, [bankacct] ASC, [banksub] ASC, [ReconDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WrkCABalances2]
    ON [dbo].[WrkCABalances]([RI_ID] ASC, [CpnyID] ASC, [bankacct] ASC, [banksub] ASC, [Period] ASC) WITH (FILLFACTOR = 90);

