CREATE TABLE [dbo].[cft_PIG_FLOW_REPORTING_GROUP] (
    [ReportingGroupID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Reporting_Group_Description] VARCHAR (100) NOT NULL,
    [CreatedDateTime]             DATETIME      CONSTRAINT [DF_cft_PIG_FLOW_REPORTING_GROUP_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                   VARCHAR (50)  NOT NULL,
    [UpdatedDateTime]             DATETIME      NULL,
    [UpdatedBy]                   VARCHAR (50)  NULL,
    CONSTRAINT [PK_cft_PIG_FLOW_REPORTING_GROUP] PRIMARY KEY CLUSTERED ([ReportingGroupID] ASC) WITH (FILLFACTOR = 90)
);
