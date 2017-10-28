 Create Proc PRTran_BatNbr_ServCallId @parm1 varchar (10) as
       Select * from PRTran with (nolock)
               where BatNbr            = @parm1
                 and SS_PostFlag       = 'U'
                 and SS_ServiceCallID <> ''
           order by BatNbr,
                    SS_ServiceCallID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_ServCallId] TO [MSDSL]
    AS [dbo];

