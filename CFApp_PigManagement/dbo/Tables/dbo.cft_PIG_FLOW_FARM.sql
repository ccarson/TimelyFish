CREATE TABLE [dbo].[cft_PIG_FLOW_FARM] (
    [PigFlowFarmID]       INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PigFlowID]           INT              NOT NULL,
    [ContactID]           INT              NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_PIG_FLOW_FARM_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_PIG_FLOW_FARM] PRIMARY KEY CLUSTERED ([PigFlowFarmID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_PIG_FLOW_FARM] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];

