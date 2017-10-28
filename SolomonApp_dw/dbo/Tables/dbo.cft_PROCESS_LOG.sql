CREATE TABLE [dbo].[cft_PROCESS_LOG] (
    [ProcessLogID]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [ProcessName]       VARCHAR (200) NOT NULL,
    [StepName]          VARCHAR (200) NULL,
    [ProcessExecutedBy] VARCHAR (50)  NULL,
    [ProcessStart]      DATETIME      NULL,
    [ProcessEnd]        DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ProcessLogID] ASC)
);

