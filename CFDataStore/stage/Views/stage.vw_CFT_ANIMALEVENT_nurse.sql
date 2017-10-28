CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_nurse]
AS
SELECT
    ID              =   nurse.SourceGUID
  , DELETED_BY		=	ISNULL( nurse.DeletedBy, -1 )
  , ANIMALID		=	a.SourceGUID 
  , PARITYNUMBER    =	pe.ParityNumber   
  , EVENTTYPEID		=	eType.ID
  , EVENTDATE		=	eDate.FullDate
  , QTY				=	CAST( nurse.NurseQuantity AS int )
  , EVENTTHDATE		=	eDate.PICCycleAndDay
  , SOURCEFARMID	=   farms.SourceGUID
  , REMOVALREASONID =   CAST( -1 AS int ) 
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 3 AS int )  -- Assume animal is LACTATING on Nurse
  , PIGCHAMP_ID		=	nurse.SourceID


FROM 
    fact.NurseEvent AS nurse
INNER JOIN 
	fact.ParityEvent AS pe
	ON pe.ParityEventKey = nurse.ParityEventKey
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pe.AnimalKey
INNER JOIN 
	stage.ParityEvent AS peStage
		ON peStage.ParityEventKey = pe.ParityEventKey
INNER JOIN
	stage.CFT_EVENTTYPE AS eType
		ON eType.EVENTNAME = N'NURSE ON'
INNER JOIN
	dimension.Date AS eDate
		ON eDate.DateKey = nurse.EventDateKey 
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = nurse.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id;

