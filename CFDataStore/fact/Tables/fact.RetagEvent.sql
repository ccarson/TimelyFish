CREATE TABLE 
	[fact].[RetagEvent](
		[RetagEventKey]		BIGINT			NOT NULL IDENTITY , 
		OldAnimalTagKey		BIGINT			NOT NULL , 
		NewAnimalTagKey		BIGINT			NOT NULL , 
		EventDateKey		BIGINT      NOT NULL,
		CreatedDate DATETIME      DEFAULT (getutcdate()) NOT NULL,
		CreatedBy   BIGINT        DEFAULT ((-1)) NOT NULL,
		UpdatedDate DATETIME      NULL,
		UpdatedBy   BIGINT        NULL,
		DeletedDate DATETIME      NULL,
		DeletedBy   BIGINT        NULL,
		SourceCode  NVARCHAR (20) NOT NULL ,
		SourceID    INT           NOT NULL,
		SourceGUID  NVARCHAR (36) NOT NULL , 
		CONSTRAINT PK_RetagEvent PRIMARY KEY CLUSTERED( RetagEventKey ) )
;
GO

ALTER TABLE [fact].[RetagEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;
