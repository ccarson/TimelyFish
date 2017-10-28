 create procedure PJPAYDET_SSUBDET2  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4)   as
select * from PJPAYDET, PJSUBDET, PJPROJ
where
PJPAYDET.project       =    @parm1 and
PJPAYDET.subcontract   =    @parm2 and
	PJPAYDET.payreqnbr = @parm3 and
PJPAYDET.project       =    PJSUBDET.project and
PJPAYDET.subcontract   =    PJSUBDET.subcontract and
PJPROJ.Project		   =	PJPAYDET.project and
PJPAYDET.sub_line_item =    PJSUBDET.sub_line_item
order by PJPAYDET.project, PJPAYDET.subcontract, PJPAYDET.payreqnbr, PJPAYDET.sub_line_item


