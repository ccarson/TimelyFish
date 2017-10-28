CREATE PROCEDURE Dbo.SPFixMissingPigProdPods001
@PigGroupID varchar(8)
as
--Created on 01/24/2007 by Dave Killion
--This SP returns the group type the destination pig
--group is associated to. This SP is used by the application 
--FixPigProdPod.
/**
***************************************************************
	Created for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
***************************************************************
**/

Select 
	ProdType 
from 
	cftPigProdPhase 
where 
	PigProdPhaseID in(Select Distinct ts.DestProdPhaseID from 
		cftPigTranType t WITH (NOLOCK)
		JOIN cftPigAcctTran at WITH (NOLOCK) on t.TranTypeID=at.TranTypeID
		JOIN cftPigAcct a WITH (NOLOCK) on at.acct=a.acct
		JOIN cftPigAcctScrn s WITH (NOLOCK) on a.acct=s.acct
		JOIN cftPigTranSys ts WITH (NOLOCK) on t.TranTypeID=ts.TranTypeID 
		where 
			s.ScrnNbr='XT10000' 
			and 
			ts.trantypeid in (Select transubtypeid from cftpm where cftpm.destpiggroupid = @PigGroupID))

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SPFixMissingPigProdPods001] TO [MSDSL]
    AS [dbo];

