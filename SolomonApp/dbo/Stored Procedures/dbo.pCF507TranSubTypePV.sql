
--*************************************************************
--	Purpose:PV Transfer Sub Types relevant to CF507 screen		
--	Author: Charity Anderson
--	Date: 9/8/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (SubTypeID)
--	      
--*************************************************************

CREATE PROC dbo.pCF507TranSubTypePV
	@parm1 as varchar(2)
	

AS
Select Distinct s.SubTypeID, s.Description,s.SrcProdPhaseID,s.DestProdPhaseID from cftPGInvTSub s
JOIN cftPGTTypeScr t on t.TranTypeID=s.TranTypeID
WHERE t.ScreenNbr='CF50700' and s.SubTypeID like @parm1 
and SrcProdPhaseID is not null and DestProdPhaseID is not null
Order by SubTypeID

Select Distinct BatchNbr,RefNbr from cftPMTranspRecord where SubTypeID='DI'


 