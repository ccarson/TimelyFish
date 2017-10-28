CREATE TABLE [dbo].[cft_INVENTORY_ROLLUP] (
    [SiteID]        CHAR (10)  NULL,
    [InvtID]        CHAR (30)  NULL,
    [TranType]      CHAR (2)   NULL,
    [FiscalYear]    INT        NULL,
    [FiscalPeriod]  INT        NULL,
    [QtyIssued]     FLOAT (53) NULL,
    [Cost]          FLOAT (53) NULL,
    [LastIssueDate] DATETIME   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_INVENTORY_ROLLUP2_SiteID]
    ON [dbo].[cft_INVENTORY_ROLLUP]([SiteID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_cft_INVENTORY_ROLLUP2_FiscalYear]
    ON [dbo].[cft_INVENTORY_ROLLUP]([FiscalYear] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_cft_INVENTORY_ROLLUP2_FiscalPeriod]
    ON [dbo].[cft_INVENTORY_ROLLUP]([FiscalPeriod] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_cft_INVENTORY_ROLLUP2_TranType]
    ON [dbo].[cft_INVENTORY_ROLLUP]([TranType] ASC) WITH (FILLFACTOR = 100);

