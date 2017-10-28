CREATE TABLE [caredata].[ENVIRONMENT_DATA_TYPES] (
    [environment_type_id] INT          NOT NULL,
    [shortname]           VARCHAR (15) NOT NULL,
    [longname]            VARCHAR (30) NOT NULL,
    [allocation_method]   TINYINT      NOT NULL,
    [system]              BIT          CONSTRAINT [DF_ENVIRONMENT_DATA_TYPES_system] DEFAULT ((0)) NOT NULL,
    [synonym]             VARCHAR (5)  NULL,
    [min_max]             BIT          CONSTRAINT [DF_ENVIRONMENT_DATA_TYPES_min_max] DEFAULT ((0)) NOT NULL,
    [decimal_places]      TINYINT      CONSTRAINT [DF_ENVIRONMENT_DATA_TYPES_decimal_places] DEFAULT ((0)) NOT NULL,
    [min_value]           FLOAT (53)   NULL,
    [max_value]           FLOAT (53)   NULL,
    [disabled]            BIT          CONSTRAINT [DF_ENVIRONMENT_DATA_TYPES_disabled] DEFAULT ((0)) NOT NULL,
    [creation_date]       DATETIME     CONSTRAINT [DF_ENVIRONMENT_DATA_TYPES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]          VARCHAR (15) CONSTRAINT [DF_ENVIRONMENT_DATA_TYPES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]    DATETIME     NULL,
    [last_update_by]      VARCHAR (15) NULL,
    [deletion_date]       DATETIME     NULL,
    [deleted_by]          VARCHAR (15) NULL,
    CONSTRAINT [PK_ENVIRONMENT_DATA_TYPES] PRIMARY KEY CLUSTERED ([environment_type_id] ASC) WITH (FILLFACTOR = 80)
);

