CREATE TABLE [dbo].[WrkCheckSel] (
    [AccessNbr]        SMALLINT      NOT NULL,
    [Acct]             CHAR (10)     NOT NULL,
    [AdjFlag]          SMALLINT      NOT NULL,
    [ApplyRefNbr]      CHAR (10)     NOT NULL,
    [BWAmt]            FLOAT (53)    NOT NULL,
    [CheckCuryId]      CHAR (4)      NOT NULL,
    [CheckCuryRate]    FLOAT (53)    NOT NULL,
    [CheckCuryMultDiv] CHAR (1)      NOT NULL,
    [CpnyID]           CHAR (10)     NOT NULL,
    [CheckRefNbr]      CHAR (10)     NULL,
    [CuryBWAmt]        FLOAT (53)    NOT NULL,
    [CuryDecPl]        SMALLINT      NOT NULL,
    [CuryDiscBal]      FLOAT (53)    NOT NULL,
    [CuryDiscTkn]      FLOAT (53)    NOT NULL,
    [CuryDocBal]       FLOAT (53)    NOT NULL,
    [CuryEffDate]      SMALLDATETIME NOT NULL,
    [CuryId]           CHAR (4)      NOT NULL,
    [CuryMultDiv]      CHAR (1)      NOT NULL,
    [CuryPmtAmt]       FLOAT (53)    NOT NULL,
    [CuryRate]         FLOAT (53)    NOT NULL,
    [CuryRateType]     CHAR (6)      NOT NULL,
    [DiscBal]          FLOAT (53)    NOT NULL,
    [DiscDate]         SMALLDATETIME NOT NULL,
    [DiscTkn]          FLOAT (53)    NOT NULL,
    [DocBal]           FLOAT (53)    NOT NULL,
    [DocDesc]          CHAR (30)     NOT NULL,
    [DocType]          CHAR (2)      NOT NULL,
    [DueDate]          SMALLDATETIME NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [MultiChk]         SMALLINT      NOT NULL,
    [PayDate]          SMALLDATETIME NOT NULL,
    [PmtAmt]           FLOAT (53)    NOT NULL,
    [RefNbr]           CHAR (10)     NOT NULL,
    [ReqBkupWthld]     SMALLINT      DEFAULT ((0)) NOT NULL,
    [S4Future01]       CHAR (30)     NOT NULL,
    [S4Future02]       CHAR (30)     NOT NULL,
    [S4Future03]       FLOAT (53)    NOT NULL,
    [S4Future04]       FLOAT (53)    NOT NULL,
    [S4Future05]       FLOAT (53)    NOT NULL,
    [S4Future06]       FLOAT (53)    NOT NULL,
    [S4Future07]       SMALLDATETIME NOT NULL,
    [S4Future08]       SMALLDATETIME NOT NULL,
    [S4Future09]       INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [Sub]              CHAR (24)     NOT NULL,
    [VendId]           CHAR (15)     NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [WrkCheckSel0]
    ON [dbo].[WrkCheckSel]([AccessNbr] ASC, [VendId] ASC, [AdjFlag] ASC, [DocType] ASC, [RefNbr] ASC);


GO
CREATE NONCLUSTERED INDEX [WrkCheckSel1]
    ON [dbo].[WrkCheckSel]([AccessNbr] ASC, [DiscDate] ASC, [DueDate] ASC);


GO
CREATE NONCLUSTERED INDEX [WrkCheckSel3]
    ON [dbo].[WrkCheckSel]([AccessNbr] ASC, [RefNbr] ASC, [VendId] ASC, [DocType] ASC, [AdjFlag] ASC, [CpnyID] ASC);

