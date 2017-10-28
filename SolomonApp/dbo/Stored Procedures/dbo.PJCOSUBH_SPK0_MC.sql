 create procedure PJCOSUBH_SPK0_MC @parm1 varchar (16) , @parm2 varchar (16), @parm3 varchar (100), @parm4 varchar (16) 
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJCOSUBH.* from PJCOSUBH
	Inner Join PJPROJ
		ON PJCOSUBH.Project = PJPROJ.project
where
PJCOSUBH.project          LIKE @parm1 and
PJCOSUBH.subcontract      LIKE @parm2 and
pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm3)) and
PJCOSUBH.change_order_num LIKE @parm4
order by project, subcontract, change_order_num


