CREATE TABLE [dbo].[cft_PACKER_DETAIL] (
    [CarcassID]     INT           NULL,
    [KillDate]      SMALLDATETIME NULL,
    [PMLoadID]      CHAR (10)     NULL,
    [SiteContactID] CHAR (10)     NULL,
    [BarnNbr]       CHAR (10)     NULL,
    [PigGroupID]    CHAR (10)     NULL,
    [PkrContactID]  CHAR (6)      NULL,
    [TotalHead]     INT           NOT NULL,
    [HotWgt]        FLOAT (53)    NOT NULL,
    [LeanPct]       FLOAT (53)    NOT NULL,
    [YldPct]        FLOAT (53)    NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_cft_PACKER_DETAIL_01]
    ON [dbo].[cft_PACKER_DETAIL]([SiteContactID] ASC, [KillDate] ASC, [HotWgt] ASC, [LeanPct] ASC)
    INCLUDE([PMLoadID]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cft_PACKER_DETAIL_02]
    ON [dbo].[cft_PACKER_DETAIL]([KillDate] ASC, [HotWgt] ASC, [LeanPct] ASC)
    INCLUDE([CarcassID], [PMLoadID], [SiteContactID], [BarnNbr], [PigGroupID], [PkrContactID], [TotalHead], [YldPct]) WITH (FILLFACTOR = 100);

