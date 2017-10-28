CREATE VIEW 
    stage.vw_Sow
AS
/*

	View:		stage.vw_Sow
	Author:		ccarson

	Absract:	Transform PigCHAMP data from caredata.HDR_SOW to dimension.Animal

	Rev
	2017-03-27	ccarson		Original

*/
SELECT
    AnimalKey					=   ISNULL( a.AnimalKey, 0 ) 
  , Sex							=	N'F' 
  , SourceID					=   s.identity_id
  , SourceGUID					=	s.SourceGUID
  , GeneticsKey					=   ISNULL( g.GeneticsKey, -1 )          
  , OriginKey					=   ISNULL( o.OriginKey, -1 ) 
  , DateOfBirth					=   s.date_of_birth
  , NewAnimalKey				=	s.ID
  , MobileFrameAnimalEventID	=	CAST( s.MFGUID AS nvarchar(36) )
  , SourceCode					=	CASE
										WHEN s.MFGUID IS NULL THEN N'PigCHAMP'
										ELSE N'MobileFrame / TIM'
									END
--  , IsDeleted					=	CASE 
--										WHEN ih.deletion_date IS NULL THEN 0 
--										ELSE 1 
--									END
FROM 
    stage.HDR_SOWS AS s 
LEFT OUTER JOIN
	dimension.Animal AS a 
		ON a.SourceID = s.identity_id
LEFT OUTER JOIN 
	dimension.Genetics AS g 
		ON g.SourceID = s.genetics_id
LEFT OUTER JOIN 
	dimension.Origin AS o 
		ON o.SourceID = s.origin_id ;
--LEFT OUTER JOIN 
--	stage.BH_DELETED_IDENTITY_HISTORY AS ih 
--		ON ih.identity_id = s.identity_id ;