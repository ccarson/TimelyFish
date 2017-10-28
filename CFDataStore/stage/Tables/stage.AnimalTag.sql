CREATE TABLE 
	stage.AnimalTag( 
		AnimalTagKey	BIGINT			NOT NULL
	  , AnimalKey		BIGINT			NOT NULL
	  , SourceGUID		NVARCHAR(36)	NOT NULL
	  , CONSTRAINT PK_stage_AnimalTag
			PRIMARY KEY CLUSTERED( AnimalTagKey ASC ) 
);
