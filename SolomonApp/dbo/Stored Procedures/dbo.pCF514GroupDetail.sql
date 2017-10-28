--*************************************************************
--	Purpose: Batch Release
--	Author: Sue Matter
--	Date: 8/19/2004
--	Usage: Batch Release
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE       Proc pCF514GroupDetail
          @parm1 varchar (16)
as
	
Select  pg.PigGroupID,
	bn.StdCap As VCapacity

  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  LEFT JOIN cftBarn bn ON pg.SiteContactID=bn.ContactID AND pg.BarnNbr=bn.BarnNbr
  Where (tr.acct='PIG TRANSFER IN' or tr.acct='PIG MOVE IN' or tr.acct='PIG PURCHASE') 
	AND tr.IndWgt>0 AND tr.TotalWgt>0 AND pg.PigGroupID=@parm1
  Group by pg.PigGroupID, bn.StdCap


 