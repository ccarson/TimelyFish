﻿ create procedure PJPAYDET_SSUBDET  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4) , @parm4 varchar (4)   as
select * from PJPAYDET, PJSUBDET
where
PJPAYDET.project       =    @parm1 and
PJPAYDET.subcontract   =    @parm2 and
PJPAYDET.payreqnbr = @parm3 and
PJPAYDET.sub_line_item like @parm4 and
( PJPAYDET.project       =    PJSUBDET.project and
PJPAYDET.subcontract   =    PJSUBDET.subcontract and
PJPAYDET.sub_line_item =    PJSUBDET.sub_line_item)
order by PJPAYDET.project, PJPAYDET.subcontract, PJPAYDET.payreqnbr, PJPAYDET.sub_line_item


