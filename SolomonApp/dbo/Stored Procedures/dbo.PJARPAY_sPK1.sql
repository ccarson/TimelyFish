 create procedure PJARPAY_sPK1 @parm1 varchar (15) , @parm2 varchar (2) , @parm3 varchar (10) , @parm4 varchar (10) , @parm5 varchar (2)   as
Select * From PJARPAY
Where
custid = @parm1 and
doctype = @parm2 and
check_refnbr = @parm3 and
invoice_refnbr = @parm4 and
invoice_type = @parm5
Order by custid,doctype,check_refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJARPAY_sPK1] TO [MSDSL]
    AS [dbo];

