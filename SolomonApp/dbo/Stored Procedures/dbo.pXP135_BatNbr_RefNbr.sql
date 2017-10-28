--*************************************************************
--	Purpose:PV for RefNbr Document Level			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	       @parm2 (RefNbr)
--*************************************************************
Create Procedure pXP135_BatNbr_RefNbr 
	@parm1 varchar (10),
	@parm2 varchar (10)
As
Select * From vXP135PigTransportDocs Where BatchNbr=@parm1 and RefNbr like @parm2 Order By BatchNbr, RefNbr 

