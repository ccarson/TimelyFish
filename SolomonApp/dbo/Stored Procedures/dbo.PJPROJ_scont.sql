 create procedure PJPROJ_scont @parm1 varchar (16)  as
select * from PJPROJ
where contract = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_scont] TO [MSDSL]
    AS [dbo];

