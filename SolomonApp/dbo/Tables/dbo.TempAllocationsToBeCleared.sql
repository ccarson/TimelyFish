CREATE TABLE [dbo].[TempAllocationsToBeCleared] (
    [ID]              INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Company]         NVARCHAR (10) NULL,
    [Natural Account] NVARCHAR (10) NULL,
    [SubAccount]      NVARCHAR (24) NULL,
    [Fiscal Year]     NVARCHAR (4)  NULL,
    CONSTRAINT [TempAllocationsToBeCleared0] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

