--*************************************************************
--	Purpose:InvTran Lookup		
--	Author: Charity Anderson
--	Date: 9/13/2004
--	Usage: BatchRelease 
--	Parms: (SourceBatNbr,SourceRefNbr,SourceLineNbr,Acct
--	      
--*************************************************************

CREATE  PROC dbo.pXP135TranLKUP
	@parm1 as varchar(10),
	@parm2 as varchar(10),
	@parm3 as smallint,
	@parm4 as varchar(16)
	
AS
Select * from cftPGInvTran
WHERE SourceBatNbr=@parm1
and SourceRefNbr=@parm2 
and SourceLineNbr=@parm3 
and Acct=@parm4



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135TranLKUP] TO [MSDSL]
    AS [dbo];

