
CREATE FUNCTION 
    dbo.tvf_GetLookupCodesFromPigChamp( 
        @pLookupType			nvarchar(50) 
      , @pPigCHAMPValue			nvarchar(50) )

RETURNS TABLE 
AS

RETURN 

SELECT
	LookupCodesKey			
  , LookupCodesDescription  
  , PigChampValue			
  , MobileFrameValue		  
FROM
    dbo.LookupCodes AS codes
WHERE 
	codes.LookupType = @pLookupType
		AND codes.PigChampValue = @pPigCHAMPValue 
UNION 
SELECT 
	LookupCodesKey			
  , LookupCodesDescription  
  , PigChampValue			
  , MobileFrameValue		  
FROM
    dbo.LookupCodes AS codes
WHERE 
	codes.LookupType = @pLookupType
		AND codes.PigChampValue = N'****' 
		AND @pPigCHAMPValue NOT IN( SELECT PigChampValue FROM dbo.LookupCodes WHERE codes.LookupType = @pLookupType )
;

     