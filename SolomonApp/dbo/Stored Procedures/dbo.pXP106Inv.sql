--*************************************************************
--	Purpose: Find the group capacity and inventory
--	Author: Sue Matter
--	Date: 12/1/2005
--	Usage: Pig Inventory Validation
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE   Procedure pXP106Inv
		@parm1 As varchar(6), @parm2 As varchar(6), @parm3 As DateTime

as
Select pg.PigGroupID, pg.PigProdPhaseID, bn.StdCap, bn.CapMultiplier, Sum(tr.Qty*tr.InvEffect)
	FROM cftPigGroup pg
	JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
	JOIN cftBarn bn ON pg.SiteContactID=bn.ContactID AND pg.BarnNbr=bn.BarnNbr
	WHERE pg.SiteContactID = @parm1 AND pg.BarnNbr= @parm2 AND tr.Reversal<>'1' AND tr.TranDate < = @parm3
--	AND pg.PGStatusID IN ('A', 'T') 
	AND pg.PGStatusID <> 'X'
        Group by pg.PigGroupID, pg.PigProdPhaseID, bn.StdCap, bn.CapMultiplier



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP106Inv] TO [MSDSL]
    AS [dbo];

