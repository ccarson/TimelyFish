 create procedure PJPROJEM_sall @parm1 varchar (16), @parm2 varchar (10)  as
select * from pjprojem
where pjprojem.project  = @parm1 and
      pjprojem.employee like @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_sall] TO [MSDSL]
    AS [dbo];

