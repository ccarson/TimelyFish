 Create Proc BMMachine_Active @MachId varchar ( 10) as
            Select * from Machine where MachineId like @MachId
			and Status = 'A'
                order by MachineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMMachine_Active] TO [MSDSL]
    AS [dbo];

