 create procedure PJRESTIM_sALL @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 smallint , @parm5 varchar (6) as
select *
from PJRESTIM
	left outer join PJFISCAL
		on PJRESTIM.fiscalno = PJFISCAL.fiscalno
where PJRESTIM.project = @parm1 and
	PJRESTIM.pjt_entity = @parm2 and
	PJRESTIM.acct = @parm3 and
	PJRESTIM.lineid = @parm4 and
	PJRESTIM.fiscalno like @parm5
order by project,
	PJRESTIM.pjt_entity,
	PJRESTIM.acct,
	PJRESTIM.lineid DESC,
	PJRESTIM.fiscalno


