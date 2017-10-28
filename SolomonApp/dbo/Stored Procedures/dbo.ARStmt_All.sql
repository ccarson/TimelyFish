 /****** Object:  Stored Procedure dbo.ARStmt_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARStmt_All @parm1 varchar ( 2) as
    Select * from ARStmt where StmtCycleId like @parm1 order by StmtCycleId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARStmt_All] TO [MSDSL]
    AS [dbo];

