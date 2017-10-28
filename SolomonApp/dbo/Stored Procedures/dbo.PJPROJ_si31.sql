 create procedure PJPROJ_si31 @parm1 varchar (24) , @parm2 varchar (1)  as
select * from PJPROJ
where gl_subacct like @parm1
and status_pa  like @parm2
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_si31] TO [MSDSL]
    AS [dbo];

