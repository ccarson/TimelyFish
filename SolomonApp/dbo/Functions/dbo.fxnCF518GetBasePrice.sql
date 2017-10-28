--*************************************************************
--	Purpose:Retrieve Base Price for a Sales Entry
--	Author: Charity Anderson
--	Date: 12/2/2004
--	Usage: Base Price Comparison Report	 
--	Parms: ContrNbr,KillDate
--*************************************************************

CREATE function dbo.fxnCF518GetBasePrice
	(@parm1 as varchar(10), @parm2 as smalldatetime)
	RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @BasePrice as DECIMAL(10,2)
Set @BasePrice=(Select BasePrice from cftPSContrBPHist where ContrNbr=@parm1 and BPDate=@parm2)
RETURN @BasePrice
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[fxnCF518GetBasePrice] TO [MSDSL]
    AS [dbo];

