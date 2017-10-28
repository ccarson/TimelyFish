--*************************************************************
--	Purpose:Get all transactions for a pig group by batch number
--	Author: Sue Matter
--	Date: 8/25/2004
--	Usage: Pig Group Inventory Adjustment 
--	Parms: @parm1 (Batch Number)
--	      
--*************************************************************

CREATE Proc pCF512cftPigInvTran_ALL
	       @parm1 varchar(10)
as
	Select * From cftPGInvTran
	WHERE BatNbr LIKE @parm1
	Order by BatNbr


 