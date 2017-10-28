CREATE TABLE 
	stage.ArrivalEvent(
		ArrivalEventKey		BIGINT	NOT NULL
	  , FarmAnimalKey		BIGINT	NOT NULL 		
      , SourceGUID			NVARCHAR (36) NOT NULL
	  , CONSTRAINT PK_stage_ArrivalEvent 
			PRIMARY KEY CLUSTERED( ArrivalEventKey ASC )
);

