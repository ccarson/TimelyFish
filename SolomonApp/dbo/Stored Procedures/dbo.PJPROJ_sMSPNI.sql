create procedure PJPROJ_sMSPNI @parm1 varchar (16)  as
select * from PJPROJ
where project    like @parm1
and status_pa  =    'A'
and MSPInterface <> 'Y'
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sMSPNI] TO [MSDSL]
    AS [dbo];

