CREATE TABLE [careglobal].[TASKS] (
    [taskset_id] INT          NOT NULL,
    [task_name]  VARCHAR (50) NOT NULL,
    [task_type]  SMALLINT     NOT NULL,
    CONSTRAINT [PK_TASKS] PRIMARY KEY CLUSTERED ([taskset_id] ASC, [task_name] ASC, [task_type] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_TASKS_TASKSETS_0] FOREIGN KEY ([taskset_id]) REFERENCES [careglobal].[TASKSETS] ([taskset_id]) ON DELETE CASCADE
);

