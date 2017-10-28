--*************************************************************
--	Purpose:List of Acceptable TranTypes for a specific
--		screen
--	Author: Charity Anderson
--	Date: 2/22/2005
--	Usage: 
--	Parms: ScrnNbr 
--*************************************************************

CREATE PROC dbo.pCFTranTypesbyScrnSystem
	(@parm1 as varchar(8),@parm2 as varchar(2))
AS
Select t.* from cftPigTranType t 
JOIN cftPigAcctTran at on t.TranTypeID=at.TranTypeID
JOIN cftPigAcct a on at.acct=a.acct
JOIN cftPigAcctScrn s on a.acct=s.acct
JOIN cftPigTranSys ts on t.TranTypeID=ts.TranTypeID 

where s.ScrnNbr=@parm1 and ts.PigSystemID like @parm2
