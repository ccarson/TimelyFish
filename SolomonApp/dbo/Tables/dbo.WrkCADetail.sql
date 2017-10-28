CREATE TABLE [dbo].[WrkCADetail] (
    [bankacct]    CHAR (10)     NOT NULL,
    [banksub]     CHAR (24)     NOT NULL,
    [BatNbr]      CHAR (10)     NOT NULL,
    [ClearAmt]    FLOAT (53)    NOT NULL,
    [ClearDate]   SMALLDATETIME NOT NULL,
    [Cleared]     SMALLINT      NOT NULL,
    [cpnyid]      CHAR (10)     NOT NULL,
    [CuryID]      CHAR (4)      NOT NULL,
    [CuryTranamt] FLOAT (53)    NOT NULL,
    [DrCr]        CHAR (1)      NOT NULL,
    [EntryID]     CHAR (2)      NOT NULL,
    [Module]      CHAR (2)      NOT NULL,
    [PayeeID]     CHAR (15)     NOT NULL,
    [PC_Status]   CHAR (1)      NOT NULL,
    [Perent]      CHAR (6)      NOT NULL,
    [PerPost]     CHAR (6)      NOT NULL,
    [ProjectID]   CHAR (16)     NOT NULL,
    [RcnclStatus] CHAR (1)      NOT NULL,
    [Rcptdisbflg] CHAR (1)      NOT NULL,
    [Refnbr]      CHAR (10)     NOT NULL,
    [RI_ID]       SMALLINT      NOT NULL,
    [TaskID]      CHAR (32)     NOT NULL,
    [Tranamt]     FLOAT (53)    NOT NULL,
    [Trandate]    SMALLDATETIME NOT NULL,
    [Trandesc]    CHAR (30)     NOT NULL,
    [tstamp]      ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [WrkCADetail0]
    ON [dbo].[WrkCADetail]([RI_ID] ASC, [cpnyid] ASC, [bankacct] ASC, [banksub] ASC, [Module] ASC, [Refnbr] ASC, [Trandate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [WrkCADetail2]
    ON [dbo].[WrkCADetail]([cpnyid] ASC, [bankacct] ASC, [banksub] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [WrkCADetail3]
    ON [dbo].[WrkCADetail]([RI_ID] ASC, [cpnyid] ASC, [bankacct] ASC, [banksub] ASC, [Perent] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [WrkCADetail4]
    ON [dbo].[WrkCADetail]([RI_ID] ASC, [cpnyid] ASC, [bankacct] ASC, [banksub] ASC, [Trandate] ASC, [PerPost] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [WrkCADetail5]
    ON [dbo].[WrkCADetail]([RI_ID] ASC, [cpnyid] ASC, [bankacct] ASC, [banksub] ASC, [ClearDate] ASC) WITH (FILLFACTOR = 100);

