CREATE TABLE [dbo].[cft_IndexConversion_RequiredActionList_20160309_205000] (
    [object_id]        INT           NULL,
    [schema_name]      [sysname]     NOT NULL,
    [table_name]       [sysname]     NOT NULL,
    [primary_key_name] [sysname]     DEFAULT (N'') NOT NULL,
    [index_id]         SMALLINT      NULL,
    [required_action]  NVARCHAR (50) DEFAULT (N'') NULL,
    [result]           NVARCHAR (20) DEFAULT (N'') NULL,
    [completed]        DATETIME      NULL
);

