 create procedure ProjInv_FetchSalesPerInfo @ProjectID varchar (16)  as

  SELECT p.project, p.slsperid, s.CmmnPct
    FROM PJPROJ p WITH(NOLOCK) JOIN Salesperson s WITH(NOLOCK)
                                 ON p.slsperid = s.SlsperId
   WHERE p.project = @ProjectID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_FetchSalesPerInfo] TO [MSDSL]
    AS [dbo];

