

--*************************************************************
--	Purpose: DBNav for Batch Pig Sale Entry
--		
--	 Author: Nick Honetschlager
--	   Date: 5/16/2014
--	  Usage: Batch Pig Sale Entry (XP.518.50)	 
--	  Parms: @PigSaleID
--*************************************************************
/* 
===========================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
05/31/2017	nhonetschlager	   Use SummaryFileName instead of tattoo to filter grid
===========================================================================================
*/
CREATE PROCEDURE [dbo].[pXP51850cftPigSaleBatch] @SummaryFileName varchar(30) As

SELECT *
FROM cftPigSaleBatch
WHERE SummaryFileName LIKE @SummaryFileName											-- 05/31/17 NJH
AND Processed <> 1



