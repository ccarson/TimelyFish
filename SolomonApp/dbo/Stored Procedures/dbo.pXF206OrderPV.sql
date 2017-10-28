--*************************************************************
--	Purpose: Feed Order PV 
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Code
--*************************************************************

CREATE   PROCEDURE pXF206OrderPV
   	@parm1 varchar(6), @OrdNbr varchar(10)
 AS 
 SELECT *
	FROM cftFeedOrder 
	WHERE ContactID = @parm1
	AND Status='V'
--ISNULL(DateDel,'')<>''
	AND OrdNbr LIKE @OrdNbr
 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF206OrderPV] TO [MSDSL]
    AS [dbo];

