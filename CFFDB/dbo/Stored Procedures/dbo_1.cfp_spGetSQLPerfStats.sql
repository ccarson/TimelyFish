
 
 

CREATE PROC [dbo].[cfp_spGetSQLPerfStats] 
AS 
SET NOCOUNT ON 

CREATE TABLE #tFileList 
( 
databaseName sysname, 
logSize decimal(18,5), 
logUsed decimal(18,5), 
status INT 
) 

INSERT INTO #tFileList 
       EXEC cfp_spSQLPerf 

INSERT INTO cft_logSpaceStats (databaseName, logSize, logUsed) 
SELECT databasename, logSize, logUsed 
FROM #tFileList 

DROP TABLE #tFileList