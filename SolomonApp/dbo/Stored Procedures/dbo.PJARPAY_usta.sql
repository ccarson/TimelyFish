 create procedure  PJARPAY_usta @parm1 varchar (1) , @parm2 varchar (15) , @parm3 varchar (2) , @parm4 varchar (10) , @parm5 varchar (10) , @parm6 varchar (2), @parm7 varchar (8), @parm8 varchar (10), @parm9 smalldatetime, @parm10 float  as
update PJARPAY
set status = @parm1, lupd_prog = @parm7, lupd_user = @parm8
where custid =  @parm2 and
doctype = @parm3 and
check_refnbr =  @parm4 and
invoice_refnbr = @parm5 and
invoice_type =  @parm6 and
convert(decimal(28,3), applied_amt) = convert(decimal(28,3), @parm10)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJARPAY_usta] TO [MSDSL]
    AS [dbo];

