CREATE TABLE [dbo].[cftSafeInj] (
    [CallDate]   CHAR (8)   NOT NULL,
    [CallTime]   CHAR (5)   NOT NULL,
    [PigGroupID] CHAR (10)  NOT NULL,
    [Qty]        INT        NOT NULL,
    [SDRefNo]    CHAR (6)   NOT NULL,
    [SiteID]     CHAR (4)   NOT NULL,
    [SiteRoom]   CHAR (10)  NOT NULL,
    [Statusflg]  CHAR (1)   NOT NULL,
    [TranDate]   CHAR (8)   NOT NULL,
    [Type]       CHAR (2)   NOT NULL,
    [tstamp]     ROWVERSION NULL,
    CONSTRAINT [cftSafeInj0] PRIMARY KEY CLUSTERED ([SDRefNo] ASC) WITH (FILLFACTOR = 90)
);

