 create procedure PJPROJ_SI50 @parm1 varchar (60)  as
select * from PJPROJ
where project_desc = @parm1
and mspinterface = 'Y'
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_SI50] TO [MSDSL]
    AS [dbo];

