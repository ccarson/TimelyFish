
CREATE	PROCEDURE vs_AcctSub_DB_Validate @Acct VARCHAR(10), @Sub VARCHAR(24) AS
SELECT	a.CpnyID, a.Acct, a.Sub FROM vs_AcctSub a INNER JOIN vs_Company c ON c.CpnyID = a.CpnyID
WHERE	c.DatabaseName = DB_NAME() AND a.Acct LIKE @Acct AND a.Sub LIKE @Sub AND a.Active = 1 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_AcctSub_DB_Validate] TO [MSDSL]
    AS [dbo];

