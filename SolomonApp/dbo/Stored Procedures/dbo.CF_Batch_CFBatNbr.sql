--*************************************************************
--	Purpose:PigSales by Batch
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: BatNbr
--*************************************************************
CREATE PROC dbo.CF_Batch_CFBatNbr
	(@parm1 as varchar(10))
AS
Select * from Batch where BatNbr like @parm1 and EditScrnNbr ='CF518'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_Batch_CFBatNbr] TO [MSDSL]
    AS [dbo];

