 create procedure PJBILL_SCURY_MC @parm1 varchar(100), @parm2 varchar (4), @parm3 varchar (16)  as
select * from PJBILL, PJPROJ
where PJPROJ.Project = PJBILL.project and
PJPROJ.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm1)) and
PJBILL.billcuryid = @parm2 and
PJBILL.project like @parm3
order by pjbill.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_SCURY_MC] TO [MSDSL]
    AS [dbo];

