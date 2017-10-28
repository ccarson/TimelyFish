 create procedure PJPROJ_sMSPI @parm1 varchar (16)  as
select * from PJPROJ
where project like @parm1
and MSPInterface = 'Y'
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sMSPI] TO [MSDSL]
    AS [dbo];

