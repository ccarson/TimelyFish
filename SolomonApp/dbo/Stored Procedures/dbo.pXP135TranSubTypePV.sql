
--*************************************************************
--	Purpose:PV Transfer Sub Types relevant to XP135 screen		
--	Author: Charity Anderson
--	Date: 9/8/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (SubTypeID)
--	      
--*************************************************************

CREATE PROC dbo.pXP135TranSubTypePV
	@parm1 as varchar(2)
	

AS


Select Distinct t.TranTypeID as SubTypeID, t.Description,ts.SrcProdPhaseID,
	ts.DestProdPhaseID 
 from cftPigTranType t WITH (NOLOCK)  
JOIN cftPigAcctTran at WITH (NOLOCK) on t.TranTypeID=at.TranTypeID
JOIN cftPigAcct a WITH (NOLOCK) on at.acct=a.acct
JOIN cftPigAcctScrn s WITH (NOLOCK) on a.acct=s.acct
JOIN cftPigTranSys ts on t.TranTypeID=ts.TranTypeID
where s.ScrnNbr='XP13500' and t.TranTypeID like @parm1
order by SubTypeID
