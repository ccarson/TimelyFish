 Create Proc PRServCall_Invoice @parm1 varchar (10) as
        Select * from smServCall
                where ServiceCallId like @parm1
                  and cmbInvoiceType = 'T'
                  and ServiceCallCompleted = 0
                  and ServiceCallStatus = 'R'
        Order by ServiceCallId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRServCall_Invoice] TO [MSDSL]
    AS [dbo];

