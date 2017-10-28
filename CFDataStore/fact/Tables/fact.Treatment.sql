CREATE TABLE [fact].[Treatment] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [EventDate]   DATETIME      NOT NULL,
    [CreatedDate] DATETIME      CONSTRAINT [DF_Treatment_CreatedDate] DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]   BIGINT        CONSTRAINT [DF_Treatment_CreatedBy] DEFAULT ((-1)) NOT NULL,
    [UpdatedDate] DATETIME      NULL,
    [UpdatedBy]   BIGINT        NULL,
    [DeletedDate] DATETIME      NULL,
    [DeletedBy]   BIGINT        NULL,
    [SourceCode]  NVARCHAR (20) NOT NULL DEFAULT N'PigCHAMP',
    [SourceID]    INT           NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL
);









