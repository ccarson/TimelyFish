CREATE TABLE [dbo].[cft_sowdata_purge_log] (
    [TableName]    NVARCHAR (128) NOT NULL,
    [Rows_deleted] INT            NOT NULL,
    [transdate]    DATETIME       NULL
);

