
--*************************************************************
--	Purpose: PigGroup with Calculated StartDate
--	Author: Charity Anderson
--	Date:  10/26/2004
--	Usage: View for finding group start date
--	Parms:
--*************************************************************
CREATE  View vCFPigGroupwStartDate
as
Select q.TranDate as ActualStartDate,pg.*,
	TotStartWgt=(Select SUm(TotalWgt) from cftPGInvTran 
		where Crtd_Prog='IMPORT' and InvEffect=1 and PigGroupID=pg.PigGroupID),
	TotStartQty=(Select SUm(Qty) from cftPGInvTran 
		where Crtd_Prog='IMPORT' and InvEffect=1 and PigGroupID=pg.PigGroupID),
	CurrentInventory=(Select Sum(qty*InvEffect) from cftPGInvTran where PigGroupID=pg.PigGroupID),
	c.ContactName as SiteName, b.BarnID as BarnID, b.StdCap
	 from cftPigGroup pg 
JOIN (Select Min(TranDate) as TranDate, PigGroupID from vCFPigGroupTranDateQty
	where qty>0 Group By PigGroupID) q on pg.PigGroupID=q.PigGroupID
JOIN cftBarn b on pg.BarnNbr=b.BarnNbr and cast(pg.SiteContactID as smallint)=b.ContactID
JOIN cftContact c on cast(pg.SiteContactID as smallint)=c.ContactID

 