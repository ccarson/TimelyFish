CREATE TABLE [fact].[ArrivalEvent] (
    [ArrivalEventKey]	BIGINT        IDENTITY (1, 1) NOT NULL,
    [FarmAnimalKey]		BIGINT        NOT NULL,
    [EventDateKey]		INT           NOT NULL,
    [CreatedDate]		DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]			BIGINT        DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [SourceID]			INT           NOT NULL,
    [SourceGUID]		NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([ArrivalEventKey] ASC)
);

GO
ALTER TABLE [fact].[ArrivalEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);
