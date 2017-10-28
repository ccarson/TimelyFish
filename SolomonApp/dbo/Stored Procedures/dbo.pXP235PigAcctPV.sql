--*************************************************************
--	Purpose:PV for PigAccts
--		
--	Author: Charity Anderson
--	Date: 2/23/2005
--	Usage: 
--	Parms: acct 
--*************************************************************

CREATE PROC dbo.pXP235PigAcctPV
	(@parm1 as varchar(16))
AS
Select * from cftPigAcct where acct like @parm1 order by acct
