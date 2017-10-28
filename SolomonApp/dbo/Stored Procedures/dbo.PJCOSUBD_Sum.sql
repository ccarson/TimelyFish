 create procedure PJCOSUBD_Sum  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (16)   as
select
sum(curychange_amt), 
sum(change_units), 
sum(change_amt), 
PJCOSUBD.project, 
PJCOSUBD.subcontract, 
PJCOSUBD.change_order_num
from PJCOSUBD
where
PJCOSUBD.project            =    @parm1 and
PJCOSUBD.subcontract        =    @parm2 and
PJCOSUBD.change_order_num   =    @parm3
GROUP by PJCOSUBD.project,
PJCOSUBD.subcontract,
PJCOSUBD.change_order_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOSUBD_Sum] TO [MSDSL]
    AS [dbo];

