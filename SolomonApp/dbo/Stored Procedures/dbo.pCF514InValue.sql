
/****** Object:  Stored Procedure dbo.pCF514InValue    Script Date: 12/29/2004 11:36:54 AM ******/

CREATE     Proc pCF514InValue
          @parm1 varchar (32)
as
	
Select  pj.* 
FROM pjptdsum pj
JOIN cftPGChrgSetup su ON (pj.acct=su.TranInacct OR pj.acct=Purchacct)
Where pj.pjt_entity=@parm1


