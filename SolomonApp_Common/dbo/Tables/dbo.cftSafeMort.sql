CREATE TABLE [dbo].[cftSafeMort] (
    [CallDate]   CHAR (8)   NOT NULL,
    [CallTime]   CHAR (5)   NOT NULL,
    [CurrInv]    INT        NOT NULL,
    [PigGroupID] CHAR (10)  NOT NULL,
    [Qty]        INT        NOT NULL,
    [SDRefNo]    CHAR (6)   NOT NULL,
    [SiteID]     CHAR (4)   NOT NULL,
    [SiteRoom]   CHAR (10)  NOT NULL,
    [Statusflg]  CHAR (1)   NOT NULL,
    [SubType]    CHAR (3)   NOT NULL,
    [TranDate]   CHAR (8)   NOT NULL,
    [Type]       CHAR (1)   NOT NULL,
    [tstamp]     ROWVERSION NULL,
    CONSTRAINT [cftSafeMort0] PRIMARY KEY CLUSTERED ([SDRefNo] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [idx_cftSafeMort_PigGroupID_inc_CallDate_TranDate]
    ON [dbo].[cftSafeMort]([PigGroupID] ASC)
    INCLUDE([CallDate], [TranDate]) WITH (FILLFACTOR = 100);

