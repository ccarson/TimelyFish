 Create Procedure SCM_smServCall_OpenInvoice @InvtId VarChar(30)

As

Select top 1 h.*
from smservcall h join smservdetail d on h.ServiceCallID = d.ServiceCallID
where d.invtid = @InvtId
and h.Invoicestatus = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_smServCall_OpenInvoice] TO [MSDSL]
    AS [dbo];

