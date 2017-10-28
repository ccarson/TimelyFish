CREATE TABLE 
	stage.ParityEvent(
		ParityEventKey	BIGINT			NOT NULL
	  , [AnimalKey]		BIGINT			NOT NULL
	  , MatingGroupKey	BIGINT			
	  , SourceGUID		NVARCHAR(36)	NOT NULL 
	  , CONSTRAINT PK_stage_ParityEvent 
			PRIMARY KEY CLUSTERED( ParityEventKey ASC )
);
