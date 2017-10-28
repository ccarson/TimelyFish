CREATE TABLE [fact].[LocationEvent] (
    [LocationEventKey] BIGINT           IDENTITY (1, 1) NOT NULL,
    [LocationKey]      BIGINT           NOT NULL,
    [AnimalKey]        BIGINT           NOT NULL,
    [EventDate]        DATETIME         NOT NULL,
    [CreatedDate]      DATETIME         NOT NULL,
    [CreatedBy]        BIGINT           NOT NULL,
    [UpdatedDate]      DATETIME         NULL,
    [UpdatedBy]        BIGINT           NULL,
    [DeletedDate]      DATETIME         NULL,
    [DeletedBy]        BIGINT           NULL,
    [SourceCode]       NVARCHAR (20)    CONSTRAINT [DF__LocationE__Sourc__70DDC3D8] DEFAULT (N'PigChamp') NOT NULL,
    [SourceID]         INT              NOT NULL,
    [SourceGUID]       UNIQUEIDENTIFIER CONSTRAINT [DF__LocationE__Sourc__71D1E811] DEFAULT (newsequentialid()) NOT NULL,
    [SyncStatus]       NVARCHAR (20)    CONSTRAINT [DF_LocationEvent_SyncStatus] DEFAULT (N'To MobileFrame') NOT NULL,
    CONSTRAINT [PK_LocationEvent] PRIMARY KEY CLUSTERED ([LocationEventKey] ASC)
);



