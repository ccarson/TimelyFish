CREATE TABLE [dbo].[cft_dba_index_dml_count] (
    [crtd_ts]      DATETIME  NOT NULL,
    [instname]     [sysname] NOT NULL,
    [dbname]       [sysname] NOT NULL,
    [tbl_name]     [sysname] NULL,
    [idx_name]     [sysname] NULL,
    [leaf_inserts] INT       NULL,
    [leaf_updates] INT       NULL,
    [leaf_deletes] INT       NULL
);

