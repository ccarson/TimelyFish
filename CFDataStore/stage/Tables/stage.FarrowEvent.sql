CREATE TABLE 
	stage.FarrowEvent(
		FarrowEventKey	BIGINT			NOT NULL
	  , ParityEvenKey	BIGINT			NOT NULL
      , SourceGUID      NVARCHAR(36)	NOT NULL
      , CONSTRAINT PK_stage_FarrowEvent 
			PRIMARY KEY CLUSTERED ( FarrowEventKey  ASC )
);

