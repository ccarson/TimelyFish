CREATE TABLE [dbo].[cft_scribe_CRM_f1_ProductInventoryStaging] (
    [CRM_productinventoryId]    NCHAR (38)     NOT NULL,
    [CRM_productId]             NCHAR (38)     NOT NULL,
    [f1_ProductId]              VARCHAR (100)  NOT NULL,
    [CRM_WarehouseId]           NCHAR (38)     NULL,
    [f1_WarehouseId]            VARCHAR (100)  NOT NULL,
    [OrganizationId]            NCHAR (38)     NULL,
    [statecode]                 INT            NOT NULL,
    [statuscode]                INT            NULL,
    [f1_QtyAllocated]           FLOAT (53)     NULL,
    [f1_Product]                NCHAR (38)     NULL,
    [f1_QtyOnHand]              FLOAT (53)     NULL,
    [f1_QtyOnOrder]             FLOAT (53)     NULL,
    [f1_Bin]                    NVARCHAR (100) NULL,
    [f1_ReorderPoint]           FLOAT (53)     NULL,
    [f1_Row]                    NVARCHAR (100) NULL,
    [f1_IsChangedViaTheJournal] BIT            NULL,
    [f1_name]                   NVARCHAR (100) NULL,
    [CRM_Unit]                  NVARCHAR (100) NULL,
    [f1_Unit]                   NCHAR (38)     NULL,
    [f1_QtyAvailable]           FLOAT (53)     NULL
);

