--*************************************************************
--	Purpose:List of Acceptable TranTypes by screen
--		based on PigSystem, includes phases
--	Author: Charity Anderson
--	Date: 2/22/2005
--	Usage: 
--	Parms: ScrnNbr 
--*************************************************************

CREATE PROC dbo.pCF100TranType
	(@parm1 as varchar(8),@parm2 as varchar(2))
AS
Select Distinct t.*,ts.* from cftPigTranType t 
JOIN cftPigAcctTran at on t.TranTypeID=at.TranTypeID
JOIN cftPigAcct a on at.acct=a.acct
JOIN cftPigAcctScrn s on a.acct=s.acct
JOIN cftPigTranSys ts on t.TranTypeID=ts.TranTypeID 

where s.ScrnNbr=@parm1 and ts.PigSystemID like @parm2
Order by t.Description

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100TranType] TO [MSDSL]
    AS [dbo];

