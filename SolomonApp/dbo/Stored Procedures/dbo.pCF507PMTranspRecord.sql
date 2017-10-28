--*************************************************************
--	Purpose:Pig Movement Transport Records
--	Author: Charity Anderson
--	Date: 8/6/2004
--	Usage: PigTransportRecord app 
--	Parms:BatchNbr, RefNbr
--*************************************************************

CREATE PROC dbo.pCF507PMTranspRecord
	@parm1 as varchar(10),
	@parm2 as varchar(10)
AS
Select * From cftPMTranspRecord WHERE BatchNbr = @parm1 and RefNbr like @parm2 ORDER BY BatchNbr,RefNbr

 