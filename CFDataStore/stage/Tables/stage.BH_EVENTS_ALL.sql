CREATE TABLE 
	stage.BH_EVENTS_ALL(
	    event_id			INT             NOT NULL
	  , site_id				INT             NOT NULL
	  , identity_id			INT             NOT NULL
	  , event_type			SMALLINT        NOT NULL
	  , eventdate			DATETIME        NULL
	  , deletion_date		DATETIME        NULL
	  , CONSTRAINT PK_BH_EVENTS_ALL 
			PRIMARY KEY CLUSTERED ( event_id ASC ) WITH (FILLFACTOR = 100) )
;
GO

CREATE NONCLUSTERED INDEX IX_BH_EVENTS_ALL
	ON stage.BH_EVENTS_ALL( 
		event_type  ASC, event_id ASC  )
	INCLUDE( site_id, identity_id, eventdate )
;
GO
