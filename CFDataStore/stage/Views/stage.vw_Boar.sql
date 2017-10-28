CREATE VIEW 
    stage.vw_Boar
AS
/*

	View:		stage.vw_Boar
	Author:		ccarson

	Absract:	Transform PigCHAMP data from caredata.HDR_BOAR to dimension.Animal

	Rev
	2017-03-27	ccarson		Original

*/
SELECT
    AnimalKey					=   ISNULL( a.AnimalKey, 0 ) 
  , Sex							=	N'M'
  , SourceID					=   b.identity_id
  , SourceGUID					=	b.SourceGUID
  , GeneticsKey					=   ISNULL( g.GeneticsKey, -1 )          
  , OriginKey					=   ISNULL( o.OriginKey, -1 ) 
  , DateOfBirth					=   b.date_of_birth
  , NewAnimalKey				=	b.ID
  , MobileFrameAnimalEventID	=	CAST( b.MFGUID AS nvarchar(36) )
  , SourceCode					=	CASE
										WHEN b.MFGUID IS NULL THEN N'PigCHAMP'
										ELSE N'MobileFrame / TIM'
									END
FROM 
    stage.HDR_BOARS AS b
LEFT OUTER JOIN
	dimension.Animal AS a 
		ON a.SourceID = b.identity_id
LEFT OUTER JOIN 
	dimension.Genetics AS g 
		ON g.SourceID = b.genetics_id
LEFT OUTER JOIN 
	dimension.Origin AS o 
		ON o.SourceID = b.origin_id ;