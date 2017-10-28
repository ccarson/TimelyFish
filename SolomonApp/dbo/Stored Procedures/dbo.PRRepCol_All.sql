 Create Proc PRRepCol_All @parm1 varchar ( 30) as
       Select * from PRRepCol
           where ReportName LIKE @parm1
           order by ReportName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRRepCol_All] TO [MSDSL]
    AS [dbo];

