 create procedure PJPROJEM_sPK0 @parm1 varchar (16), @parm2 varchar (10)  as
select * from pjprojem
where pjprojem.project  = @parm1 and
      pjprojem.employee = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_sPK0] TO [MSDSL]
    AS [dbo];

