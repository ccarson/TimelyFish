 

CREATE VIEW SSI_FMG_vs_Company_AcctXRef AS

   SELECT c.CpnyId, c.Active, c.CpnyCOA, c.DatabaseName, a.Acct 
   FROM vs_Company c (NOLOCK) INNER JOIN vs_AcctXRef a (NOLOCK) ON c.CpnyCOA = a.CpnyID


 
