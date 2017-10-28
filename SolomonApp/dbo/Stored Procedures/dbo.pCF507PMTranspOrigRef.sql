--*************************************************************
--	Purpose:PV for Original Ref
--	Author: Charity Anderson
--	Date: 11/23/2004
--	Usage: PigTransportRecord app 
--	Parms:RefNbr
--*************************************************************

CREATE PROC dbo.pCF507PMTranspOrigRef
	@parm1 as varchar(10)
AS
Select * From cftPMTranspRecord 
WHERE  RefNbr like @parm1 
and RefNbr not in 
(Select Distinct OrigRefNbr from cftPMTranspRecord) 
and DocType<>'RE'
ORDER BY RefNbr

 