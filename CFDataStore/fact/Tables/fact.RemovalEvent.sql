CREATE TABLE [fact].[RemovalEvent] (
    [RemovalEventKey]	BIGINT			IDENTITY  NOT NULL, 
    [FarmAnimalKey]		BIGINT			NOT NULL,
    [EventDateKey]		INT				NOT NULL,
    [RemovalTypeKey]	INT				NOT NULL,
	[RemovalReasonKey]	INT				NOT NULL, 
    [CreatedDate]		DATETIME		DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]			BIGINT			DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [SourceID]			INT				NOT NULL,
    [SourceGUID]		NVARCHAR(36)	NOT NULL, 
	CONSTRAINT PK_RemovalEvent PRIMARY KEY CLUSTERED ( RemovalEventKey ) 
);
GO

ALTER TABLE [fact].[RemovalEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;









