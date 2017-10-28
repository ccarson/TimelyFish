CREATE TABLE [fact].[MatingEvent] (
    [MatingEventKey]	BIGINT			IDENTITY (1, 1) NOT NULL,
    [ParityEventKey]	BIGINT			NOT NULL,
    [EventDateKey]		INT				NOT NULL,
    [MaleGeneticsKey]	BIGINT			NOT NULL,
    [MatingGroupKey]	BIGINT			NULL,
    [ObserverKey]		BIGINT			NULL,
    [TimeOfDayCode]		INT				NOT NULL,
	BreedingNumber		TINYINT			NULL,
	ParityServiceNumber		TINYINT			NULL,
	BreedingStatus		NVARCHAR(01)	NULL, 
    [MatingNumber]		TINYINT			NULL,
    [CreatedDate]		DATETIME		DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]			BIGINT			DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [SourceID]			INT				NOT NULL,
    [SourceGUID]		NVARCHAR (36)	NOT NULL,
    CONSTRAINT [PK_MatingEvent] PRIMARY KEY CLUSTERED ([MatingEventKey] ASC)
);

GO

CREATE INDEX IX_MatingEvent_01
	ON fact.MatingEvent( 
		MatingGroupKey, EventDateKey ) 
GO

ALTER TABLE [fact].[MatingEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

