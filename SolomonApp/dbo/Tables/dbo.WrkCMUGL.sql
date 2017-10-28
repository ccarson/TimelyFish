CREATE TABLE [dbo].[WrkCMUGL] (
    [CalcBasePmtAmt] FLOAT (53) NOT NULL,
    [CalcMultDiv]    CHAR (1)   NOT NULL,
    [CalcRate]       FLOAT (53) NOT NULL,
    [CpnyID]         CHAR (10)  NOT NULL,
    [CuryId]         CHAR (4)   NOT NULL,
    [CuryPmtAmt]     FLOAT (53) NOT NULL,
    [CustId]         CHAR (15)  NOT NULL,
    [DocStatus]      CHAR (1)   NOT NULL,
    [DocType]        CHAR (2)   NOT NULL,
    [OrigBasePmtAmt] FLOAT (53) NOT NULL,
    [OrigMultDiv]    CHAR (1)   NOT NULL,
    [OrigRate]       FLOAT (53) NOT NULL,
    [RefNbr]         CHAR (10)  NOT NULL,
    [RI_ID]          SMALLINT   NOT NULL,
    [UGOLAcct]       CHAR (10)  NOT NULL,
    [UGOLSub]        CHAR (24)  NOT NULL,
    [UnrlGain]       FLOAT (53) NOT NULL,
    [UnrlLoss]       FLOAT (53) NOT NULL,
    [VendId]         CHAR (15)  NOT NULL,
    [tstamp]         ROWVERSION NOT NULL,
    CONSTRAINT [WrkCMUGL0] PRIMARY KEY CLUSTERED ([CuryId] ASC, [DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 90)
);

