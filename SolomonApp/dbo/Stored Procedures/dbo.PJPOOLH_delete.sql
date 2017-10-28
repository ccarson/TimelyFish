
create procedure PJPOOLH_delete @CpnyID varchar (6), @Period varchar (6) as
   delete from pjpoolh where cpnyid = @CpnyID and period = @Period

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLH_delete] TO [MSDSL]
    AS [dbo];

