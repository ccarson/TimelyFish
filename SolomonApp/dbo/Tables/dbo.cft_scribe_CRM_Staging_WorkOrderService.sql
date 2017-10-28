CREATE TABLE [dbo].[cft_scribe_CRM_Staging_WorkOrderService] (
    [f1_workorderserviceId]                NVARCHAR (38)    NOT NULL,
    [CreatedOn]                            DATETIME         NULL,
    [CreatedBy]                            NVARCHAR (38)    NULL,
    [ModifiedOn]                           DATETIME         NULL,
    [ModifiedBy]                           NVARCHAR (38)    NULL,
    [CreatedOnBehalfBy]                    NVARCHAR (38)    NULL,
    [ModifiedOnBehalfBy]                   NVARCHAR (38)    NULL,
    [OwnerId]                              NVARCHAR (38)    NOT NULL,
    [OwnerIdType]                          INT              NOT NULL,
    [OwningBusinessUnit]                   NVARCHAR (38)    NULL,
    [statecode]                            INT              NOT NULL,
    [statuscode]                           INT              NULL,
    [TransactionCurrencyId]                NVARCHAR (38)    NULL,
    [ExchangeRate]                         DECIMAL (23, 10) NULL,
    [f1_estimatecalculatedunitamount_Base] MONEY            NULL,
    [f1_TotalCost]                         MONEY            NULL,
    [f1_MinimumChargeAmount]               MONEY            NULL,
    [f1_Unit]                              NVARCHAR (38)    NULL,
    [f1_WorkOrder]                         NVARCHAR (38)    NULL,
    [f1_EstimateDiscount_money]            MONEY            NULL,
    [f1_EstimateDiscount_percent]          FLOAT (53)       NULL,
    [f1_Duration]                          INT              NULL,
    [f1_additionalcost_Base]               MONEY            NULL,
    [f1_Subtotal]                          MONEY            NULL,
    [f1_EstimateDuration]                  INT              NULL,
    [f1_totalcost_Base]                    MONEY            NULL,
    [f1_InternalDescription]               NVARCHAR (MAX)   NULL,
    [f1_discount_money_Base]               MONEY            NULL,
    [f1_DurationToBill]                    INT              NULL,
    [f1_AdditionalCost]                    MONEY            NULL,
    [f1_calculatedunitamount_Base]         MONEY            NULL,
    [f1_CalculatedUnitAmount]              MONEY            NULL,
    [f1_EstimateTotalCost]                 MONEY            NULL,
    [f1_unitcost_Base]                     MONEY            NULL,
    [f1_AgreementService]                  NVARCHAR (38)    NULL,
    [f1_EstimateUnitCost]                  MONEY            NULL,
    [f1_UnitCost]                          MONEY            NULL,
    [f1_TotalAmount]                       MONEY            NULL,
    [f1_LineStatus]                        INT              NULL,
    [f1_unitamount_Base]                   MONEY            NULL,
    [f1_estimatesubtotal_Base]             MONEY            NULL,
    [f1_UnitAmount]                        MONEY            NULL,
    [f1_estimatediscount_money_Base]       MONEY            NULL,
    [f1_EstimateTotalAmount]               MONEY            NULL,
    [f1_EstimateUnitAmount]                MONEY            NULL,
    [f1_Discount_percent]                  FLOAT (53)       NULL,
    [f1_CommissionCosts]                   MONEY            NULL,
    [f1_estimateunitamount_Base]           MONEY            NULL,
    [f1_totalamount_Base]                  MONEY            NULL,
    [f1_EstimateCalculatedUnitAmount]      MONEY            NULL,
    [InvtID]                               CHAR (30)        NULL,
    [f1_Taxable]                           BIT              NULL,
    [f1_commissioncosts_Base]              MONEY            NULL,
    [f1_Discount_money]                    MONEY            NULL,
    [f1_Service]                           NVARCHAR (38)    NULL,
    [f1_WorkOrderIncident]                 NVARCHAR (38)    NULL,
    [f1_estimatetotalamount_Base]          MONEY            NULL,
    [f1_estimatetotalcost_Base]            MONEY            NULL,
    [f1_LineOrder]                         INT              NULL,
    [f1_Printable]                         BIT              NULL,
    [f1_subtotal_Base]                     MONEY            NULL,
    [f1_PriceList]                         NVARCHAR (38)    NULL,
    [f1_ImportID]                          NVARCHAR (20)    NULL,
    [f1_Description]                       NVARCHAR (MAX)   NULL,
    [f1_ResourceSchedule]                  NVARCHAR (38)    NULL,
    [f1_CustomerEquipment]                 NVARCHAR (38)    NULL,
    [f1_EstimateSubtotal]                  MONEY            NULL,
    [f1_MinimumChargeDuration]             INT              NULL,
    [f1_name]                              NVARCHAR (200)   NULL,
    [f1_minimumchargeamount_Base]          MONEY            NULL,
    [f1_estimateunitcost_Base]             MONEY            NULL,
    [SyncStatus]                           BIT              NULL,
    [SyncDate]                             DATETIME         NULL,
    [WarehouseName]                        NVARCHAR (38)    NULL,
    CONSTRAINT [PK_cft_scribe_CRM_Staging_WorkOrderService] PRIMARY KEY CLUSTERED ([f1_workorderserviceId] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [cft_scribe_CRM_Staging_WorkOrderService_workorderid]
    ON [dbo].[cft_scribe_CRM_Staging_WorkOrderService]([f1_WorkOrder] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cft_scribe_CRM_Staging_WorkOrderService_statecode_inc_f1_workorder]
    ON [dbo].[cft_scribe_CRM_Staging_WorkOrderService]([statecode] ASC)
    INCLUDE([f1_workorderserviceId], [f1_Description], [f1_name], [WarehouseName], [InvtID], [f1_Taxable], [f1_Service], [f1_WorkOrderIncident], [f1_LineOrder], [f1_subtotal_Base], [f1_UnitCost], [f1_TotalAmount], [f1_LineStatus], [f1_unitamount_Base], [f1_UnitAmount], [f1_totalamount_Base], [f1_TotalCost], [f1_WorkOrder], [f1_Duration], [f1_Subtotal], [f1_totalcost_Base], [f1_unitcost_Base]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cft_scribe_CRM_Staging_WorkOrderService_f1_workorderserviceID]
    ON [dbo].[cft_scribe_CRM_Staging_WorkOrderService]([f1_workorderserviceId] ASC) WITH (FILLFACTOR = 100);

