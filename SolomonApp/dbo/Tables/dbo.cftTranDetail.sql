CREATE TABLE [dbo].[cftTranDetail] (
    [PigGroupID]  CHAR (10)     NOT NULL,
    [acct]        CHAR (16)     NOT NULL,
    [TranDate]    SMALLDATETIME NOT NULL,
    [SourceID]    CHAR (10)     NOT NULL,
    [Source]      CHAR (30)     NOT NULL,
    [Qty]         SMALLINT      NOT NULL,
    [TotalWgt]    FLOAT (53)    NOT NULL,
    [GrandTotWgt] FLOAT (53)    NOT NULL,
    [TotalQty]    SMALLINT      NOT NULL,
    [AvgWgt]      FLOAT (53)    NOT NULL,
    [tstamp]      ROWVERSION    NULL
);

