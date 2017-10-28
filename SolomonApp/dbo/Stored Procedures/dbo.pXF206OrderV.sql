--*************************************************************
--	Purpose: Feed Order Insert 
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Feed Order
--*************************************************************

CREATE    PROCEDURE pXF206OrderV
   	 @OrdNbr varchar(10)
 AS 
 SELECT *
	FROM cftFeedOrder 
	WHERE Status='V'
	AND OrdNbr=@OrdNbr
 


