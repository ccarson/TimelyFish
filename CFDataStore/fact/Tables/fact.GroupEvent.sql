CREATE TABLE [fact].[GroupEvent] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [EventDate]   DATETIME      NOT NULL,
    [CreatedDate] DATETIME      NOT NULL,
    [CreatedBy]   BIGINT        NOT NULL,
    [UpdatedDate] DATETIME      NULL,
    [UpdatedBy]   BIGINT        NULL,
    [DeletedDate] DATETIME      NULL,
    [DeletedBy]   BIGINT        NULL,
    [SourceCode]  NVARCHAR (20) CONSTRAINT [DF__GroupEven__Sourc__6477ECF3] DEFAULT (N'PigChamp') NOT NULL,
    [SourceID]    INT           NOT NULL,
    [SourceGUID]  NVARCHAR (36) DEFAULT (CONVERT([nvarchar](36),newid())) NOT NULL
);





