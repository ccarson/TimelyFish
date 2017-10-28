 create procedure PJTRAN_spk4 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 varchar (6) as
select PJTRAN.*, PJEMPLOY.emp_name, VENDOR.name, PJTRANEX.*, INVENTORY.descr, PJACCT.id5_sw
from PJTRAN
		left outer join PJEMPLOY
			on PJTRAN.employee = PJEMPLOY.employee
		left outer join VENDOR
			on PJTRAN.vendor_num = VENDOR.vendid
		left outer join PJACCT
			on PJTRAN.acct = PJACCT.acct
	, PJTRANEX
		left outer join INVENTORY
			on PJTRANEX.invtid = INVENTORY.invtid
where PJTRAN.project = @parm1 and
	PJTRAN.pjt_entity like @parm2 and
	PJTRAN.acct like @parm3 and
	PJTRAN.fiscalno like @parm4 and
	PJTRAN.fiscalno = PJTRANEX.fiscalno and
	PJTRAN.system_cd = PJTRANEX.system_cd and
	PJTRAN.batch_id = PJTRANEX.batch_id and
	PJTRAN.detail_num = PJTRANEX.detail_num
order by trans_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_spk4] TO [MSDSL]
    AS [dbo];

