 Create Proc DDSetup_CpnyId @parm1 varchar (10) as
    Select * from DDSetup
     where CpnyId like @parm1
    order by CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDSetup_CpnyId] TO [MSDSL]
    AS [dbo];

