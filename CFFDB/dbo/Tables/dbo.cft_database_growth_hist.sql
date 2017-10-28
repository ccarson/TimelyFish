CREATE TABLE [dbo].[cft_database_growth_hist] (
    [crtd_ts]       DATETIME       NOT NULL,
    [name]          [sysname]      NOT NULL,
    [file_id]       SMALLINT       NOT NULL,
    [physical_name] NVARCHAR (260) NULL,
    [size_8k]       INT            NULL,
    [maxsize]       NVARCHAR (15)  NULL,
    [growth]        NVARCHAR (15)  NULL
);

