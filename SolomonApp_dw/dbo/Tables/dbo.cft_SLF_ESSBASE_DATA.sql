CREATE TABLE [dbo].[cft_SLF_ESSBASE_DATA] (
    [Site]                        CHAR (30)     NOT NULL,
    [MasterGroup]                 CHAR (10)     NOT NULL,
    [MasterGroupDescription]      CHAR (40)     NOT NULL,
    [FlowGroup]                   CHAR (10)     NOT NULL,
    [FlowGroupDescription]        CHAR (50)     NOT NULL,
    [Group_Number]                CHAR (50)     NOT NULL,
    [Phase]                       CHAR (3)      NOT NULL,
    [PhaseTypeDesc]               CHAR (50)     NOT NULL,
    [PigFlowID]                   INT           NULL,
    [PigFlowDescription]          CHAR (50)     NULL,
    [PG_Week]                     CHAR (6)      NOT NULL,
    [MG_Week]                     CHAR (6)      NOT NULL,
    [Scenario]                    CHAR (30)     NOT NULL,
    [PigGroupFeedMill]            CHAR (50)     NOT NULL,
    [FlowGroupFeedMill]           CHAR (50)     NOT NULL,
    [TransferInWP_Qty]            FLOAT (53)    NULL,
    [TransferIn_Qty]              FLOAT (53)    NULL,
    [MoveIn_Qty]                  FLOAT (53)    NULL,
    [MoveOut_Qty]                 FLOAT (53)    NULL,
    [PigDeath_Qty]                FLOAT (53)    NULL,
    [PigDeathTD_Qty]              FLOAT (53)    NULL,
    [TransportDeath_Qty]          FLOAT (53)    NULL,
    [InventoryAdjustment_Qty]     FLOAT (53)    NULL,
    [TransferOut_Qty]             FLOAT (53)    NULL,
    [TransferToTailender_Qty]     FLOAT (53)    NULL,
    [Prim_Qty]                    FLOAT (53)    NULL,
    [Cull_Qty]                    FLOAT (53)    NULL,
    [DeadOnTruck_Qty]             FLOAT (53)    NULL,
    [DeadInYard_Qty]              FLOAT (53)    NULL,
    [Condemn_Qty]                 FLOAT (53)    NULL,
    [TransferInWP_Wt]             FLOAT (53)    NULL,
    [TransferIn_Wt]               FLOAT (53)    NULL,
    [MoveIn_Wt]                   FLOAT (53)    NULL,
    [MoveOut_Wt]                  FLOAT (53)    NULL,
    [PigDeathTD_Wt]               FLOAT (53)    NULL,
    [TransportDeath_Wt]           FLOAT (53)    NULL,
    [TransferOut_Wt]              FLOAT (53)    NULL,
    [TransferToTailender_Wt]      FLOAT (53)    NULL,
    [Prim_Wt]                     FLOAT (53)    NULL,
    [Cull_Wt]                     FLOAT (53)    NULL,
    [DeadOnTruck_Wt]              FLOAT (53)    NULL,
    [DeadInYard_Wt]               FLOAT (53)    NULL,
    [Condemn_Wt]                  FLOAT (53)    NULL,
    [DeadPigDays]                 FLOAT (53)    NULL,
    [LivePigDays]                 FLOAT (53)    NULL,
    [Feed_Qty]                    FLOAT (53)    NULL,
    [HdCapacity]                  FLOAT (53)    NULL,
    [MaxCapacityDays]             FLOAT (53)    NULL,
    [EmptyCapacityDays]           FLOAT (53)    NULL,
    [ReportingGroupID]            INT           NULL,
    [Reporting_Group_Description] VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Group_Number] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_cft_slf_essbase_data_mgweek_phase_rg_incl]
    ON [dbo].[cft_SLF_ESSBASE_DATA]([MG_Week] ASC, [ReportingGroupID] ASC, [Phase] ASC)
    INCLUDE([TransferInWP_Qty], [LivePigDays]) WITH (FILLFACTOR = 90);


GO
GRANT INSERT
    ON OBJECT::[dbo].[cft_SLF_ESSBASE_DATA] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_SLF_ESSBASE_DATA] TO PUBLIC
    AS [dbo];

