CREATE TABLE [careglobal].[EMAIL_GROUPS] (
    [group_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [group_name]       VARCHAR (30) NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EMAIL_GROUPS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EMAIL_GROUPS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EMAIL_GROUPS] PRIMARY KEY CLUSTERED ([group_id] ASC) WITH (FILLFACTOR = 90)
);

