CREATE TABLE 
	stage.FalloutEvent(
		FalloutEventKey BIGINT			NOT NULL
	  , ParityEventKey	BIGINT			NOT NULL
      , SourceGUID      NVARCHAR(36)	NOT NULL
      , CONSTRAINT PK_stage_FalloutEvent 
			PRIMARY KEY CLUSTERED ( FalloutEventKey  ASC )
);

