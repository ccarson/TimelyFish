CREATE TABLE [dbo].[cftSafeFeed] (
    [BinInv]     SMALLINT   NOT NULL,
    [BinNbr]     CHAR (6)   NOT NULL,
    [CallDate]   CHAR (8)   NOT NULL,
    [CallTime]   CHAR (5)   NOT NULL,
    [Company]    CHAR (2)   NOT NULL,
    [DateReq]    CHAR (8)   NOT NULL,
    [Manager]    CHAR (10)  NOT NULL,
    [OrdType]    CHAR (2)   NULL,
    [Phase]      SMALLINT   NOT NULL,
    [PigGroupID] CHAR (10)  NOT NULL,
    [QtyOrd]     INT        NOT NULL,
    [SDRefNo]    CHAR (6)   NOT NULL,
    [SiteID]     CHAR (4)   NOT NULL,
    [SiteRoom]   CHAR (10)  NOT NULL,
    [Statusflg]  CHAR (1)   NOT NULL,
    [SysDate]    CHAR (8)   NOT NULL,
    [tstamp]     ROWVERSION NULL,
    CONSTRAINT [cftSafeFeed0] PRIMARY KEY CLUSTERED ([SDRefNo] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_cftSafeFeed_Statusflg]
    ON [dbo].[cftSafeFeed]([Statusflg] ASC) WITH (FILLFACTOR = 90);

