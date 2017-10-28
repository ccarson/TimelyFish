CREATE TABLE [dbo].[cft_dm_db_index_usage_stats] (
    [rtime_date]       DATETIME       NOT NULL,
    [servername]       NVARCHAR (128) NULL,
    [dbname]           NVARCHAR (128) NULL,
    [tablename]        NVARCHAR (128) NULL,
    [object_id]        INT            NOT NULL,
    [name]             [sysname]      NULL,
    [index_id]         INT            NOT NULL,
    [user_seeks]       BIGINT         NOT NULL,
    [user_scans]       BIGINT         NOT NULL,
    [user_lookups]     BIGINT         NOT NULL,
    [Total Reads]      BIGINT         NULL,
    [user_writes]      BIGINT         NOT NULL,
    [last_user_seek]   DATETIME       NULL,
    [last_user_lookup] DATETIME       NULL,
    [last_user_scan]   DATETIME       NULL,
    [last_user_update] DATETIME       NULL
);

