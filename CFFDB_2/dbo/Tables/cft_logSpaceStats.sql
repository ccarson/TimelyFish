CREATE TABLE [dbo].[cft_logSpaceStats] (
    [id]           INT             IDENTITY (1, 1) NOT NULL,
    [logDate]      DATETIME        DEFAULT (getdate()) NULL,
    [databaseName] [sysname]       NOT NULL,
    [logSize]      DECIMAL (18, 5) NULL,
    [logUsed]      DECIMAL (18, 5) NULL
);

