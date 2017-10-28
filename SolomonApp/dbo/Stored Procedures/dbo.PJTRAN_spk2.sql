 create procedure PJTRAN_spk2 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 varchar (6) as
select *
from PJTRAN
	left outer join PJEMPLOY
		on PJTRAN.employee = PJEMPLOY.employee
	left outer join VENDOR
		on PJTRAN.vendor_num = VENDOR.vendid
where PJTRAN.project = @parm1 and
	PJTRAN.pjt_entity = @parm2 and
	PJTRAN.acct = @parm3 and
	PJTRAN.fiscalno like @parm4
order by post_date, trans_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_spk2] TO [MSDSL]
    AS [dbo];

