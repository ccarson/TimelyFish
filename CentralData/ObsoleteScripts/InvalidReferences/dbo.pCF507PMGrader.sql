--*************************************************************
--	Purpose:DBNav for Grader Level			
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord 
--	Parms: BatchNbr, RefNbr, LineNbr min and max

--*************************************************************
Create Procedure pCF507PMGrader 
	@parm1 varchar (10),
	@parm2 varchar (10),
	@parm3 varchar (3)
As
Select * From cftPMGrader
Where BatchNbr=@parm1 and RefNbr=@parm2 and PMGraderTypeID like @parm3 Order By BatchNbr, RefNbr, PMGraderTypeID 

