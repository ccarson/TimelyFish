 create procedure PJPAYHDR_SAPDOC  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4)   as
select  PJPAYHDR.*,
VENDOR.vendid,
VENDOR.name,
APDOC.*,
APDOC1.refnbr,
APDOC1.status,
APDOC1.vendid
from    PJPAYHDR
	left outer join VENDOR
		on PJPAYHDR.vendid = VENDOR.vendid
	left outer join APDOC
		on PJPAYHDR.vendid = APDOC.vendid
		and PJPAYHDR.refnbr = APDOC.refnbr
	left outer join APDOC APDOC1
		on PJPAYHDR.vendid = APDOC1.vendid
		and PJPAYHDR.refnbr_ret = APDOC1.refnbr
where
PJPAYHDR.project          =    @parm1 and
PJPAYHDR.subcontract      =    @parm2 and
PJPAYHDR.payreqnbr        like @parm3
order by PJPAYHDR.project, PJPAYHDR.subcontract, PJPAYHDR.payreqnbr


