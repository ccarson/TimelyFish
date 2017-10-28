 Create Procedure SMServCall_Invoice_All @parm1 varchar(10) as
select * from SMServCall where InvoiceNumber like @parm1
order by InvoiceNumber



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SMServCall_Invoice_All] TO [MSDSL]
    AS [dbo];

