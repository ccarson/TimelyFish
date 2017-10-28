--*************************************************************
--	Purpose: Bin Certification Records
--	Author: Sue Matter
--	Date: 4/26/2006
--	Usage: Feed Delivery app 
--	Parms: Feed Order Number
--*************************************************************
CREATE PROCEDURE pXF185BinCertification 
	@parm1 varchar (10) 
	as 
	SELECT cf.* 
	FROM cftBinCert cf
	JOIN cftFeedOrder fo ON cf.FeedOrdNbr=fo.OrdNbr AND fo.Status='V'
	JOIN cftFOList fl ON fo.OrdNbr=fl.OrdNbr AND fl.BatNbr=@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185BinCertification] TO [MSDSL]
    AS [dbo];

