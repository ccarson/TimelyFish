CREATE TABLE [caredata].[AI_STUDS] (
    [stud_id]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_AI_STUDS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_AI_STUDS_system] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_AI_STUDS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_AI_STUDS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_AI_STUDS] PRIMARY KEY CLUSTERED ([stud_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_AI_STUDS_0]
    ON [caredata].[AI_STUDS]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

