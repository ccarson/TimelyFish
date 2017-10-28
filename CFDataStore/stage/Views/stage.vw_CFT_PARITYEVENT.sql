CREATE VIEW 
    [stage].[vw_CFT_PARITYEVENT]
AS
SELECT
    ID			=   pe.SourceGUID 
  , ANIMALID	=	a.SourceGUID 
  , PARITYNBR	=	pe.ParityNumber 
  , PARITYDATE	=	peDate.FullDate 
  , ENDDATE		=	pEndDate.FullDate 
  , GROUPID		=	CAST( NULL AS nvarchar(36) )
  , DELETED_BY	=	ISNULL( pe.DeletedBy, -1 )
  , MFSYNC      =	N'Y'

FROM 
    fact.ParityEvent AS pe

INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pe.AnimalKey
INNER JOIN 
	dimension.Date AS peDate
		ON peDate.DateKey = pe.ParityDateKey
LEFT OUTER JOIN 
	fact.ParityEvent AS pEnd
		ON pEnd.AnimalKey = pe.AnimalKey
			AND pEnd.ParityNumber = pe.ParityNumber + 1
			AND pEnd.DeletedDate IS NULL
LEFT OUTER JOIN
	dimension.Date AS pEndDate
		ON pEndDate.DateKey = pEnd.ParityDateKey
INNER JOIN 
	stage.ParityEvent AS peStage
		ON peStage.ParityEventKey = pe.ParityEventKey ; 
