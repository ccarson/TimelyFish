CREATE TABLE [caredata].[EXPENSE_TYPES] (
    [expense_type_id]   INT          NOT NULL,
    [shortname]         VARCHAR (15) NOT NULL,
    [longname]          VARCHAR (30) NOT NULL,
    [allocation_method] TINYINT      NOT NULL,
    [expense_category]  TINYINT      NOT NULL,
    [system]            BIT          CONSTRAINT [DF_EXPENSE_TYPES_system] DEFAULT ((0)) NOT NULL,
    [synonym]           VARCHAR (5)  NULL,
    [disabled]          BIT          CONSTRAINT [DF_EXPENSE_TYPES_disabled] DEFAULT ((0)) NOT NULL,
    [creation_date]     DATETIME     CONSTRAINT [DF_EXPENSE_TYPES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]        VARCHAR (15) CONSTRAINT [DF_EXPENSE_TYPES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]  DATETIME     NULL,
    [last_update_by]    VARCHAR (15) NULL,
    [deletion_date]     DATETIME     NULL,
    [deleted_by]        VARCHAR (15) NULL,
    CONSTRAINT [PK_EXPENSE_TYPES] PRIMARY KEY CLUSTERED ([expense_type_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_EXPENSE_TYPES_0]
    ON [caredata].[EXPENSE_TYPES]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

