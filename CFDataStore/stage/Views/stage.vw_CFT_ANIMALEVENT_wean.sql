CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_wean]
AS
SELECT
    ID              =   wean.SourceGUID
  , DELETED_BY		=	ISNULL( wean.DeletedBy, -1 ) 
  , ANIMALID		=	a.SourceGUID 
  , PARITYNUMBER    =	pe.ParityNumber   
  , EVENTTYPEID		=	CAST( eType.MobileFrameValue AS nvarchar(36) )
  , EVENTDATE		=	eDate.FullDate
  , QTY				=	CAST( wean.WeanedQuantity AS int )
  , EVENTTHDATE		=	eDate.PICCycleAndDay
  , SOURCEFARMID	=   farms.SourceGUID
  , REMOVALREASONID =   CAST( -1 AS int ) 
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 1 AS int )  -- Assume animal is OPEN on wean
  , PIGCHAMP_ID		=	wean.SourceID

FROM 
    fact.WeanEvent AS wean
INNER JOIN 
	fact.ParityEvent AS pe
	ON pe.ParityEventKey = wean.ParityEventKey
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pe.AnimalKey
INNER JOIN
	dbo.LookupCodes AS eType
		ON eType.LookupCodesKey = wean.WeanEventTypeKey
INNER JOIN
	dimension.Date AS eDate
		ON eDate.DateKey = wean.EventDateKey 
INNER JOIN 
	stage.ParityEvent AS peStage
		ON peStage.ParityEventKey = pe.ParityEventKey 
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = wean.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id		;