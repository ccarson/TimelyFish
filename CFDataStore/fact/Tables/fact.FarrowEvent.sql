CREATE TABLE [fact].[FarrowEvent] (
    [FarrowEventKey]	BIGINT        IDENTITY (1, 1) NOT NULL,
    ParityEventKey		bigint			not null, 
    [EventDateKey]		INT           NOT NULL,
    [LocationKey]		BIGINT        NOT NULL,
    [Liveborn]			TINYINT       NOT NULL,
    [Stillborn]			TINYINT       NOT NULL,
    [Mummified]			TINYINT       NOT NULL,
    [WasAssisted]		BIT           NOT NULL,
    [WasInduced]		BIT           NOT NULL,
    [WasSubstandard]	BIT           NOT NULL,
    [CreatedDate]		DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]			BIGINT        DEFAULT ((-1)) NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [SourceID]       INT           NOT NULL,
    [SourceGUID]     NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([FarrowEventKey] ASC)
);
GO


CREATE INDEX IX_FarrowEvent_02 ON fact.FarrowEvent( EventDateKey ) ; 
GO

CREATE INDEX IX_FarrowEvent_03 ON fact.FarrowEvent( SourceID ) ; 
GO

CREATE INDEX IX_FarrowEvent_04 ON fact.FarrowEvent( SourceGUID ) ; 
GO

CREATE INDEX IX_FarrowEvent_05 ON fact.FarrowEvent( LocationKey ) ; 
GO

ALTER TABLE [fact].[FarrowEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


