 create procedure PJPROJ_sPK0 @parm1 varchar (16)  as
select * from PJPROJ
where project = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sPK0] TO [MSDSL]
    AS [dbo];

