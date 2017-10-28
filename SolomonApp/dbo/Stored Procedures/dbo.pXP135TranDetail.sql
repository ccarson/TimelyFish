
--*************************************************************
--	Purpose: Batch Release Lookup
--	Author: Sue Matter
--	Date: 12/22/2005
--	Usage: PigTransportRecord app 
--	Parms:BatchNbr, RefNbr, Line, Account
--*************************************************************
CREATE   PROCEDURE pXP135TranDetail
	@parm1 as varchar(10),
	@parm2 as varchar(10)


AS
Select * From cftPMTranspRecord 
WHERE BatchNbr = @parm1 and RefNbr=@parm2
ORDER BY BatchNbr,RefNbr

 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135TranDetail] TO [MSDSL]
    AS [dbo];

