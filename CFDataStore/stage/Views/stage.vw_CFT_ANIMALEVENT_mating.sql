
CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_mating]
AS
SELECT
    ID              =   me.SourceGUID
  , DELETED_BY		=	ISNULL( me.DeletedBy, -1 )
  , ANIMALID		=	a.SourceGUID
  , PARITYNUMBER	=	pEvent.ParityNumber 
  , EVENTTYPEID		=	eType.ID     
  , EVENTDATE		=	ed.FullDate
  , EVENTTHDATE		=	ed.PICCycleAndDay
  , MATINGHOUR		=	me.TimeOfDayCode
  , BREEDERID		=	o.SourceGUID
  , SEMENID			=	ISNULL( semen.SourceGUID, CAST( CONVERT( uniqueidentifier, 0x0 ) AS nvarchar(36) ) )
  , MATINGNBR		=	CAST( me.MatingNumber AS int )
  , BREEDINGNBR		=	CAST( me.BreedingNumber AS int )
  , SERVICENBR		=	CAST( me.ParityServiceNumber AS int )
  , SOURCEFARMID	=   farms.SourceGUID
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 2 AS int )  -- Assume animal is SERVED
  , PIGCHAMP_ID		=	me.SourceID
  , GROUPNAME        =    CAST(MatingGroup.MatingGroup AS nvarchar(4) )

  

FROM 
    fact.MatingEvent AS me
INNER JOIN 
	fact.ParityEvent AS pEvent 
		ON pEvent.ParityEventKey = me.ParityEventKey 
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pEvent.AnimalKey
LEFT JOIN 
	dimension.Genetics AS semen
		on semen.GeneticsKey= me.MaleGeneticsKey
INNER JOIN 
	dimension.Observer AS o 
		ON o.ObserverKey = me.ObserverKey
INNER JOIN
	dimension.Date AS ed
		ON ed.DateKey = me.EventDateKey
INNER JOIN 
	stage.MatingEvent AS stage
		ON stage.MatingEventKey = me.MatingEventKey
INNER JOIN
	stage.CFT_EVENTTYPE AS eType
		ON eType.EVENTNAME = N'Mating'
INNER JOIN
    dimension.MatingGroup as matingGroup
        ON matingGroup.MatingGroupKey = me.MatingGroupKey
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = me.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id;
;