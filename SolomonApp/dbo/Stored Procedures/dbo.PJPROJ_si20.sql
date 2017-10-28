 create procedure PJPROJ_si20 @parm1 varchar (10)  as
select * from PJPROJ
where manager2 = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_si20] TO [MSDSL]
    AS [dbo];

