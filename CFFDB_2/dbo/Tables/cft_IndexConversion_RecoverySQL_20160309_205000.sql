CREATE TABLE [dbo].[cft_IndexConversion_RecoverySQL_20160309_205000] (
    [id]            INT            NOT NULL,
    [object_id]     INT            NOT NULL,
    [recovery_step] INT            NOT NULL,
    [sql_statement] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

