
--*************************************************************
--	Purpose:InvTran Lookup		
--	Author: Sue Matter
--	Date: 12/29/2005
--	Usage: BatchRelease 
--	Parms: (SourceBatNbr,SourceRefNbr,Acct
--	      
--*************************************************************

CREATE PROCEDURE pXP135TranRev
	@parm1 as varchar(10),
	@parm2 as varchar(10)
	--@parm3 as varchar(16)
	
AS
Select * from cftPGInvTran
WHERE SourceBatNbr=@parm1
and SourceRefNbr=@parm2 
--and Acct=@parm3




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135TranRev] TO [MSDSL]
    AS [dbo];

