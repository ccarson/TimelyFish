﻿CREATE TABLE [dbo].[cft_SLF_FLOW_MONTH_ROLLUP] (
    [PigFlowID]               INT        NULL,
    [PigFlowDescription]      CHAR (50)  NULL,
    [FYPeriod]                CHAR (10)  NOT NULL,
    [TransferInWP_Qty]        FLOAT (53) NULL,
    [TransferIn_Qty]          FLOAT (53) NULL,
    [MoveIn_Qty]              FLOAT (53) NULL,
    [MoveOut_Qty]             FLOAT (53) NULL,
    [PigDeath_Qty]            FLOAT (53) NULL,
    [PigDeathTD_Qty]          FLOAT (53) NULL,
    [TransportDeath_Qty]      FLOAT (53) NULL,
    [InventoryAdjustment_Qty] FLOAT (53) NULL,
    [TransferOut_Qty]         FLOAT (53) NULL,
    [TransferToTailender_Qty] FLOAT (53) NULL,
    [Prim_Qty]                FLOAT (53) NULL,
    [Cull_Qty]                FLOAT (53) NULL,
    [DeadOnTruck_Qty]         FLOAT (53) NULL,
    [DeadInYard_Qty]          FLOAT (53) NULL,
    [Condemn_Qty]             FLOAT (53) NULL,
    [TransferInWP_Wt]         FLOAT (53) NULL,
    [TransferIn_Wt]           FLOAT (53) NULL,
    [MoveIn_Wt]               FLOAT (53) NULL,
    [MoveOut_Wt]              FLOAT (53) NULL,
    [PigDeathTD_Wt]           FLOAT (53) NULL,
    [TransportDeath_Wt]       FLOAT (53) NULL,
    [TransferOut_Wt]          FLOAT (53) NULL,
    [TransferToTailender_Wt]  FLOAT (53) NULL,
    [Prim_Wt]                 FLOAT (53) NULL,
    [Cull_Wt]                 FLOAT (53) NULL,
    [DeadOnTruck_Wt]          FLOAT (53) NULL,
    [DeadInYard_Wt]           FLOAT (53) NULL,
    [Condemn_Wt]              FLOAT (53) NULL,
    [DeadPigDays]             FLOAT (53) NULL,
    [LivePigDays]             FLOAT (53) NULL,
    [Feed_Qty]                FLOAT (53) NULL,
    [HdCapacity]              FLOAT (53) NULL,
    [MaxCapacityDays]         FLOAT (53) NULL,
    [EmptyCapacityDays]       FLOAT (53) NULL
);
