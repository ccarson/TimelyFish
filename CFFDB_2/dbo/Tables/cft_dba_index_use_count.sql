CREATE TABLE [dbo].[cft_dba_index_use_count] (
    [crtd_ts]  DATETIME  NOT NULL,
    [instname] [sysname] NOT NULL,
    [dbname]   [sysname] NOT NULL,
    [tbl_name] [sysname] NULL,
    [idx_name] [sysname] NULL,
    [useeks]   INT       NULL,
    [uscans]   INT       NULL,
    [ulookups] INT       NULL,
    [uupdates] INT       NULL
);

