CREATE TABLE [dimension].[AnimalTag] (
    [AnimalTagKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [AnimalKey]    BIGINT        NOT NULL,
    [TagNumber]    NVARCHAR (20) NOT NULL,
    [TagDate]      DATETIME      NULL,
    [IsPrimaryTag] BIT           NOT NULL,
    [IsCurrentTag] BIT           DEFAULT ((1)) NOT NULL,
    [CreatedDate]  DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]    BIGINT        DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]  DATETIME      NULL,
    [UpdatedBy]    BIGINT        NULL,
    [DeletedDate]  DATETIME      NULL,
    [DeletedBy]    BIGINT        NULL,
    [SourceCode]     NVARCHAR (20) NOT NULL DEFAULT N'PigCHAMP' ,
    [SourceID]     INT           NOT NULL,
    [SourceGUID]   NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([AnimalTagKey] ASC)
);


GO
ALTER TABLE [dimension].[AnimalTag] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

