 create procedure PJRESSUM_sProject @parm1 varchar (16)   as
select * from PJRESSUM
where    PJRESSUM.project        =   @parm1
order by project,
PJRESSUM.pjt_entity,
PJRESSUM.acct,
PJRESSUM.resource_type,
PJRESSUM.employee,
PJRESSUM.subcontractor,
PJRESSUM.resource_id


