 create procedure PJPROJ_SDLL  @parm1 varchar (16)   as
select project_desc from PJPROJ
where    project = @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_SDLL] TO [MSDSL]
    AS [dbo];

