CREATE TABLE 
	stage.BH_DELETED_EVENTS(
	    event_id			INT             NOT NULL
	  , site_id				INT             NOT NULL
	  , identity_id			INT             NOT NULL
	  , event_type			SMALLINT        NOT NULL
	  , eventdate			DATETIME        NULL
	  , supervisor_id		INT             NULL
	  , location_id			INT             NULL
	  , deletion_date		DATETIME        NULL
	  , deleted_by			VARCHAR(15)		NULL
	  , CONSTRAINT PK_BH_DELETED_EVENTS 
			PRIMARY KEY CLUSTERED ( event_id ASC ) WITH (FILLFACTOR = 100) )
;
GO
