CREATE TABLE [dbo].[cft_INVENTORY_BATCH] (
    [InventoryBatchID]         INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TicketNumber]             VARCHAR (20)    NOT NULL,
    [InventoryBatchNumber]     VARCHAR (10)    NULL,
    [GeneralLedgerBatchNumber] VARCHAR (10)    NULL,
    [StandardPrice]            DECIMAL (10, 4) NOT NULL,
    [ValuePrice]               DECIMAL (10, 4) NOT NULL,
    [CornClearingAmount]       DECIMAL (10, 4) NULL,
    [InventoryAmount]          DECIMAL (10, 4) NULL,
    [MarketVarianceAmount]     DECIMAL (10, 4) NULL,
    [CreatedDateTime]          DATETIME        CONSTRAINT [DF_cft_INVENTORY_BATCH_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]          DATETIME        NULL,
    [UpdatedBy]                VARCHAR (50)    NULL,
    [PartialTicketID]          INT             NOT NULL,
    CONSTRAINT [PK_cft_INVENTORY_BATCH] PRIMARY KEY CLUSTERED ([InventoryBatchID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_INVENTORY_BATCH_cft_PARTIAL_TICKET] FOREIGN KEY ([PartialTicketID]) REFERENCES [dbo].[cft_PARTIAL_TICKET] ([PartialTicketID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_INVENTORY_BATCH_PartialTicketID]
    ON [dbo].[cft_INVENTORY_BATCH]([PartialTicketID] ASC) WITH (FILLFACTOR = 90);

