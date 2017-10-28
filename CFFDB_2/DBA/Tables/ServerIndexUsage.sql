CREATE TABLE [DBA].[ServerIndexUsage] (
    [RunDate]           DATETIME2 (7)   NOT NULL,
    [DatabaseName]      [sysname]       NOT NULL,
    [TableName]         [sysname]       NOT NULL,
    [IndexName]         [sysname]       NOT NULL,
    [index_id]          INT             NULL,
    [user_seeks]        BIGINT          NULL,
    [user_scans]        BIGINT          NULL,
    [user_lookups]      BIGINT          NULL,
    [Writes]            BIGINT          NULL,
    [has_filter]        BIT             NULL,
    [filter_definition] NVARCHAR (4000) NULL,
    [last_user_scan]    DATETIME        NULL,
    [last_user_lookup]  DATETIME        NULL,
    [last_user_seek]    DATETIME        NULL
);

