CREATE TABLE [dimension].[Barn] (
    [ID]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate] DATETIME         NOT NULL,
    [CreatedBy]   BIGINT           NOT NULL,
    [UpdatedDate] DATETIME         NULL,
    [UpdatedBy]   BIGINT           NULL,
    [DeletedDate] DATETIME         NULL,
    [DeletedBy]   BIGINT           NULL,
    [SourceCode]  NVARCHAR (20)    CONSTRAINT [DF__Barn__SourceCode__4CA06362] DEFAULT (N'PigChamp') NOT NULL,
    [SourceID]    INT              NOT NULL,
    [SourceGUID]  UNIQUEIDENTIFIER CONSTRAINT [DF__Barn__SourceGUID__4D94879B] DEFAULT (newsequentialid()) NOT NULL
);





