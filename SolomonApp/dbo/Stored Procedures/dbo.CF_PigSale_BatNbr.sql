--*************************************************************
--	Purpose:PigSales by Batch
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: BatNbr
--*************************************************************

CREATE PROC dbo.CF_PigSale_BatNbr
	(@parm1 as varchar(10))
AS
Select * from cftPigSale where BatNbr like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_PigSale_BatNbr] TO [MSDSL]
    AS [dbo];

