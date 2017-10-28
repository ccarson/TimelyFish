
Create Proc FlexBill_CreateInvoiceDrafts @parm1 varchar (16) as
        Select Project,status_15,status_16 from PJProj where Project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FlexBill_CreateInvoiceDrafts] TO [MSDSL]
    AS [dbo];

