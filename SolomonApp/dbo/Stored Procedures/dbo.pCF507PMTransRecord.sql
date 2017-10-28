
--*************************************************************
--	Purpose:DBNav for RefNbr Document Level			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)

--*************************************************************
Create Procedure pCF507PMTransRecord 
	@parm1 varchar (10),
	@parm2 varchar (10) 
As
Select * From cftPMTranspRecord Where BatchNbr=@parm1 and RefNbr like @parm2 Order By BatchNbr, RefNbr 


 