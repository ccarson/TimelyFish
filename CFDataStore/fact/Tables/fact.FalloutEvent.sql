CREATE TABLE 
	[fact].[FalloutEvent] (
		[FalloutEventKey]		BIGINT			NOT NULL	IDENTITY , 
		[ParityEventKey]		BIGINT			NOT NULL,
		[EventDateKey]			INT				NOT NULL,
		[FalloutEventTypeKey]	INT				NULL,
		[CreatedDate]			DATETIME		NOT NULL	DEFAULT (getutcdate()) , 
		[CreatedBy]				BIGINT			NOT NULL	DEFAULT ((-1)) , 
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
		[SourceCode]			NVARCHAR(20)	NOT NULL , 
		[SourceID]				INT				NOT NULL,
		[SourceGUID]			NVARCHAR(36)	NOT NULL, 
		CONSTRAINT PK_FalloutEvent 
			PRIMARY KEY CLUSTERED( FalloutEventKey ) ) 
;
GO

ALTER TABLE [fact].[FalloutEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;



 
 	