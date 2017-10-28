
--*************************************************************
--	Purpose:Reverse project charges
--	Author: Sue Matter
--	Date: 12/26/2005
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	      
--*************************************************************

CREATE  PROC dbo.pXP135PjXferRev
	@parm1 as varchar(6), @parm2 as Integer

AS
Select t.*
from cftPMTranspRecord t 
JOIN cftPGInvTran d ON  d.BatNbr = t.BatchNbr and d.SourceRefNbr=t.RefNbr 
where t.BatchNbr=@parm1 and d.LineNbr=@parm2
AND t.DocType='RE' and d.Module='XP' and d.Crtd_User<>'IMPORT'

 

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PjXferRev] TO [MSDSL]
    AS [dbo];

