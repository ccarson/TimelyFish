CREATE TABLE [caredata].[FLAGS] (
    [flag_id]          INT          NOT NULL,
    [shortname]        VARCHAR (1)  COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [sex]              VARCHAR (1)  NULL,
    [disabled]         BIT          CONSTRAINT [DF_FLAGS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_FLAGS_system] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_FLAGS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_FLAGS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_FLAGS] PRIMARY KEY CLUSTERED ([flag_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_FLAGS_0]
    ON [caredata].[FLAGS]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

