
--*************************************************************
--	Purpose:Update cftPGInvTran records for Reversals
--	Author: Charity Anderson
--	Date: 2/2/2005
--	Usage: PigSaleEntry 
--	Parms: @parm1 (BatchNbr)
--	      
--*************************************************************

CREATE PROC dbo.pCF518InvTranXferRev
	@parm1 as varchar(6)

AS
Update cftPGInvTran set Reversal=1
from cftPGInvTran d
--JOIN cftPigSale t on t.BatNbr=d.BatNbr and t.RefNbr=d.SourceRefNbr
JOIN cftPigSale r on r.OrigRefNbr=d.SourceRefNbr
where 
r.BatNbr=@parm1 and 
r.DocType='RE' and d.Module='AR'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF518InvTranXferRev] TO [MSDSL]
    AS [dbo];

