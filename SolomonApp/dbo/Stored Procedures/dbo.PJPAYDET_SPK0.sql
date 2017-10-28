 create procedure PJPAYDET_SPK0  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4) , @parm4 varchar (4)   as
select * from PJPAYDET
where
PJPAYDET.project       =    @parm1 and
PJPAYDET.subcontract   =    @parm2 and
	PJPAYDET.payreqnbr = @parm3 and
	PJPAYDET.sub_line_item = @parm4
order by PJPAYDET.project, PJPAYDET.subcontract, PJPAYDET.payreqnbr, PJPAYDET.sub_line_item


