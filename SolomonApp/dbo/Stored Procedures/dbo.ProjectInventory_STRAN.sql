 CREATE PROCEDURE  ProjectInventory_STRAN @parm1 varchar (6)   as

     UPDATE p
        SET pc_status = '2'
       FROM POTran p JOIN POReceipt r
                       ON p.rcptNbr = r.rcptNbr
                     JOIN PJ_Account a
                       ON p.WIP_COGS_Acct = a.gl_Acct 
      WHERE p.perpost = @parm1 
        AND p.purchasetype IN ('PI','PS')
        AND p.pc_status = '1'
        AND r.rlsed = 1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjectInventory_STRAN] TO [MSDSL]
    AS [dbo];

