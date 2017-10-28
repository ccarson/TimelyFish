 create procedure PJPROJ_scust @parm1 varchar (15), @parm2 varchar (16)  as
select * from PJPROJ
where customer = @parm1
and project like @parm2
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_scust] TO [MSDSL]
    AS [dbo];

