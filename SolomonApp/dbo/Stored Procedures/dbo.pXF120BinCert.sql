----------------------------------------------------------------------------------------
-- 	Purpose: Look up Bin Certification Records
--	Author: Sue Matter
--	Date: 5/8/2006
--	Program Usage: XF120
--	Parms: FeedOrder Number
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120BinCert
	@FeedOrder as varchar(10)
	AS
	SELECT *
	From cftBinCert 
	Where RlsedContactID='' AND FeedOrdNbr = @FeedOrder

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120BinCert] TO [MSDSL]
    AS [dbo];

