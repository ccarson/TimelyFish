CREATE TABLE
	stage.EV_ABORTIONS(
		event_id		INT					NOT NULL,
		identity_id		INT					NOT NULL,
		site_id			INT					NOT NULL,
		eventdate		DATETIME			NULL,
		induced			BIT					NOT NULL,
		[MFGUID]		VARCHAR (36)		NULL,
		SequentialGUID	UNIQUEIDENTIFIER	NOT NULL	DEFAULT newsequentialid(), 
		SourceGUID		AS					CONVERT( nvarchar(36), COALESCE( [MFGUID], SequentialGUID) ) PERSISTED,
		CONSTRAINT PK_EV_ABORTIONS 
			PRIMARY KEY CLUSTERED( identity_id ASC, event_id ASC ) ) 
;

GO
CREATE UNIQUE NONCLUSTERED INDEX IX_EV_ABORTIONS_01
    ON stage.EV_ABORTIONS(
		SourceGUID ASC ) 
;

