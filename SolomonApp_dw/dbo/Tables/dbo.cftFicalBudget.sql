CREATE TABLE [dbo].[cftFicalBudget] (
    [FicalBudgetID] BIGINT       IDENTITY (1, 1) NOT NULL,
    [Scenario]      VARCHAR (50) NULL,
    [Time]          VARCHAR (50) NULL,
    [Company]       VARCHAR (50) NULL,
    [Division]      VARCHAR (50) NULL,
    [Department]    VARCHAR (50) NULL,
    [Location]      VARCHAR (50) NULL,
    [Account]       VARCHAR (50) NULL,
    [Total]         MONEY        NULL,
    CONSTRAINT [PK_cftFicalBudget] PRIMARY KEY CLUSTERED ([FicalBudgetID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_cftFicalBudget_Account]
    ON [dbo].[cftFicalBudget]([Account] ASC) WITH (FILLFACTOR = 100);

