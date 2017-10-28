

CREATE VIEW 
    [dbo].[cfv_GroupStart]
/*
***********************************************************************************************************************************
    Purpose: Current Pig Group Inventory Details
    Author: Sue Matter
    Date: 5/1/2005
    Usage: CF663 Active Site Report
    Parms: @parm1 (Pig Group ID)

    Modified: 2005-06-24    TJones 
                                changed Wgt column to be average wgt and added PigGroupID column
    Modified: 2016-12-08    ccarson, jmaas 
                                included inventory adjustments in group start calculation 
                                many group have inventory adjustments after initial inbound transaction 
                                    these transactions should be included in intial starting position
           
    Notes:

    Starting calculation includes:
        transfers in
        pig purchases

    Starting calculation *can* also include: 
        Moves In
        Moves Out
        Inventory Adjustments

        These transactions will be included if they occur within seven days of initial transfer in or pig purchase 
        
***********************************************************************************************************************************
*/
AS 

SELECT 
    PigGroupID      =   pg.PigGroupID
  , ProjectID       =   pg.ProjectID
  , TaskID          =   pg.TaskID
  , StartDate       =   MIN( tr.TranDate ) 
  , Qty             =   SUM( tr.Qty * tr.inveffect )
  , Wgt             =   ROUND( SUM( tr.TotalWgt * tr.inveffect ) / SUM( tr.Qty * tr.inveffect ), 2 )
  , TWgt            =   SUM( tr.TotalWgt * tr.inveffect )
 FROM 
    dbo.cftPigGroup AS pg 
 INNER JOIN 
    dbo.cftPGInvTran AS tr 
        ON pg.PigGroupID = tr.PigGroupID AND tr.Reversal <> '1' 
 WHERE 
    pg.PGStatusID <> 'X'
        AND tr.Reversal <> '1'
        AND(    tr.acct In( 'PIG TRANSFER IN', 'PIG PURCHASE' )                 
                    OR( tr.acct In( 'PIG MOVE IN', 'PIG MOVE OUT', 'PIG INV ADJ' ) 
                            AND tr.trandate <= DATEADD( day, 7, ( SELECT MIN(TranDate) FROM dbo.cftPGInvTran 
                                                                   WHERE PigGroupID=pg.PigGroupID 
                                                                        AND Reversal<>'1' 
                                                                        AND acct IN( 'PIG TRANSFER IN', 'PIG MOVE IN', 'PIG PURCHASE', 'PIG INV ADJ' ) ) ) 
                      )
            )    
                    --and pg.PigGroupID='61642'
GROUP BY 
    pg.PigGroupID
  , pg.ProjectID
  , pg.TaskID ; 
 

