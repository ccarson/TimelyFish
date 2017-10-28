 create procedure  PJLABDIS_sIK1 @parm1 varchar (6), @parm2 varchar (10)    as
select * from PJLABDIS
where
fiscalno = @parm1 and
CpnyId_home = @parm2 and
status_gl = 'U'
Order by employee



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_sIK1] TO [MSDSL]
    AS [dbo];

