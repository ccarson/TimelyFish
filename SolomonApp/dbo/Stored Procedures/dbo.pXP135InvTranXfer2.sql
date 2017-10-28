

--*************************************************************
--	Purpose:Retreive Transports
--	Author: Sue Matter
--	Date: 2/27/2006
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	      
--*************************************************************
CREATE PROC dbo.pXP135InvTranXfer2
	@parm1 as varchar(6)

AS
Select * 
From cftPMTranspRecord
Where BatchNbr=@parm1

SET QUOTED_IDENTIFIER OFF 
