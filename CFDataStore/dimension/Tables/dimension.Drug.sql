CREATE TABLE [dimension].[Drug] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED,
    [CreatedDate] DATETIME      NOT NULL,
    [CreatedBy]   BIGINT        NOT NULL,
    [UpdatedDate] DATETIME      NULL,
    [UpdatedBy]   BIGINT        NULL,
    [DeletedDate] DATETIME      NULL,
    [DeletedBy]   BIGINT        NULL,
    [SourceID]    INT           NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL
);
