CREATE TABLE 
	stage.BH_EVENTS(
	    event_id			INT             NOT NULL
	  , site_id				INT             NOT NULL
	  , identity_id			INT             NOT NULL
	  , event_type			SMALLINT        NOT NULL
	  , eventdate			DATETIME        NULL
	  , supervisor_id		INT             NULL
	  , location_id			INT             NULL
	  , deletion_date		DATETIME        NULL
	  , deleted_by			VARCHAR(15)		NULL
	  , CONSTRAINT PK_BH_EVENTS 
			PRIMARY KEY CLUSTERED ( event_id ASC ) WITH (FILLFACTOR = 100) )
;
GO

CREATE NONCLUSTERED INDEX IX_BH_EVENTS_event_type
	ON stage.BH_EVENTS( 
		event_type  ASC, event_id ASC  )
	INCLUDE( site_id, identity_id, eventdate )
;
GO
