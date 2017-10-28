CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_pregnancyExam]
AS
SELECT
    ID              =   preg.SourceGUID
  , DELETED_BY		=	ISNULL( preg.DeletedBy, -1 )
  , ANIMALID		=	a.SourceGUID 
  , PARITYNUMBER    =	pe.ParityNumber      
  , EVENTTYPEID		=	testResult.EventID
  , EVENTDATE		=	eDate.FullDate
  , QTY				=	CAST( -1 AS INT )
  , EVENTTHDATE		=	eDate.PICCycleAndDay
  , SOURCEFARMID	=   farms.SourceGUID
  , REMOVALREASONID =   CAST( -1 AS int ) 
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   testResult.animalStatus
  , PIGCHAMP_ID		=	preg.SourceID



FROM 
    fact.PregnancyExamEvent AS preg
INNER JOIN 
	fact.ParityEvent AS pe
	ON pe.ParityEventKey = preg.ParityEventKey
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pe.AnimalKey
INNER JOIN 
	stage.ParityEvent AS peStage
		ON peStage.ParityEventKey = pe.ParityEventKey
INNER JOIN( 
    SELECT  CAST( 1 AS bit), ID, CAST( 2 AS int ) 
    FROM    stage.CFT_EVENTTYPE
    WHERE   EVENTTYPE = N'Breed' AND EVENTNAME = N'Preg Test Positive'
    
    UNION 
    SELECT  CAST( 0 AS bit), ID, CAST( 1 AS int ) 
    FROM    stage.CFT_EVENTTYPE
    WHERE   EVENTTYPE = N'Breed' AND EVENTNAME = N'Preg Test Negative' ) 
    AS testResult( result, EventID, animalStatus ) 
        ON testResult.result = preg.IsPositive
INNER JOIN
	dimension.Date AS eDate
		ON eDate.DateKey = preg.EventDateKey 
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = preg.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id;		
		