 create procedure PJPROJ_salloc @parm1 varchar (16)  as
select * from PJPROJ
where project   =  @parm1 and
status_pa IN ('A','I')
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_salloc] TO [MSDSL]
    AS [dbo];

