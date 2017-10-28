 

CREATE VIEW vp_MC_Company_SubXRef AS

   SELECT c.CpnyId, CpnyActive = C.Active, c.CpnyCOA, c.DatabaseName, s.Sub, SubActive = s.Active 
   FROM vs_Company c (NOLOCK) INNER JOIN vs_SubXRef s (NOLOCK) ON c.CpnySub = s.CpnyID


 
