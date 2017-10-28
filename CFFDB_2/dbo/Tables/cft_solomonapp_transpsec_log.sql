CREATE TABLE [dbo].[cft_solomonapp_transpsec_log] (
    [Instance_name] [sysname] NOT NULL,
    [counter_name]  [sysname] NOT NULL,
    [cumvalue]      BIGINT    NOT NULL,
    [crtd_ts]       DATETIME  NOT NULL
);

