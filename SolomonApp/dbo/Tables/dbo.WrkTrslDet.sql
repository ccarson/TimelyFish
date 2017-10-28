CREATE TABLE [dbo].[WrkTrslDet] (
    [Acct]           CHAR (10)  NOT NULL,
    [DstCurrPTDBal]  FLOAT (53) NOT NULL,
    [DstCurrYTDBal]  FLOAT (53) NOT NULL,
    [DstPriorYTDBal] FLOAT (53) NOT NULL,
    [OpenBalTrslAmt] FLOAT (53) NOT NULL,
    [PerActTrslAmt]  FLOAT (53) NOT NULL,
    [Period]         CHAR (6)   NOT NULL,
    [RI_ID]          SMALLINT   NOT NULL,
    [SrcCurrPTDBal]  FLOAT (53) NOT NULL,
    [SrcCurrYTDBal]  FLOAT (53) NOT NULL,
    [SrcPriorYTDBal] FLOAT (53) NOT NULL,
    [TrslID]         CHAR (10)  NOT NULL,
    [tstamp]         ROWVERSION NOT NULL,
    CONSTRAINT [WrkTrslDet0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [TrslID] ASC, [Period] ASC, [Acct] ASC) WITH (FILLFACTOR = 90)
);

