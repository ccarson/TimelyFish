--*************************************************************
--	Purpose: Initialize cursor
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Feed Order Delivery		 
--	Parms:  
--*************************************************************

CREATE    PROCEDURE pXF185FeedOrderInit

 AS 
 SELECT *
	FROM cftFeedOrder 
	Where OrdNbr=''

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185FeedOrderInit] TO [MSDSL]
    AS [dbo];

