CREATE TABLE [dbo].[WrkAcctHist] (
    [Acct]            CHAR (10)  NOT NULL,
    [begbal]          FLOAT (53) NOT NULL,
    [CpnyID]          CHAR (10)  NOT NULL,
    [CuryId]          CHAR (4)   NOT NULL,
    [fiscyr]          CHAR (4)   NOT NULL,
    [LastClosePerNbr] CHAR (6)   NOT NULL,
    [LedgerID]        CHAR (10)  NOT NULL,
    [PerPost]         CHAR (6)   NOT NULL,
    [PtdBal00]        FLOAT (53) NOT NULL,
    [PtdBal01]        FLOAT (53) NOT NULL,
    [PtdBal02]        FLOAT (53) NOT NULL,
    [PtdBal03]        FLOAT (53) NOT NULL,
    [PtdBal04]        FLOAT (53) NOT NULL,
    [PtdBal05]        FLOAT (53) NOT NULL,
    [PtdBal06]        FLOAT (53) NOT NULL,
    [PtdBal07]        FLOAT (53) NOT NULL,
    [PtdBal08]        FLOAT (53) NOT NULL,
    [PtdBal09]        FLOAT (53) NOT NULL,
    [PtdBal10]        FLOAT (53) NOT NULL,
    [PtdBal11]        FLOAT (53) NOT NULL,
    [PtdBal12]        FLOAT (53) NOT NULL,
    [RI_ID]           SMALLINT   NOT NULL,
    [Sub]             CHAR (24)  NOT NULL,
    [YtdBal00]        FLOAT (53) NOT NULL,
    [YtdBal01]        FLOAT (53) NOT NULL,
    [YtdBal02]        FLOAT (53) NOT NULL,
    [YtdBal03]        FLOAT (53) NOT NULL,
    [YtdBal04]        FLOAT (53) NOT NULL,
    [YtdBal05]        FLOAT (53) NOT NULL,
    [YtdBal06]        FLOAT (53) NOT NULL,
    [YtdBal07]        FLOAT (53) NOT NULL,
    [YtdBal08]        FLOAT (53) NOT NULL,
    [YtdBal09]        FLOAT (53) NOT NULL,
    [YtdBal10]        FLOAT (53) NOT NULL,
    [YtdBal11]        FLOAT (53) NOT NULL,
    [YtdBal12]        FLOAT (53) NOT NULL,
    [tstamp]          ROWVERSION NOT NULL,
    CONSTRAINT [WrkAcctHist0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [CpnyID] ASC, [Acct] ASC, [Sub] ASC, [LedgerID] ASC, [fiscyr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [WrkAcctHist1]
    ON [dbo].[WrkAcctHist]([Acct] ASC, [Sub] ASC, [fiscyr] ASC, [PerPost] ASC) WITH (FILLFACTOR = 90);

