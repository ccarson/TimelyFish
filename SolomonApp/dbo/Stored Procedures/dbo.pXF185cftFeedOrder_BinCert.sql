
--*************************************************************
--	Purpose: Check order status for Bin Certification Records
--	Author: Sue Matter
--	Date: 4/26/2006
--	Usage: Feed Delivery app 
--	Parms: Feed Order Number
--*************************************************************
CREATE  PROCEDURE pXF185cftFeedOrder_BinCert 
	@parm1 varchar (10) 
	as 
	SELECT * FROM cftFeedOrder 
	WHERE OrdNbr = @parm1 AND Status='V'

