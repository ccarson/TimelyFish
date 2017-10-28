CREATE TABLE [dbo].[WrkDefExpt] (
    [Acct]        CHAR (10)  NOT NULL,
    [Active]      SMALLINT   NOT NULL,
    [AcctType]    CHAR (2)   NOT NULL,
    [DstCuryID]   CHAR (4)   NOT NULL,
    [DstLedgerID] CHAR (10)  NOT NULL,
    [PTDBal]      FLOAT (53) NOT NULL,
    [RI_ID]       SMALLINT   NOT NULL,
    [SrcCuryID]   CHAR (4)   NOT NULL,
    [SrcLedgerID] CHAR (10)  NOT NULL,
    [Sub]         CHAR (24)  NOT NULL,
    [TrslID]      CHAR (10)  NOT NULL,
    [TrslDesc]    CHAR (30)  NOT NULL,
    [YTDBal]      FLOAT (53) NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);

