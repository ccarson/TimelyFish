 Create Proc Operation_All @parm1 varchar ( 10) as
            Select * from Operation where
			OperationId like @parm1
			order by OperationId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Operation_All] TO [MSDSL]
    AS [dbo];

