CREATE TABLE [dbo].[cft_index_reorg_rebuild_list] (
    [database_name]    [sysname]      NOT NULL,
    [crtd_date]        DATETIME       NOT NULL,
    [tableid]          INT            NOT NULL,
    [tablename]        [sysname]      NOT NULL,
    [schemaname]       [sysname]      NOT NULL,
    [index_id]         INT            NOT NULL,
    [idxname]          [sysname]      NOT NULL,
    [partitionnum]     NVARCHAR (60)  NULL,
    [frag]             FLOAT (53)     NULL,
    [page_count]       INT            NULL,
    [command]          VARCHAR (4000) NULL,
    [after_frag]       FLOAT (53)     NULL,
    [after_page_count] INT            NULL
);

