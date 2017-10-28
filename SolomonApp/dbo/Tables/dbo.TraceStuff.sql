CREATE TABLE [dbo].[TraceStuff] (
    [RowNumber]       INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EventClass]      INT            NULL,
    [TextData]        NTEXT          NULL,
    [NTUserName]      NVARCHAR (128) NULL,
    [ClientProcessID] INT            NULL,
    [ApplicationName] NVARCHAR (128) NULL,
    [LoginName]       NVARCHAR (128) NULL,
    [SPID]            INT            NULL,
    [Duration]        BIGINT         NULL,
    [StartTime]       DATETIME       NULL,
    [Reads]           BIGINT         NULL,
    [Writes]          BIGINT         NULL,
    [CPU]             INT            NULL,
    PRIMARY KEY CLUSTERED ([RowNumber] ASC) WITH (FILLFACTOR = 90)
);

