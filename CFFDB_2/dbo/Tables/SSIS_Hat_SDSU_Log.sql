CREATE TABLE [dbo].[SSIS_Hat_SDSU_Log] (
    [log_id]        INT          IDENTITY (1, 1) NOT NULL,
    [crtd_DateTime] DATETIME     CONSTRAINT [DF_SSIS_Hat_SDSU_Log_crtd_DateTime] DEFAULT (getdate()) NOT NULL,
    [Result_code]   VARCHAR (2)  NOT NULL,
    [Result_File]   VARCHAR (25) NULL,
    [Lab]           VARCHAR (5)  NULL,
    [lastEntryTS]   DATETIME     NOT NULL,
    CONSTRAINT [SSIS_Hat_SDSU_Log_PK] PRIMARY KEY CLUSTERED ([log_id] ASC) WITH (FILLFACTOR = 80)
);

