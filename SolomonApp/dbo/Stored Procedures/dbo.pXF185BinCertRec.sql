--*************************************************************
--	Purpose: Bin Certification Records
--	Author: Sue Matter
--	Date: 4/26/2006
--	Usage: Feed Delivery app 
--	Parms: Feed Order Number
--*************************************************************
CREATE PROCEDURE pXF185BinCertRec 
	@parm1 varchar (10) 
	as 
	SELECT cf.* 
	FROM cftBinCert cf
	Where FeedOrdNbr=@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185BinCertRec] TO [MSDSL]
    AS [dbo];

