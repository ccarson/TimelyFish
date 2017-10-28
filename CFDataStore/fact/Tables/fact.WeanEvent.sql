CREATE TABLE 
	fact.WeanEvent(
		WeanEventKey		BIGINT			NOT NULL	IDENTITY
	  , ParityEventKey		BIGINT			NOT NULL
	  , WeanEventTypeKey	INT				NOT NULL 
	  , EventDateKey		INT				NOT NULL
	  , WeanedQuantity		INT				NOT NULL
	  , CreatedDate			DATETIME      NOT NULL	DEFAULT (getdate()) 
	  , CreatedBy			BIGINT        NOT NULL	DEFAULT ((-1)) 
	  , UpdatedDate			DATETIME      
	  , UpdatedBy			BIGINT        
	  , DeletedDate			DATETIME      
	  , DeletedBy			BIGINT        
      , SourceCode			NVARCHAR (20) NOT NULL	
	  , SourceID			INT           NOT NULL
	  , SourceGUID			NVARCHAR (36) NOT NULL
	  , CONSTRAINT PK_WeanEvent PRIMARY KEY CLUSTERED( WeanEventKey ) ) 
;
GO

ALTER TABLE [fact].[WeanEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;

