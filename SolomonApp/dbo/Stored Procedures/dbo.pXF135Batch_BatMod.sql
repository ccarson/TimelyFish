--*************************************************************
--	Purpose:Retrieve GL Batch for Transport Charge 
--	Author: Charity Anderson
--	Date: 8/5/2005
--	Usage: Pig Transport Batch Release 
--	Parms: BatNbr, Module
--*************************************************************

CREATE PROCEDURE pXF135Batch_BatMod 
	@parm1 varchar (10), 
	@parm2 varchar (2) 
	as 
	SELECT * FROM Batch 
	WHERE BatNbr = @parm1 
	AND Module = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135Batch_BatMod] TO [MSDSL]
    AS [dbo];

