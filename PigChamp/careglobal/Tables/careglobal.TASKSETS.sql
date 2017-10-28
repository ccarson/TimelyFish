CREATE TABLE [careglobal].[TASKSETS] (
    [taskset_id]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT           NOT NULL,
    [taskset_name]     VARCHAR (50)  NOT NULL,
    [frequency]        VARCHAR (20)  NOT NULL,
    [time]             VARCHAR (5)   NOT NULL,
    [folder]           VARCHAR (250) NULL,
    [ftp]              VARCHAR (250) NULL,
    [email_group_id]   INT           NULL,
    [email_notify_id]  INT           NULL,
    [next_start]       DATETIME      NULL,
    [disabled]         BIT           CONSTRAINT [DF_TASKSETS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT           CONSTRAINT [DF_TASKSETS_system] DEFAULT ((0)) NOT NULL,
    [creation_date]    DATETIME      CONSTRAINT [DF_TASKSETS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15)  CONSTRAINT [DF_TASKSETS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME      NULL,
    [last_update_by]   VARCHAR (15)  NULL,
    [deletion_date]    DATETIME      NULL,
    [deleted_by]       VARCHAR (15)  NULL,
    CONSTRAINT [PK_TASKSETS] PRIMARY KEY CLUSTERED ([taskset_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_TASKSETS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

