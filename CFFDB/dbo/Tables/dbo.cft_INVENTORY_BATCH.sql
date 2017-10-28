CREATE TABLE [dbo].[cft_INVENTORY_BATCH] (
    [InventoryBatchID]         INT             IDENTITY (1, 1) NOT NULL,
    [TicketNumber]             VARCHAR (20)    NOT NULL,
    [InventoryBatchNumber]     VARCHAR (10)    NULL,
    [GeneralLedgerBatchNumber] VARCHAR (10)    NULL,
    [StandardPrice]            DECIMAL (10, 4) NOT NULL,
    [ValuePrice]               DECIMAL (10, 4) NOT NULL,
    [CornClearingAmount]       DECIMAL (10, 4) NULL,
    [InventoryAmount]          DECIMAL (10, 4) NULL,
    [MarketVarianceAmount]     DECIMAL (10, 4) NULL,
    [CreatedDateTime]          DATETIME        NOT NULL,
    [CreatedBy]                VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]          DATETIME        NULL,
    [UpdatedBy]                VARCHAR (50)    NULL,
    [PartialTicketID]          INT             NOT NULL
);

