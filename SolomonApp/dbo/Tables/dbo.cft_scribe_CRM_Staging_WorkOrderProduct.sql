﻿CREATE TABLE [dbo].[cft_scribe_CRM_Staging_WorkOrderProduct] (
    [f1_workorderproductId]          NVARCHAR (38)  NOT NULL,
    [CreatedOn]                      DATETIME       NULL,
    [CreatedBy]                      NVARCHAR (38)  NULL,
    [ModifiedOn]                     DATETIME       NULL,
    [ModifiedBy]                     NVARCHAR (38)  NULL,
    [CreatedOnBehalfBy]              NVARCHAR (38)  NULL,
    [ModifiedOnBehalfBy]             NVARCHAR (38)  NULL,
    [OwnerId]                        NVARCHAR (38)  NOT NULL,
    [OwnerIdType]                    INT            NOT NULL,
    [OwningBusinessUnit]             NVARCHAR (38)  NULL,
    [statecode]                      INT            NOT NULL,
    [statuscode]                     INT            NULL,
    [TransactionCurrencyId]          NVARCHAR (38)  NULL,
    [f1_TotalCost]                   MONEY          NULL,
    [f1_unitamount_Base]             MONEY          NULL,
    [f1_Quantity]                    FLOAT (53)     NULL,
    [f1_additionalcost_Base]         MONEY          NULL,
    [f1_Taxable]                     BIT            NULL,
    [f1_LineStatus]                  INT            NULL,
    [f1_Warehouse]                   NVARCHAR (38)  NULL,
    [f1_EstimateSubtotal]            MONEY          NULL,
    [f1_WorkOrderIncident]           NVARCHAR (38)  NULL,
    [f1_estimatetotalcost_Base]      MONEY          NULL,
    [f1_UnitAmount]                  MONEY          NULL,
    [f1_unitcost_Base]               MONEY          NULL,
    [f1_EstimateTotalAmount]         MONEY          NULL,
    [f1_estimatetotalamount_Base]    MONEY          NULL,
    [f1_estimateunitcost_Base]       MONEY          NULL,
    [f1_subtotal_Base]               MONEY          NULL,
    [f1_EstimateDiscount_money]      MONEY          NULL,
    [f1_AgreementProduct]            NVARCHAR (38)  NULL,
    [f1_estimateunitamount_Base]     MONEY          NULL,
    [f1_EstimateUnitAmount]          MONEY          NULL,
    [f1_InternalDescription]         NVARCHAR (MAX) NULL,
    [f1_totalamount_Base]            MONEY          NULL,
    [f1_Product]                     NVARCHAR (38)  NULL,
    [InvtID]                         CHAR (30)      NULL,
    [f1_ImportID]                    NVARCHAR (20)  NULL,
    [f1_EstimateQuantity]            FLOAT (53)     NULL,
    [f1_TotalAmount]                 MONEY          NULL,
    [f1_Subtotal]                    MONEY          NULL,
    [f1_estimatesubtotal_Base]       MONEY          NULL,
    [f1_Description]                 NVARCHAR (MAX) NULL,
    [f1_AdditionalCost]              MONEY          NULL,
    [f1_PriceList]                   NVARCHAR (38)  NULL,
    [f1_discount_money_Base]         MONEY          NULL,
    [f1_EstimateUnitCost]            MONEY          NULL,
    [f1_UnitCost]                    MONEY          NULL,
    [f1_estimatediscount_money_Base] MONEY          NULL,
    [f1_QtyToBill]                   FLOAT (53)     NULL,
    [f1_LineOrder_]                  INT            NULL,
    [f1_Discount_money]              MONEY          NULL,
    [f1_commissioncosts_Base]        MONEY          NULL,
    [f1_Allocated]                   BIT            NULL,
    [f1_name]                        NVARCHAR (200) NULL,
    [f1_POReceiptProduct]            NVARCHAR (38)  NULL,
    [f1_EstimateDiscount_percent]    FLOAT (53)     NULL,
    [f1_Printable]                   BIT            NULL,
    [f1_GeneratedEquipment]          NVARCHAR (38)  NULL,
    [f1_CustomerEquipment]           NVARCHAR (38)  NULL,
    [f1_Discount_percent]            FLOAT (53)     NULL,
    [f1_EstimateTotalCost]           MONEY          NULL,
    [f1_Unit]                        NVARCHAR (38)  NULL,
    [f1_WorkOrder]                   NVARCHAR (38)  NULL,
    [f1_LineStatusManualySet]        BIT            NULL,
    [f1_ResourceSchedule]            NVARCHAR (38)  NULL,
    [f1_totalcost_Base]              MONEY          NULL,
    [f1_CommissionCosts]             MONEY          NULL,
    [SyncStatus]                     BIT            NULL,
    [SyncDate]                       DATETIME       NULL,
    [WarehouseName]                  NVARCHAR (38)  NULL,
    [cf_InventoryUsedFromSite]       VARCHAR (1)    NULL,
    CONSTRAINT [PK_cft_scribe_CRM_Staging_WorkOrderProduct] PRIMARY KEY CLUSTERED ([f1_workorderproductId] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [cft_scribe_CRM_Staging_WorkOrderProduct_workorderid]
    ON [dbo].[cft_scribe_CRM_Staging_WorkOrderProduct]([f1_WorkOrder] ASC)
    INCLUDE([cf_InventoryUsedFromSite]) WITH (FILLFACTOR = 100);
