
CREATE PROCEDURE 
	dbo.cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_SELECT_VETS_new( 
		@StartDate 		datetime
	  , @EndDate 		datetime
	  , @SourceState	varchar(8000) = NULL
	  , @DestState 		varchar(8000) = NULL )
AS

SET NOCOUNT, XACT_ABORT ON ; 

DECLARE 
	@SelectSQL 			varchar(8000)
  , @SourceStateJoin 	varchar(1000)
  , @DestStateJoin 		varchar(1000)
  , @OrderBy 			varchar(1000) ;
  
CREATE TABLE 
	#VetContacts( 
		VetContactID	CHAR(06) 
	  , VetName 		CHAR(50) 
	  , SState			CHAR(03) 
	  , DState			CHAR(03) ) ; 
  
IF 1 = 0
	SELECT VetContactID, VetName FROM #VetContacts ;

SELECT 	Item = CAST( Item AS CHAR(03) ) 
INTO	#SourceStates
FROM 	dbo.cftvf_StringSplitter( @SourceState, ',' ) ;


SELECT 	Item = CAST( Item AS CHAR(03) ) 
INTO	#DestStates
FROM 	dbo.cftvf_StringSplitter( @DestState, ',' ) ;

INSERT INTO 
	#VetContacts 
SELECT 
	v.VetContactID
  , v.VetName 
  , v.SState
  , v.DState
FROM 
	dbo.cfv_REPORT_INTERSTATE_PIG_MOVEMENTS_new AS v 
WHERE 
	v.MovementDate BETWEEN @StartDate AND @EndDate ;
	
IF EXISTS( SELECT 1 FROM #SourceStates )
	DELETE 	#VetContacts
	WHERE	SState NOT IN ( SELECT Item FROM #SourceStates ) ;
	
IF EXISTS( SELECT 1 FROM #DestStates )
	DELETE 	#VetContacts
	WHERE	DState NOT IN ( SELECT Item FROM #DestStates ) ;

SELECT DISTINCT VetContactID, VetName FROM #VetContacts ;


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_SELECT_VETS_new] TO [MSDSL]
    AS [dbo];

