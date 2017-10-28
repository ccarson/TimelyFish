--*************************************************************
--	Purpose:Pig Movement Transport Records by Ref
--	Author: Charity Anderson
--	Date: 9/7/2004
--	Usage: PigTransportRecord app 
--	Parms:RefNbr
--*************************************************************

CREATE PROC dbo.pCF507PMTranspRef
	@parm1 as varchar(10)
AS
Select * From cftPMTranspRecord WHERE  RefNbr like @parm1 

ORDER BY RefNbr

 