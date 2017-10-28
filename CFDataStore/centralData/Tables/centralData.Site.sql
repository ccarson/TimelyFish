CREATE TABLE [centralData].[Site] (
    [ID]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate] DATETIME         NOT NULL,
    [CreatedBy]   BIGINT           NOT NULL,
    [UpdatedDate] DATETIME         NULL,
    [UpdatedBy]   BIGINT           NULL,
    [DeletedDate] DATETIME         NULL,
    [DeletedBy]   BIGINT           NULL,
    [SourceCode]  NVARCHAR (20)    CONSTRAINT [DF__Site__SourceCode__3D5E1FD2] DEFAULT (N'CentralData') NOT NULL,
    [SourceID]    INT              NOT NULL,
    [SourceGUID]  UNIQUEIDENTIFIER CONSTRAINT [DF__Site__SourceGUID__3E52440B] DEFAULT (newsequentialid()) NOT NULL,
    [SyncStatus]  NVARCHAR (20)    CONSTRAINT [DF_Site_SyncStatus] DEFAULT (N'To MobileFrame') NOT NULL
);



