--*************************************************************
--	Purpose: Feed Order PV Override 
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Code
--*************************************************************

CREATE   PROCEDURE pXF207OrderPV
   	@parm1 varchar(6), @OrdNbr varchar(10)
 AS 
 SELECT *
	FROM cftFeedOrder 
	WHERE DateDel='19000101'
	AND ContactID=@parm1
	AND OrdNbr LIKE @OrdNbr
 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207OrderPV] TO [MSDSL]
    AS [dbo];

