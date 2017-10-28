--*************************************************************
--	Purpose:PV for RefNbr Document Level			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (BatchNbr)
--	       @parm2 (RefNbr)
--*************************************************************
Create Procedure pCF507_BatNbr_RefNbr 
	@parm1 varchar (10),
	@parm2 varchar (10)
As
Select * From cfvPigTransportDocs Where BatchNbr=@parm1 and RefNbr like @parm2 Order By BatchNbr, RefNbr 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF507_BatNbr_RefNbr] TO [MSDSL]
    AS [dbo];

