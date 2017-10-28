
create procedure PJPOOLS_delete @GrpId varchar (6), @Period varchar (6) as
	delete from pjpools where GrpId = @GrpId and period = @Period

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLS_delete] TO [MSDSL]
    AS [dbo];

