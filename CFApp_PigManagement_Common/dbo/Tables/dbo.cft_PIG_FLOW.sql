CREATE TABLE [dbo].[cft_PIG_FLOW] (
    [PigFlowID]           INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PigFlowDescription]  VARCHAR (100)    NOT NULL,
    [PigFlowFromDate]     DATETIME         NOT NULL,
    [PigFlowToDate]       DATETIME         NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_PIG_FLOW_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [ReportingGroupID]    INT              DEFAULT ((0)) NOT NULL,
    [FlowMgrContactID]    INT              NULL,
    CONSTRAINT [PK_cft_PIG_FLOW] PRIMARY KEY CLUSTERED ([PigFlowID] ASC) WITH (FILLFACTOR = 90)
);

