 create procedure PJPAYDET_SPAYHDR  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4)   as
select * from PJPAYDET, PJPAYHDR
where
PJPAYDET.project       =    @parm1
and  PJPAYDET.subcontract   =    @parm2
and  PJPAYDET.sub_line_item =    @parm3
and  PJPAYDET.project       =    PJPAYHDR.project
and  PJPAYDET.subcontract   =    PJPAYHDR.subcontract
and  PJPAYDET.payreqnbr     =    PJPAYHDR.payreqnbr
order by PJPAYDET.project, PJPAYDET.subcontract, PJPAYDET.payreqnbr, PJPAYDET.sub_line_item


