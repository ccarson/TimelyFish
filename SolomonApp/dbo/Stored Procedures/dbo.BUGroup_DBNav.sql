 CREATE PROCEDURE BUGroup_DBNav @Parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10),
@Parm4 varchar ( 24), @Parm5 varchar (47) AS
SELECT * FROM Budget_Group WHERE CpnyId = @Parm1 And
budgetyear = @Parm2 And BudgetLedgerID = @Parm3 And BdgtSegment
= @Parm4 And GroupID Like @Parm5
ORDER BY CpnyID, BudgetYear, BudgetLedgerid, BdgtSegment, GroupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUGroup_DBNav] TO [MSDSL]
    AS [dbo];

