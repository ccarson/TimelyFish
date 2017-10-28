--*************************************************************
--	Purpose:PV for Original Ref
--	Author: Charity Anderson
--	Date: 11/23/2004
--	Usage: PigTransportRecord app 
--	Parms:RefNbr
--*************************************************************

CREATE PROC dbo.pXP135PMTranspOrigRef
	@parm1 as varchar(10)
AS
Select pm.* From cftPMTranspRecord pm
LEFT JOIN cftPMTranspRecord rev on pm.RefNbr=rev.OrigRefNbr
WHERE  pm.RefNbr like @parm1 
and rev.RefNbr is null
and pm.DocType<>'RE'
ORDER BY pm.RefNbr

 