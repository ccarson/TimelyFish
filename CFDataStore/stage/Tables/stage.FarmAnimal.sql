CREATE TABLE 
	stage.FarmAnimal(
		FarmAnimalKey	BIGINT			NOT NULL
	  , AnimalKey		BIGINT			NOT NULL
	  , FarmKey			BIGINT			NOT NULL
	  , SourceGUID		NVARCHAR(36)	NOT NULL 
	  , CONSTRAINT PK_stage_FarmAnimal 
			PRIMARY KEY CLUSTERED( FarmAnimalKey ASC )
);
