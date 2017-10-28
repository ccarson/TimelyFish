CREATE VIEW 
    stage.vw_RetagEvent
AS
SELECT
	RetagEventKey		=	ISNULL( rt.RetagEventKey, 0 ) 
  , OldAnimalTagKey     =   ISNULL( old.AnimalTagKey, -1 )
  , NewAnimalTagKey		=	ISNULL( new.AnimalTagKey, -1 ) 
  , EventDateKey		=   CAST( CONVERT( varchar(08), ev.eventdate, 112 ) AS bigint ) 
  , SourceCode			=	N'PigCHAMP'
  , SourceID			=	ev.identity_id
  , SourceGUID			=	ev.SourceGUID

FROM 
    stage.EV_RETAG AS ev
LEFT OUTER JOIN 
	dimension.AnimalTag AS old 
		ON old.SourceID = ev.identity_id
			AND old.TagNumber = ev.old_primary_identity
LEFT OUTER JOIN 
	dimension.AnimalTag AS new
		ON new.SourceID = ev.identity_id
			AND new.TagNumber = ev.new_primary_identity
LEFT OUTER JOIN 
	fact.RetagEvent AS rt
		ON rt.SourceID = ev.event_id
;