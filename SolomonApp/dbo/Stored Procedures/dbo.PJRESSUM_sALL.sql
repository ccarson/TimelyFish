 create procedure PJRESSUM_sALL @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 varchar (16) , @parm5 varchar (10) , @parm6 varchar (10) , @parm7 varchar (10) as
select pjressum.*,
	pjemploy.*,
	vendor.vendid, vendor.name,
	pjequip.*
from PJRESSUM
	left outer join PJEMPLOY
		on PJRESSUM.employee = PJEMPLOY.employee
	left outer join VENDOR
		on PJRESSUM.subcontractor = VENDOR.VendId
	left outer join PJEQUIP
		on PJRESSUM.resource_id = PJEQUIP.equip_id
where PJRESSUM.project = @parm1 and
	PJRESSUM.pjt_entity = @parm2 and
	PJRESSUM.acct = @parm3 and
	PJRESSUM.resource_type LIKE @parm4 and
	PJRESSUM.employee LIKE @parm5 and
	PJRESSUM.subcontractor LIKE @parm6 and
	PJRESSUM.resource_id LIKE @parm7
order by PJRESSUM.project,
	PJRESSUM.pjt_entity,
	PJRESSUM.acct,
	PJRESSUM.resource_type,
	PJRESSUM.employee,
	PJRESSUM.subcontractor,
	PJRESSUM.resource_id


