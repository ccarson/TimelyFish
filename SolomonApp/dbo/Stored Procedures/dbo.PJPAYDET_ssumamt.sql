 create procedure PJPAYDET_ssumamt  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4), @parm4 varchar (4)   as
select sum(curycurr_total_amt) from PJPAYDET
where
PJPAYDET.project       =    @parm1 and
PJPAYDET.subcontract   =    @parm2 and
	PJPAYDET.sub_line_item = @parm3 and
pjpaydet.payreqnbr <> @parm4


