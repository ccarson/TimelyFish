CREATE TABLE [dbo].[cft_ProcessLog] (
    [LogID]             INT            IDENTITY (1, 1) NOT NULL,
    [DatabaseName]      NVARCHAR (128) NOT NULL,
    [ProcessName]       VARCHAR (50)   NOT NULL,
    [ProcessStatus]     TINYINT        NULL,
    [StartTime]         DATETIME       NULL,
    [EndTime]           DATETIME       NULL,
    [Records_Processed] BIGINT         NULL,
    [Comments]          VARCHAR (2000) NULL,
    [Error]             INT            NULL,
    [Criteria]          VARCHAR (2000) NULL
);

