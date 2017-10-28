
/****** Object:  Stored Procedure dbo.pXP135TranPjChrg    Script Date: 2/28/2006 6:54:12 AM ******/



--*************************************************************
--	Purpose:InvTran Lookup		
--	Author: Sue Matter
--	Date: 12/29/2005
--	Usage: BatchRelease 
--	Parms: (SourceBatNbr,SourceRefNbr,Acct
--	      
--*************************************************************

CREATE   PROCEDURE pXP135TranPjChrg
	@parm1 as varchar(10),
	@parm2 as varchar(10)
	--@parm3 as varchar(16)
	
AS
Select * from cftPGInvTran
WHERE SourceBatNbr=@parm1
and SourceRefNbr=@parm2 
AND PC_Stat=0
AND ISNULL(ProjChgBatch,'')=''
--and Acct=@parm3







