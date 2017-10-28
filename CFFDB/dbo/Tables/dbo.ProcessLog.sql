CREATE TABLE [dbo].[ProcessLog] (
    [LogID]             INT            IDENTITY (1, 1) NOT NULL,
    [ProcessName]       VARCHAR (50)   NULL,
    [ProcessStatus]     TINYINT        NULL,
    [StartTime]         DATETIME       NULL,
    [EndTime]           DATETIME       NULL,
    [Records_Processed] BIGINT         NULL,
    [Comments]          VARCHAR (2000) NULL,
    [Error]             INT            NULL,
    [Criteria]          VARCHAR (2000) NULL,
    CONSTRAINT [PK_ProcessLog] PRIMARY KEY CLUSTERED ([LogID] ASC) WITH (FILLFACTOR = 90)
);

