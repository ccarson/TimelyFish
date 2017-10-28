--*************************************************************
--	Purpose: cftBinCert Initialization
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Feed Order Delivery		 
--	Parms:  
--*************************************************************

CREATE    PROCEDURE pXF185BinInit

 AS 
 SELECT *
	FROM cftBinCert
	Where FeedOrdNbr=''

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185BinInit] TO [MSDSL]
    AS [dbo];

