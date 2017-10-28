 Create Proc BMTool_Active @ToolId varchar ( 10) as
            Select * from Tool where ToolId like @ToolId
			and Status = 'A'
                order by ToolId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMTool_Active] TO [MSDSL]
    AS [dbo];

