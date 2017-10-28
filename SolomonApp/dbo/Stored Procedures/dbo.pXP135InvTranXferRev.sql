
--*************************************************************
--	Purpose:Update cftPGInvTran records for Reversals
--	Author: Charity Anderson
--	Date: 1/25/2005
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	      
--*************************************************************

CREATE PROC dbo.pXP135InvTranXferRev
	@parm1 as varchar(6)

AS
Update cftPGInvTran set Reversal=1
from cftPGInvTran d
JOIN cftPMTranspRecord t on t.BatchNbr=d.BatNbr and t.RefNbr=d.SourceRefNbr
JOIN cftPMTranspRecord r on r.OrigRefNbr=t.RefNbr
where 
r.BatchNbr=@parm1 and 
r.DocType='RE' and d.Module='XP' and d.Crtd_User<>'IMPORT'


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135InvTranXferRev] TO [MSDSL]
    AS [dbo];

