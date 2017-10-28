 create procedure pjprojmx_dpk0  @parm1 varchar (16) as
delete from PJPROJMX
where Project = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjprojmx_dpk0] TO [MSDSL]
    AS [dbo];

