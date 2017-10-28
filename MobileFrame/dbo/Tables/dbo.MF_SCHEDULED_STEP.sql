CREATE TABLE [dbo].[MF_SCHEDULED_STEP] (
    [ID]               BIGINT         IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]      DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]      DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]       BIGINT         DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY]  BIGINT         DEFAULT ((0)) NOT NULL,
    [DELETED_BY]       BIGINT         DEFAULT ((-1)) NOT NULL,
    [NAME]             NVARCHAR (255) NULL,
    [TASKID]           BIGINT         NULL,
    [ORDINAL]          INT            NULL,
    [INPUTTYPE]        INT            NULL,
    [INPUTMECHANISM]   INT            NULL,
    [MINVALUE]         NVARCHAR (16)  NULL,
    [MAXVALUE]         NVARCHAR (16)  NULL,
    [REQUIRED]         INT            NULL,
    [DEFAULTVALUE]     NVARCHAR (255) NULL,
    [REPORTCOLUMNNAME] NVARCHAR (80)  NULL,
    [FORMAT]           NVARCHAR (80)  NULL,
    [SYNCTYPE]         INT            NULL,
    [ATTRIBUTES]       IMAGE          NULL,
    CONSTRAINT [MF_SCHED_STEP_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ScheduledStep_TaskID]
    ON [dbo].[MF_SCHEDULED_STEP]([TASKID] ASC) WITH (FILLFACTOR = 90);

