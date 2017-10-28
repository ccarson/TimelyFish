CREATE TABLE [dbo].[SSISPigChamp_Log] (
    [log_id]        INT          IDENTITY (1, 1) NOT NULL,
    [crtd_DateTime] DATETIME     CONSTRAINT [DF_SSISPigChamp_Log_crtd_DateTime] DEFAULT (getdate()) NOT NULL,
    [sowdata_Table] VARCHAR (50) NOT NULL,
    [rows_Inserted] INT          NULL,
    [rows_Updated]  INT          NULL,
    [rows_Deleted]  INT          NULL,
    [lastEntryTS]   DATETIME     NOT NULL,
    CONSTRAINT [SSISPigChamp_Log_PK] PRIMARY KEY CLUSTERED ([log_id] ASC) WITH (FILLFACTOR = 80)
);

