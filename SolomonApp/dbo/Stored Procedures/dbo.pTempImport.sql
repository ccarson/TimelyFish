
/****** Object:  Stored Procedure dbo.pTempImport    Script Date: 2/17/2006 4:19:20 PM ******/

/****** Object:  Stored Procedure dbo.pTempImport    Script Date: 2/17/2006 3:38:49 PM ******/



CREATE  PROC pTempImport
	
AS
Select tr.* 
from cftPGInvTran tr
JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
WHERE tr.Reversal<>1 AND tr.PC_Stat=0 
AND tr.acct IN ('PIG TRANSFER IN', 'PIG TRANSFER OUT') 
AND pg.PGStatusID IN ('A','T') 
AND pg.PigProdPhaseID='NUR'
Order by tr.trandate, tr.SourceBatNbr, tr.SourceLineNbr, tr.SourceRefNbr


 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pTempImport] TO [MSDSL]
    AS [dbo];

