--*************************************************************
--	Purpose:List of Acceptable TranTypes for a specific
--		screen
--	Author: Charity Anderson
--	Date: 2/22/2005
--	Usage: 
--	Parms: ScrnNbr 
--*************************************************************

CREATE PROC dbo.pCFTranTypesbyScrn
	(@parm1 as varchar(8))
AS
Select t.* from cftPigTranType t WITH (NOLOCK)  
JOIN cftPigAcctTran at WITH (NOLOCK) on t.TranTypeID=at.TranTypeID
JOIN cftPigAcct a WITH (NOLOCK) on at.acct=a.acct
JOIN cftPigAcctScrn s WITH (NOLOCK) on a.acct=s.acct
where s.ScrnNbr=@parm1
