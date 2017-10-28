 create procedure PJPROJ_si10 @parm1 varchar (10)  as
select * from PJPROJ
where manager1 = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_si10] TO [MSDSL]
    AS [dbo];

