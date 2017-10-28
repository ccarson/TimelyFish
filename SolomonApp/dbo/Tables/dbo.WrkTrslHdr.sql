CREATE TABLE [dbo].[WrkTrslHdr] (
    [CurPerEffDate]   SMALLDATETIME NOT NULL,
    [CurrAvgRate]     FLOAT (53)    NOT NULL,
    [CurrBSRate]      FLOAT (53)    NOT NULL,
    [DstCuryID]       CHAR (4)      NOT NULL,
    [DstLedgerID]     CHAR (10)     NOT NULL,
    [Period]          CHAR (6)      NOT NULL,
    [PriorBSRate]     FLOAT (53)    NOT NULL,
    [PriorPerEffDate] SMALLDATETIME NOT NULL,
    [RI_ID]           SMALLINT      NOT NULL,
    [SrcCuryID]       CHAR (4)      NOT NULL,
    [SrcLedgerID]     CHAR (10)     NOT NULL,
    [TrslId]          CHAR (10)     NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [WrkTrslHdr0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [TrslId] ASC, [Period] ASC) WITH (FILLFACTOR = 90)
);

