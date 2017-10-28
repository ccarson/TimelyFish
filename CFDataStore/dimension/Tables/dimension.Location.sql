CREATE TABLE [dimension].[Location] (
    [LocationKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [FarmKey]     BIGINT        NOT NULL,
    [Barn]        NVARCHAR (10) NULL,
    [Room]        NVARCHAR (10) NULL,
    [Pen]         NVARCHAR (10) NULL,
    [CreatedDate] DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]   BIGINT        DEFAULT ((-1)) NOT NULL,
    [UpdatedDate] DATETIME      NULL,
    [UpdatedBy]   BIGINT        NULL,
    [DeletedDate] DATETIME      NULL,
    [DeletedBy]   BIGINT        NULL,
    [SourceCode]  NCHAR (10)    NULL,
    [SourceID]    INT           NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationKey] ASC)
);

GO
ALTER TABLE [dimension].[Location] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);



