 Create Proc WorkCenter_All @parm1 varchar ( 10) as
            Select * from WorkCenter where WorkCenterId like @parm1
                order by WorkCenterId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WorkCenter_All] TO [MSDSL]
    AS [dbo];

