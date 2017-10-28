
--*************************************************************
--	Purpose:Pig Movement Transport Records by Ref
--	Author: Charity Anderson
--	Date: 9/7/2004
--	Usage: PigTransportRecord app 
--	Parms:RefNbr
--*************************************************************

CREATE  PROCEDURE  pXP135PMTranspRef
	@parm1 as varchar(10)
AS
Select * From cftPMTranspRecord WHERE  RefNbr like @parm1 

ORDER BY RefNbr

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PMTranspRef] TO [MSDSL]
    AS [dbo];

