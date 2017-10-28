CREATE TABLE [dbo].[SLIndex] (
    [TableName]    [sysname] NOT NULL,
    [IndexName]    [sysname] NOT NULL,
    [IndexID]      INT       NULL,
    [IsClustered]  BIT       NULL,
    [IsUnique]     BIT       NULL,
    [IsPrimaryKey] BIT       NULL,
    CONSTRAINT [SLIndex0] PRIMARY KEY CLUSTERED ([TableName] ASC, [IndexName] ASC)
);

