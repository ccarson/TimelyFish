
CREATE FUNCTION 
	dbo.cftvf_StringSplitter( 
		@pString AS NVARCHAR(MAX)
	  , @pDelimiter AS NCHAR(1) )

RETURNS TABLE
AS

RETURN
/*
***************************************************************************
Procedure:     	Utility.cftvf_StringSplitter
Implemented By: chris carson ( not the author, see ABSTRACT )
Date:          	2011-12-01
Purpose:       	splits a delimited string, wickedly fast


Update By    Update Date  Description
-----------  -----------  ----------------------------
Chris Carson 2016-09-01	  implemented function at CFF
****************************************************************************

Abstract:	create tally table
			create startingPosition table, using the delimiter to find the 
				starting position of each element in the input string
			using cteTally and cteStart, parse out input string 
				into component chunks

References:	http://www.sqlservercentral.com/articles/Tally+Table/72993/
			http://www.sqlservercentral.com/articles/T-SQL/74118/
			( fun ways to count quickly )
			
*/
WITH  
	E1(N) AS(
		SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
			SELECT 1 ) , 
	
	E2(N) AS(
		SELECT 1 FROM E1 AS A, E1 AS b ) , 

	E4(N) AS(
		SELECT 1 FROM E2 AS A, E2 AS b ) , 

	E8(N) AS(
		SELECT 1 FROM E4 AS A, E4 AS b ) ,
		
	En(N) AS(
		SELECT TOP( DATALENGTH( ISNULL( @pString, 1 ) ) ) 1 FROM E8 ) ,  

	--	despite appearance, cteTally does not contain 100,000,000 rows	
	--	En controls the number of records in cteTally
	--		because of the way CTEs are built, only the required number
	--		of records are instantiated.
	--		Example:	LEN(@pString) = 50 so only E1 and E2 are instantiated
	--					LEN(@pString) = 1,545.236  E8 is instantiated, but is
	--						limited to only the number of records required.

	cteTally(N) AS(
		SELECT  0 
			UNION  ALL
		SELECT  ROW_NUMBER() OVER ( ORDER BY ( SELECT NULL ) ) FROM En ) , 

    cteStart(N1) AS ( 
		SELECT  
			t.N + 1 
		FROM  
			cteTally AS t
		WHERE  
			SUBSTRING( @pString, t.N, 1 ) = @pDelimiter OR t.N = 0 ) 
					   
SELECT	
	ItemNumber	= ROW_NUMBER() OVER( ORDER BY s.N1 )
  , Item		= SUBSTRING( @pString, s.N1, ISNULL( NULLIF( CHARINDEX( @pDelimiter, @pString, s.N1 ), 0 ) - s.N1, DATALENGTH( ISNULL( @pString, 1 ) ) ) )
FROM  
	cteStart AS s ;

