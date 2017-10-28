CREATE TABLE stage.Animal(
	AnimalKey	BIGINT			NOT NULL
  , SourceGUID	NVARCHAR(36)	NOT NULL 
  , CONSTRAINT PK_stage_Animal 
		PRIMARY KEY CLUSTERED(
			[AnimalKey] ASC )
);
