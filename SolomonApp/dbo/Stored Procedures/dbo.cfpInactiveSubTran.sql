CREATE PROC cfpInactiveSubTran
	AS
	select * from vInactiveSubTran
	ORDER BY CpnyID, Module, BatNbr, Sub


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpInactiveSubTran] TO [MSDSL]
    AS [dbo];

