CREATE TABLE [centralData].[Room] (
    [RoomKey]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [OtherColumns] NCHAR (10)       NULL,
    [SourceCode]   NVARCHAR (20)    CONSTRAINT [DF__Room__SourceCode__0D7A0286] DEFAULT (N'CentralData') NOT NULL,
    [SourceID]     INT              NOT NULL,
    [SourceGUID]   UNIQUEIDENTIFIER CONSTRAINT [DF__Room__SourceGUID__0E6E26BF] DEFAULT (newsequentialid()) NOT NULL,
    [SyncStatus]   NVARCHAR (20)    CONSTRAINT [DF_Room_SyncStatus] DEFAULT (N'To MobileFrame') NOT NULL,
    CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED ([RoomKey] ASC)
);



