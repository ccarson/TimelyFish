CREATE PROC pXF185FOHdr
	--*************************************************************
	--	Purpose:Look up Feed Order Header records
	--	Author: Charity ANDerson
	--	Date: 9/30/2004
	--	Usage: Feed Delivery app 
	--	Parms:BatchNbr, RefNbr
	--*************************************************************
	@parm1 as varchar(10),
	@parm2 as varchar(10)
	AS
	SELECT * 
	FROM cftFOHdr 
	WHERE BatNbr = @parm1 
	AND RefNbr LIKE @parm2 
	ORDER BY BatNbr,RefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185FOHdr] TO [MSDSL]
    AS [dbo];

