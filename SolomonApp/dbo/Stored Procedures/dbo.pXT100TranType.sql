--*************************************************************
--	Purpose:List of Acceptable TranTypes by screen
--		based on PigSystem, includes phases
--	Author: Charity Anderson
--	Date: 2/22/2005
--	Usage: 
--	Parms: ScrnNbr 
--*************************************************************

CREATE PROC dbo.pXT100TranType
	(@parm1 as varchar(8),@parm2 as varchar(2))
AS
Select Distinct t.*,ts.* from cftPigTranType t WITH (NOLOCK)
JOIN cftPigAcctTran at WITH (NOLOCK) on t.TranTypeID=at.TranTypeID
JOIN cftPigAcct a WITH (NOLOCK) on at.acct=a.acct
JOIN cftPigAcctScrn s WITH (NOLOCK) on a.acct=s.acct
JOIN cftPigTranSys ts WITH (NOLOCK) on t.TranTypeID=ts.TranTypeID 

where s.ScrnNbr=@parm1 --and ts.PigSystemID like @parm2
Order by t.Description

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100TranType] TO [SOLOMON]
    AS [dbo];

