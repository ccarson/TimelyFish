CREATE TABLE [dbo].[cft_CORN_PURCHASING_INVENTORY] (
    [InventoryID]     INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedMillID]      VARCHAR (10)    NOT NULL,
    [CommodityID]     INT             NOT NULL,
    [InventoryDate]   SMALLDATETIME   NOT NULL,
    [Adjustments]     DECIMAL (10, 2) NOT NULL,
    [Balance]         DECIMAL (10, 2) NOT NULL,
    [DailyReceived]   DECIMAL (10, 2) NOT NULL,
    [DailyUsage]      DECIMAL (10, 2) NOT NULL,
    [CreatedDateTime] DATETIME        CONSTRAINT [DF_cft_CORN_PURCHASING_INVENTORY_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)    NOT NULL,
    [UpdatedDateTime] DATETIME        NULL,
    [UpdatedBy]       VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_CORN_PURCHASING_INVENTORY] PRIMARY KEY CLUSTERED ([InventoryID] ASC) WITH (FILLFACTOR = 90)
);

