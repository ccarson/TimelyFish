CREATE TABLE [dbo].[cft_REPAIRS_PROBLEM_ID_COST] (
    [Account]                   CHAR (10)  NULL,
    [Division]                  CHAR (30)  NULL,
    [Location]                  CHAR (30)  NULL,
    [Capacity]                  INT        NULL,
    [GroupPeriod]               CHAR (6)   NULL,
    [RollupDescription]         CHAR (30)  NULL,
    [Description]               CHAR (30)  NULL,
    [TransactionDescription]    CHAR (30)  NULL,
    [FaultDescription]          CHAR (30)  NULL,
    [PurchaseOrderNumber]       CHAR (10)  NULL,
    [VendorId]                  CHAR (15)  NULL,
    [Amount]                    FLOAT (53) NULL,
    [ThreeMonthAmountPerSpace]  FLOAT (53) NULL,
    [SixMonthAmountPerSpace]    FLOAT (53) NULL,
    [TwelveMonthAmountPerSpace] FLOAT (53) NULL
);

