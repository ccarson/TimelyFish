
create procedure PJPOOLB_delete @GrpId varchar (6), @Period varchar (6) as
	delete from pjpoolb where GrpId = @GrpId and period = @Period

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLB_delete] TO [MSDSL]
    AS [dbo];

