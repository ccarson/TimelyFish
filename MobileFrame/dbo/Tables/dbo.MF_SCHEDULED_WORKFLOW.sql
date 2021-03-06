﻿CREATE TABLE [dbo].[MF_SCHEDULED_WORKFLOW] (
    [ID]              BIGINT        IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT        DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT        DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT        DEFAULT ((-1)) NOT NULL,
    [TASKID]          BIGINT        NULL,
    [STEPID]          BIGINT        NULL,
    [WORKFLOWTYPE]    BIGINT        NULL,
    [EVALUATIONORDER] INT           NULL,
    [FUNCTIONID]      NVARCHAR (40) NULL,
    [PARAMETERS]      IMAGE         NULL,
    CONSTRAINT [MF_SCHED_WORKFLOW_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ScheduledWorkflow_TaskID]
    ON [dbo].[MF_SCHEDULED_WORKFLOW]([TASKID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ScheduledWorkflow_StepID]
    ON [dbo].[MF_SCHEDULED_WORKFLOW]([STEPID] ASC) WITH (FILLFACTOR = 90);

