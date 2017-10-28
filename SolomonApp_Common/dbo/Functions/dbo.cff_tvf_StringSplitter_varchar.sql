
CREATE FUNCTION dbo.cff_tvf_StringSplitter_varchar( 
-- ===================================================================
-- Author:			Jeff Moden, SQLServerCentral.com
-- Adapted for CFF:	Chris Carson
-- Create date:		2016-05-01
-- Description:		Split a delimited string into a table variable.
-- Original:		http://www.sqlservercentral.com/articles/Tally+Table/72993/
-- ===================================================================
	@pString VARCHAR(8000)
  , @pDelimiter CHAR(1) )
RETURNS TABLE 
	WITH SCHEMABINDING AS

RETURN
	WITH 
		E1(N) AS(
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
			SELECT 1 ) ,									-- 10 	  ( 10^1 ) rows 
		E2(N) AS(
			SELECT 1 FROM E1 a, E1 b) , 					-- 100 	  ( 10^2 ) rows 
		E4(N) AS(
			SELECT 1 FROM E2 a, E2 b) , 					-- 10,000 ( 10^4 ) rows 
			
		cteTally(N) AS(										-- limits number of rows returned from E4
			SELECT TOP( ISNULL( DATALENGTH( @pString ), 0 ) ) 
				ROW_NUMBER() OVER ( ORDER BY ( SELECT NULL ) ) 
			FROM E4 ) , 

		cteStart(N1) AS(									-- Sets N+1, which is the starting position for each element in the delimted string 
			SELECT 1 UNION ALL
            SELECT 
				t.N+1 
			FROM 
				cteTally t 
			WHERE 
				SUBSTRING( @pString, t.N, 1 ) = @pDelimiter ) ,

		cteLen(N1,L1) AS(									-- Returns start and length for each element in the delimited string 
			SELECT 
				s.N1
			  , ISNULL( NULLIF ( CHARINDEX( @pDelimiter, @pString, s.N1 ), 0 ) - s.N1, 8000 )
			FROM 
				cteStart s ) 
--	executes the split.  ISNULL/NULLIF combo is for the final element when the delimiter is not there
	SELECT 
		ItemNumber = ROW_NUMBER() OVER( ORDER BY l.N1 )
	  , Item       = SUBSTRING( @pString, l.N1, l.L1 )
	FROM 
		cteLen l ;
		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cff_tvf_StringSplitter_varchar] TO [MSDSL]
    AS [dbo];

