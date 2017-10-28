 create procedure PJPROJ_si30 @parm1 varchar (24)  as
select * from PJPROJ
where gl_subacct like @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_si30] TO [MSDSL]
    AS [dbo];

