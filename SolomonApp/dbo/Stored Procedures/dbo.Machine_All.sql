 Create Proc Machine_All @parm1 varchar ( 10) as
            Select * from Machine where MachineId like @parm1
                order by MachineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Machine_All] TO [MSDSL]
    AS [dbo];

