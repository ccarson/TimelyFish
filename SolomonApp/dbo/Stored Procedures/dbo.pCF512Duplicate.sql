--*************************************************************
--	Purpose:Check for duplicate transactions
--	Author: Sue Matter
--	Date: 8/25/2004
--	Usage: Pig Group Inventory Adjustment 
--	Parms: @parm1 (PigGroupID), @parm2 (transaction date)
--	       @parm3 (account), @parm4 (qty), @parm5 (batch number)
--*************************************************************
CREATE  Procedure pCF512Duplicate
	       @parm1 varchar(10),@parm2 smalldatetime, @parm3 varchar(16), @parm4 integer, @parm5 varchar(10)
as
	Select * From cftPGInvTran
	WHERE PigGroupID=@parm1 AND TranDate=@parm2 AND acct=@parm3 and Qty=@parm4 AND BatNbr<>@parm5



 