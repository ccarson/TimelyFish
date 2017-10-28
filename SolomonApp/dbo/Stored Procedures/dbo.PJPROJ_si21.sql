 create procedure PJPROJ_si21 @parm1 varchar (10) , @parm2 varchar (1)  as
select * from PJPROJ
where manager2   =    @parm1
and status_pa  like @parm2
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_si21] TO [MSDSL]
    AS [dbo];

