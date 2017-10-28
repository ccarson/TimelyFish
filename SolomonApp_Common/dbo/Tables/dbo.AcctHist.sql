CREATE TABLE [dbo].[AcctHist] (
    [Acct]            CHAR (10)     NOT NULL,
    [AnnBdgt]         FLOAT (53)    NOT NULL,
    [AnnMemo1]        FLOAT (53)    NOT NULL,
    [BalanceType]     CHAR (1)      NOT NULL,
    [BdgtRvsnDate]    SMALLDATETIME NOT NULL,
    [BegBal]          FLOAT (53)    NOT NULL,
    [CpnyID]          CHAR (10)     NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [CuryId]          CHAR (4)      NOT NULL,
    [DistType]        CHAR (8)      NOT NULL,
    [FiscYr]          CHAR (4)      NOT NULL,
    [LastClosePerNbr] CHAR (6)      NOT NULL,
    [LedgerID]        CHAR (10)     NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [NoteID]          INT           NOT NULL,
    [PtdAlloc00]      FLOAT (53)    NOT NULL,
    [PtdAlloc01]      FLOAT (53)    NOT NULL,
    [PtdAlloc02]      FLOAT (53)    NOT NULL,
    [PtdAlloc03]      FLOAT (53)    NOT NULL,
    [PtdAlloc04]      FLOAT (53)    NOT NULL,
    [PtdAlloc05]      FLOAT (53)    NOT NULL,
    [PtdAlloc06]      FLOAT (53)    NOT NULL,
    [PtdAlloc07]      FLOAT (53)    NOT NULL,
    [PtdAlloc08]      FLOAT (53)    NOT NULL,
    [PtdAlloc09]      FLOAT (53)    NOT NULL,
    [PtdAlloc10]      FLOAT (53)    NOT NULL,
    [PtdAlloc11]      FLOAT (53)    NOT NULL,
    [PtdAlloc12]      FLOAT (53)    NOT NULL,
    [PtdBal00]        FLOAT (53)    NOT NULL,
    [PtdBal01]        FLOAT (53)    NOT NULL,
    [PtdBal02]        FLOAT (53)    NOT NULL,
    [PtdBal03]        FLOAT (53)    NOT NULL,
    [PtdBal04]        FLOAT (53)    NOT NULL,
    [PtdBal05]        FLOAT (53)    NOT NULL,
    [PtdBal06]        FLOAT (53)    NOT NULL,
    [PtdBal07]        FLOAT (53)    NOT NULL,
    [PtdBal08]        FLOAT (53)    NOT NULL,
    [PtdBal09]        FLOAT (53)    NOT NULL,
    [PtdBal10]        FLOAT (53)    NOT NULL,
    [PtdBal11]        FLOAT (53)    NOT NULL,
    [PtdBal12]        FLOAT (53)    NOT NULL,
    [PtdCon00]        FLOAT (53)    NOT NULL,
    [PtdCon01]        FLOAT (53)    NOT NULL,
    [PtdCon02]        FLOAT (53)    NOT NULL,
    [PtdCon03]        FLOAT (53)    NOT NULL,
    [PtdCon04]        FLOAT (53)    NOT NULL,
    [PtdCon05]        FLOAT (53)    NOT NULL,
    [PtdCon06]        FLOAT (53)    NOT NULL,
    [PtdCon07]        FLOAT (53)    NOT NULL,
    [PtdCon08]        FLOAT (53)    NOT NULL,
    [PtdCon09]        FLOAT (53)    NOT NULL,
    [PtdCon10]        FLOAT (53)    NOT NULL,
    [PtdCon11]        FLOAT (53)    NOT NULL,
    [PtdCon12]        FLOAT (53)    NOT NULL,
    [S4Future01]      CHAR (30)     NOT NULL,
    [S4Future02]      CHAR (30)     NOT NULL,
    [S4Future03]      FLOAT (53)    NOT NULL,
    [S4Future04]      FLOAT (53)    NOT NULL,
    [S4Future05]      FLOAT (53)    NOT NULL,
    [S4Future06]      FLOAT (53)    NOT NULL,
    [S4Future07]      SMALLDATETIME NOT NULL,
    [S4Future08]      SMALLDATETIME NOT NULL,
    [S4Future09]      INT           NOT NULL,
    [S4Future10]      INT           NOT NULL,
    [S4Future11]      CHAR (10)     NOT NULL,
    [S4Future12]      CHAR (10)     NOT NULL,
    [SpreadSheetType] CHAR (1)      NOT NULL,
    [Sub]             CHAR (24)     NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [YtdBal00]        FLOAT (53)    NOT NULL,
    [YtdBal01]        FLOAT (53)    NOT NULL,
    [YtdBal02]        FLOAT (53)    NOT NULL,
    [YtdBal03]        FLOAT (53)    NOT NULL,
    [YtdBal04]        FLOAT (53)    NOT NULL,
    [YtdBal05]        FLOAT (53)    NOT NULL,
    [YtdBal06]        FLOAT (53)    NOT NULL,
    [YtdBal07]        FLOAT (53)    NOT NULL,
    [YtdBal08]        FLOAT (53)    NOT NULL,
    [YtdBal09]        FLOAT (53)    NOT NULL,
    [YtdBal10]        FLOAT (53)    NOT NULL,
    [YtdBal11]        FLOAT (53)    NOT NULL,
    [YtdBal12]        FLOAT (53)    NOT NULL,
    [YTDEstimated]    FLOAT (53)    NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [AcctHist0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [Acct] ASC, [Sub] ASC, [LedgerID] ASC, [FiscYr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [AcctHist1]
    ON [dbo].[AcctHist]([CpnyID] ASC, [FiscYr] ASC, [Acct] ASC, [Sub] ASC, [LedgerID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [AcctHist3]
    ON [dbo].[AcctHist]([CpnyID] ASC, [LedgerID] ASC, [FiscYr] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [AcctHist4]
    ON [dbo].[AcctHist]([Sub] ASC, [Acct] ASC, [FiscYr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [AcctHist5]
    ON [dbo].[AcctHist]([LedgerID] ASC, [FiscYr] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [AcctHist6]
    ON [dbo].[AcctHist]([Acct] ASC, [Sub] ASC, [LedgerID] ASC, [FiscYr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [AcctHist7]
    ON [dbo].[AcctHist]([FiscYr] ASC, [Acct] ASC, [Sub] ASC, [LedgerID] ASC) WITH (FILLFACTOR = 90);

