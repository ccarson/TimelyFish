create procedure PJPROJ_sMSPNI_MC @parm1 varchar (10), @parm2 varchar (16)  
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
select * from PJPROJ
where 
CpnyID = @parm1 and
project    like @parm2
and status_pa  =    'A'
and MSPInterface <> 'Y'
order by project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sMSPNI_MC] TO [MSDSL]
    AS [dbo];

