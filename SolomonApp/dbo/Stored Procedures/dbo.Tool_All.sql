 Create Proc Tool_All @parm1 varchar ( 10) as
            Select * from Tool where ToolId like @parm1
                order by ToolId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Tool_All] TO [MSDSL]
    AS [dbo];

