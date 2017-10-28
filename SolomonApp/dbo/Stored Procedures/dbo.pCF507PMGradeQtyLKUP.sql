--*************************************************************
--	Purpose:Reversal Lookup for GradeQty Level			
--	Author: Charity Anderson
--	Date: 9/7/2004
--	Usage: PigTransportRecord 
--	Parms: BatchNbr, RefNbr, LineNbrMin, LineNbrMax

--*************************************************************
Create Procedure pCF507PMGradeQtyLKUP 
	@parm1 varchar (10),
	@parm2 varchar (10),
	@parm3min smallint,
	@parm3max smallint
As
Select *
From cftPMGradeQty 
Where BatchNbr=@parm1 and RefNbr=@parm2 and LineNbr between @parm3min and @parm3max Order By BatchNbr, RefNbr 

