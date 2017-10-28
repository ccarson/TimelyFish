    
--*************************************************************
--	Purpose: Find unallocated transactions not move out
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID)
--	20130312   added nolock hint     
--*************************************************************

/**
***************************************************************
	Updated for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
***************************************************************
**/

CREATE   PROC [dbo].[pXP001UnallocatedPGInvTrans_PG] @PigGroupID varchar(10) 

AS

DECLARE @lPigGroupID varchar(10) = @PigGroupID ;


SELECT 
    t.acct, t.BatNbr, t.CF01, t.CF02, t.CF03, t.CF04, t.CF05, t.CF06, t.CF07, t.CF08, t.CF09, t.CF10, t.CF11, t.CF12
        , t.Crtd_DateTime, t.Crtd_Prog, t.Crtd_User, t.IndWgt, t.InvEffect, t.LineNbr, t.LUpd_DateTime, t.LUpd_Prog
        , t.LUpd_User, t.Module, t.NoteID, t.PC_Stat, t.PerPost, t.PigGroupID, t.ProjChgBatch, t.ProjChgLine
        , Qty = t.Qty - ISNULL( ( SELECT Sum(Qty) FROM dbo.cftPGInvTranAlloc 
                                    WHERE  Module = t.Module AND BatNbr = t.BatNbr AND LineNbr = t.LineNbr ), 0 )
        , t.Reversal, t.Rlsed, t.SourceBatNbr, t.SourceLineNbr, t.SourcePigGroupID, t.SourceProg, t.SourceProject
        , t.SourceRefNbr, t.TotalWgt, t.TranDate, t.TranSubTypeID, t.TranTypeID
FROM 
    dbo.cftPGInvTran t
WHERE 
    t.PigGroupID = @PigGroupID
	    AND t.Reversal = 0 -- NOT a reversal
	    AND t.Rlsed = 1  -- IS released
	    AND t.TranTypeID IN( 'TI', 'MI', 'PP' )
	    AND t.TranDate <= ( SELECT Min( TranDate ) FROM cftPGInvTran 
                            WHERE PigGroupID = t.PigGroupID AND TranTypeID IN( 'TI', 'MI', 'PP' ) )+7
ORDER BY t.TranDate ;



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP001UnallocatedPGInvTrans_PG] TO [MSDSL]
    AS [dbo];

