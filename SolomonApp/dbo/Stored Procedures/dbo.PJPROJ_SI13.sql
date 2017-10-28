 create procedure PJPROJ_SI13 @parm1 varchar (10)  as
select * from PJPROJ
where manager1 = @parm1
and MSPInterface = 'Y'

order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_SI13] TO [MSDSL]
    AS [dbo];

