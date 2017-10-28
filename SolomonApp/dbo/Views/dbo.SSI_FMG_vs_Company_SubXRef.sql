 

CREATE VIEW SSI_FMG_vs_Company_SubXRef AS

   SELECT c.CpnyId, c.Active, c.CpnyCOA, c.DatabaseName, s.Sub 
   FROM vs_Company c (NOLOCK) INNER JOIN vs_SubXRef s (NOLOCK) ON c.CpnySub = s.CpnyID


 
