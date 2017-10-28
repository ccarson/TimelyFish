CREATE TABLE [dbo].[cft_PIG_FLOW_FARM_GROW_FINISH] (
    [PigFlowFarmID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PigFlowID]       INT          NOT NULL,
    [PigFlowFromDate] DATETIME     NOT NULL,
    [PigFlowToDate]   DATETIME     NULL,
    [ContactID]       INT          NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_PIG_FLOW_FARM_GROW_FINISH_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_PIG_FLOW_FARM_GROW_FINISH] PRIMARY KEY CLUSTERED ([PigFlowFarmID] ASC) WITH (FILLFACTOR = 90)
);

