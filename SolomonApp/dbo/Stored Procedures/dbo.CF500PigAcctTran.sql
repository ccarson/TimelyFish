--*************************************************************
--	Purpose:DBNav for PigAcctTransactions
--		
--	Author: Charity Anderson
--	Date: 2/23/2005
--	Usage: 
--	Parms: acct,TranTypeID
--*************************************************************

CREATE PROC dbo.CF500PigAcctTran
	(@parm1 as varchar(16),@parm2 as varchar(2))
AS
Select * from cftPigAcctTran at 
JOIN cftPigTranType t on at.TranTypeID=t.TranTypeID
where at.acct=@parm1 and t.trantypeid like @parm2
