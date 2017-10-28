 Create Proc BMMfgClass_All @parm1 varchar ( 10) as
            Select * from BMMfgClass where MfgClassId like @parm1
                order by MfgClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMMfgClass_All] TO [MSDSL]
    AS [dbo];

