CREATE TABLE [dbo].[SLIndexCol] (
    [TableName]    [sysname] NOT NULL,
    [IndexName]    [sysname] NOT NULL,
    [ColName]      [sysname] NOT NULL,
    [ColOrder]     INT       NULL,
    [IsDescending] BIT       NULL,
    [IsInclude]    BIT       NULL,
    CONSTRAINT [SLIndexCol0] PRIMARY KEY CLUSTERED ([TableName] ASC, [IndexName] ASC, [ColName] ASC)
);

