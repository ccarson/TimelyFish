--*************************************************************
--	Purpose: Exceptions by Batch Number
--	Author: Sue Matter
--	Date: 11/7/2006
--	Usage: Feed Delivery app 
--	Parms: Batch Number
--*************************************************************
CREATE  PROCEDURE pXF185WEMExceptions
	@parm1 varchar (10) 
	as 
	SELECT BatNbr 
	FROM cfvWEMLOADS
	Where BatNbr = @parm1

