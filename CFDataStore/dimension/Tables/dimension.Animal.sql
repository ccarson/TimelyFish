CREATE TABLE [dimension].[Animal] (
    [AnimalKey]   BIGINT        NOT NULL,
    [GeneticsKey] BIGINT        NOT NULL,
    [OriginKey]   BIGINT        NOT NULL,
    [DateOfBirth] DATETIME      NULL,
    [Sex]         NCHAR (1)     NOT NULL,
    [CreatedDate] DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]   BIGINT        DEFAULT ((-1)) NOT NULL,
    [UpdatedDate] DATETIME      NULL,
    [UpdatedBy]   BIGINT        NULL,
    [SourceCode]  NVARCHAR (20) NOT NULL,
    [SourceID]    INT           NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([AnimalKey] ASC)
);

GO
ALTER TABLE [dimension].[Animal] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

