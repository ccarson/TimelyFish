CREATE TABLE 
	stage.FosterEvent(
		FosterEventKey	BIGINT			NOT NULL
	  , ParityEventKey	BIGINT			NOT NULL
      , SourceGUID      NVARCHAR(36)	NOT NULL
      , CONSTRAINT PK_stage_FosterEvent 
			PRIMARY KEY CLUSTERED ( FosterEventKey  ASC )
);

