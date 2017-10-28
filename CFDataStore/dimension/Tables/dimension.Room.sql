CREATE TABLE [dimension].[Room] (
    [ID]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate] DATETIME         NOT NULL,
    [CreatedBy]   BIGINT           NOT NULL,
    [UpdatedDate] DATETIME         NULL,
    [UpdatedBy]   BIGINT           NULL,
    [DeletedDate] DATETIME         NULL,
    [DeletedBy]   BIGINT           NULL,
    [SourceCode]  NVARCHAR (20)    CONSTRAINT [DF__Room__SourceCode__5AEE82B9] DEFAULT (N'PigChamp') NOT NULL,
    [SourceID]    INT              NOT NULL,
    [SourceGUID]  UNIQUEIDENTIFIER CONSTRAINT [DF__Room__SourceGUID__5BE2A6F2] DEFAULT (newsequentialid()) NOT NULL
);





