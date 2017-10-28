 Create Proc PRServCall_InvtId @parm1 varchar (30) as
        Select * from Inventory
                where InvtId like @parm1
                  and StkItem = 0
                  and InvtType = 'L'
        Order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRServCall_InvtId] TO [MSDSL]
    AS [dbo];

